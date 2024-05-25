#include "allocReg.h"
using namespace std;
using namespace ASM;
#include <cassert>
#include <stack>
using namespace GRAPH;
#include "printASM.h"
#include "register_rules.h"
#define MYDEBUG() printf("%s:%d\n", __FILE__, __LINE__)

stack<Node<RegInfo> *> reg_stack;
void getAllRegs(AS_stm *stm, vector<AS_reg *> &defs, vector<AS_reg *> &uses)
{
    switch (stm->type)
    {
    case AS_stmkind::BINOP:
        getDefReg(stm->u.BINOP->dst, defs);
        getUseReg(stm->u.BINOP->left, uses);
        getUseReg(stm->u.BINOP->right, uses);
        break;
    case AS_stmkind::MOV:
        getDefReg(stm->u.MOV->dst, defs);
        getUseReg(stm->u.MOV->src, uses);
        break;
    case AS_stmkind::LDR:
        getDefReg(stm->u.LDR->dst, defs);
        getUseReg(stm->u.LDR->ptr, uses);
        break;
    case AS_stmkind::STR:
        getUseReg(stm->u.STR->src, uses);
        getUseReg(stm->u.STR->ptr, uses);
        break;
    case AS_stmkind::CMP:
        getUseReg(stm->u.CMP->left, uses);
        getUseReg(stm->u.CMP->right, uses);
        break;
    case AS_stmkind::ADR:
        getDefReg(stm->u.ADR->reg, defs);
        break;
    default:
        break;
    }
}

void getDefReg(AS_reg *reg, vector<AS_reg *> &defs)
{
    if (!reg)
    {
        return;
    }
    switch (reg->type)
    {
    case AS_type::Xn:
    {
        defs.push_back(reg);
        break;
    }
    case AS_type::ADR:
    {
        assert(0);
    }

    default:
        break;
    }
}
void getUseReg(AS_reg *reg, vector<AS_reg *> &uses)
{
    if (!reg)
    {
        return;
    }
    switch (reg->type)
    {
    case AS_type::Xn:
    {
        uses.push_back(reg);
        break;
    }
    case AS_type::ADR:
    {
        if (reg->u.add->base->type == AS_type::Xn)
        {
            uses.push_back(reg->u.add->base);
        }
        if (reg->u.add->reg)
        {
            uses.push_back(reg->u.add->reg);
        }
        break;
    }

    default:
        break;
    }
}
void vreg_map(AS_reg *reg, unordered_map<int, Node<RegInfo> *> &regNodes)
{
    switch (reg->type)
    {
    case AS_type::Xn:
    {
        int regNo = reg->u.offset;
        if (regNo < 100)
            return;
        reg->u.offset = regNodes[regNo]->info.color;
        break;
    }
    case AS_type::ADR:
    {
        assert(0);
    }
    default:
        break;
    }
};
void forwardLivenessAnalysis(std::list<InstructionNode *> &liveness, std::list<AS_stm *> &as_list)
{
    unordered_map<string, InstructionNode *> blocks;
    for (const auto &stm : as_list)
    {
        InstructionNode *node = new InstructionNode(stm, {}, {}, {}, {});
        liveness.push_back(node);
        vector<AS_reg *> defs;
        vector<AS_reg *> uses;

        switch (stm->type)
        {
        case AS_stmkind::LABEL:
            blocks.emplace(stm->u.LABEL->name, node);
        default:
            getAllRegs(stm, defs, uses);
            break;
        }

        for (auto &x : defs)
        {
            if (x->u.offset >= 100)
            {
                node->def.emplace(x->u.offset);
            }
            assert(x->type != AS_type::ADR);
        }

        for (auto &x : uses)
        {
            if (x->u.offset >= 100)
            {
                node->use.emplace(x->u.offset);
            }
            assert(x->type != AS_type::ADR);
        }
    }
    

    setControlFlowDiagram(liveness, blocks);
    

}
void setControlFlowDiagram(std::list<InstructionNode *> &nodes, unordered_map<string, InstructionNode *> &blocks)
{
    for (auto it = nodes.begin(); it != nodes.end(); ++it)
    {
        InstructionNode *currentNode = *it; // 当前节点
        InstructionNode *nextNode = nullptr;
        auto nextIt = std::next(it); // 获取下一个元素的迭代器
        if (nextIt != nodes.end())
        {
            nextNode = *nextIt; // 如果存在下一个节点，则获取它
        }
        switch (currentNode->raw->type)
        {
        case AS_stmkind::RET:

            break;
        case AS_stmkind::B:
            currentNode->sucessor.emplace(blocks[currentNode->raw->u.B->jump->name]);
            break;
        case AS_stmkind::BCOND:
            currentNode->sucessor.emplace(blocks[currentNode->raw->u.BCOND->jump->name]);
            if (nextNode)
            {
                currentNode->sucessor.emplace(nextNode);
            }
        default:
            if (nextNode)
            {
                currentNode->sucessor.emplace(nextNode);
            }
            break;
        }
    }
}
void init(std::list<InstructionNode *> &nodes, unordered_map<int, Node<RegInfo> *> &regNodes, Graph<RegInfo> &interferenceGraph)
{
    assert(reg_stack.empty());
    bool changed;
    do
    {
        changed = false;
        for (auto it = nodes.rbegin(); it != nodes.rend(); ++it)
        {
            InstructionNode *n = *it;
            n->previous_in = n->in;
            n->previous_out = n->out;

            for (InstructionNode *s : n->sucessor)
            {
                n->out.insert(s->in.begin(), s->in.end());
            }

            std::set<int> diff;
            std::set_difference(n->out.begin(), n->out.end(), n->def.begin(), n->def.end(), std::inserter(diff, diff.end()));
            diff.insert(n->use.begin(), n->use.end());

            n->in = diff;

            if (n->in != n->previous_in || n->out != n->previous_out)
            {
                changed = true;
            }

        }

    } while (changed);
    set<int> regs;

    for (auto &x : nodes)
    {
        regs.insert(x->def.begin(), x->def.end());
        regs.insert(x->use.begin(), x->use.end());
    }

    for (auto x : regs)
    {
        regNodes.insert({x, interferenceGraph.addNode({x, x, 0, 0})});
    }
    for (auto x : nodes)
    {
        std::vector<int> vec(x->in.begin(), x->in.end());
        for (int i = 0; i < vec.size(); i++)
        {
            for (int j = i + 1; j < vec.size(); j++)
            {
                interferenceGraph.addEdge(regNodes[vec[i]], regNodes[vec[j]]);
                interferenceGraph.addEdge(regNodes[vec[j]], regNodes[vec[i]]);
            }
        }
    }

    // 打印干扰图的边,并设置节点度数
    std::cerr << "Interference Graph Edges:" << std::endl;
    auto nodes_ = interferenceGraph.nodes();
    for (auto &nodePair : *nodes_)
    {
        Node<RegInfo> *node = nodePair.second;
        NodeSet *successors = node->succ();
        node->info.degree = successors->size();
        
        std::cerr << "Reg " << node->nodeInfo().regNum << " interferes with "<< successors->size()<<" Regs: ";
        if(successors->size())
        for (int succKey : *successors)
        {
            std::cerr << interferenceGraph.mynodes[succKey]->info.regNum << " ";
        }
        std::cerr << std::endl;
    }
}
static bool is_colored(Node<RegInfo> *node)
{
    if (node->info.color >= 100)
    {
        return false;
    }
    return true;
}
static bool is_all_colored(unordered_map<int, Node<RegInfo> *> &regNodes)
{
    bool x = true;
    int i = 0;
    for (auto node : regNodes)
    {
        if (node.second->info.bit_map)
        {
            continue;
        }
        if (!is_colored(node.second))
        {
            x = false;
            break;
        }
    }
    return x;
}
void livenessAnalysis(std::list<InstructionNode *> &nodes, std::list<ASM::AS_stm *> &as_list)
{
    Graph<RegInfo> interferenceGraph;
    unordered_map<int, Node<RegInfo> *> regNodes;
    init(nodes, regNodes, interferenceGraph);
    


    int x = 0;

    while (!is_all_colored(regNodes))
    {
        x++;
        Simplify(interferenceGraph);
        MYDEBUG();

        P_Spill(interferenceGraph);
    }
        MYDEBUG();

    Select(as_list, interferenceGraph, regNodes);
}
void rm_all_edge(Graph<RegInfo> &ig, Node<RegInfo> *&head)
{
    for (auto x : head->succs)
    {
        if (ig.mynodes[x]->info.bit_map)
            ig.mynodes[x]->info.degree -= 1;
    }
}
void Simplify(Graph<RegInfo> &ig)
{
    bool change = true;
    while (change)
    {
        change = false;
        int i = 0;
        for (auto &x : ig.mynodes)
        {
            // 已经在栈中
            if (x.second->info.bit_map)
            {
                continue;
            }
            // 入栈
            if ((!is_colored(x.second)) && x.second->info.degree < allocateRegs.size())
            {
                reg_stack.push(ig.mynodes[x.first]);
                rm_all_edge(ig, x.second);
                x.second->info.bit_map = true;

                change = true;
            }
        }
    }
}
void P_Spill(Graph<RegInfo> &ig)
{
    int i = 0;
    for (auto &x : ig.mynodes)
    {
        // 已经在栈中
        if (x.second->info.bit_map)
        {
            continue;
        }
        // 入栈
        if ((!is_colored(x.second)) && x.second->info.degree >= allocateRegs.size())
        {
            reg_stack.push(ig.mynodes[x.first]);
            x.second->info.is_spill = true;
            x.second->info.bit_map = true;

            rm_all_edge(ig, x.second);
            break;
        }
    }
        MYDEBUG();

}
// 判断是否可以color，如果可以，返回color的register
bool judge_add(Graph<RegInfo> &interferenceGraph, Node<RegInfo> *&head)
{
    set<int> neighbor;
    for (auto x : head->succs)
    {
        auto reginfo = interferenceGraph.mynodes[x]->info;
        if (!reginfo.bit_map && reginfo.color < 100)
        {
            neighbor.emplace(reginfo.color);
        }
    }
    set<int> result;
    std::set_difference(allocateRegs.begin(), allocateRegs.end(), neighbor.begin(), neighbor.end(),
                        std::inserter(result, result.end()));

    if (!result.empty())
    {
        std::set<int>::iterator it = result.begin();
        int firstElement = *it;
        head->info.color = firstElement;
        return true;
    }
    return false;
}
void color(std::list<ASM::AS_stm *> &as_list, unordered_map<int, Node<RegInfo> *> &regNodes)
{
    for (const auto &stm : as_list)
    {
        vector<AS_reg *> defs;
        vector<AS_reg *> uses;
        getAllRegs(stm, defs, uses);

        for (auto &x : defs)
        {
            vreg_map(x, regNodes);
        }
        for (auto &x : uses)
        {
            vreg_map(x, regNodes);
        }
    }
}
void Select(std::list<ASM::AS_stm *> &as_list, Graph<RegInfo> &interferenceGraph, unordered_map<int, Node<RegInfo> *> &regNodes)
{
    vector<Node<RegInfo> *> t_spill;
    while (reg_stack.size())
    {
        Node<RegInfo> *top_temp = reg_stack.top();
        reg_stack.pop();
        bool res = judge_add(interferenceGraph, top_temp);
        top_temp->info.bit_map = false;
        if (!res)
        {
            // 只有是p_spill的，才会真正spill
            assert(top_temp->info.is_spill);
            t_spill.push_back(top_temp);
        }
    }
    for(auto x : regNodes)
    {
        printf("%d ",x.first);
    }
     printf("\n");
    
        MYDEBUG();

    color(as_list, regNodes);
        MYDEBUG();

    // 处理栈指针

    unordered_map<int, int> tempLayout;

    int temp_offset = 0;
    int sp_offset = t_spill.size() * 8;
    for (auto x : t_spill)
    {
        temp_offset += 8;
        tempLayout.emplace(x->info.regNum, -temp_offset + sp_offset);
    }
    for (auto it = as_list.begin(); it != as_list.end(); /* no increment here */)
    {
        auto currentElement = *it;
        if (currentElement->type == AS_stmkind::BINOP)
        {
            auto binop = currentElement->u.BINOP;
            if (binop->op == AS_binopkind::SUB_ && binop->dst->type == AS_type::SP && binop->left->type == AS_type::SP)
            {
                int imm = binop->right->u.offset;
                imm += temp_offset;
                auto temp = new AS_reg(AS_type::Xn, XXn1);
                it = as_list.insert(it, AS_Mov(new AS_reg(AS_type::IMM, imm), temp));
                currentElement->u.BINOP->right = temp;
                break;
            }
        }
        it++;
    }
    // spill
    
    for (auto it = as_list.begin(); it != as_list.end(); /* no increment here */)
    {
        // 当前元素
        auto currentElement = *it;
        vector<AS_reg *> defs;
        vector<AS_reg *> uses;
        getAllRegs(currentElement, defs, uses);
        vector<int> spillregs{XXn2, XXn3, XXn4};

        // 根据条件在当前元素前面插入新元素
        for (auto &x : uses)
        {
            if (x->u.offset >= 100)
            {
                int abc = spillregs.back();
                spillregs.pop_back();
                auto temp = new AS_reg(AS_type::Xn, XXn1);
                it = as_list.insert(it, AS_Mov(new AS_reg(AS_type::IMM, tempLayout[x->u.offset]), temp));
                ++it;
                AS_reg *ptr = new AS_reg(AS_type::ADR, new AS_address(new AS_reg(AS_type::SP, -1), temp));
                it = as_list.insert(it, AS_Ldr(new AS_reg(AS_type::Xn, abc), ptr));
                ++it;
                x->u.offset = abc;
            }
        }
        // 根据条件在当前元素后面插入新元素

        for (auto &x : defs)
        {
            if (x->u.offset >= 100)
            {
                int abc = spillregs.back();
                spillregs.pop_back();
                auto temp = new AS_reg(AS_type::Xn, XXn2);
                auto newIt = as_list.insert(std::next(it), AS_Mov(new AS_reg(AS_type::IMM, tempLayout[x->u.offset]), temp));

                AS_reg *ptr = new AS_reg(AS_type::ADR, new AS_address(new AS_reg(AS_type::SP, -1), temp));
                as_list.insert(std::next(newIt), AS_Str(new AS_reg(AS_type::Xn, XXn1), ptr));
                x->u.offset = XXn1;
                it++;
                it++;
            }
        }
        ++it;
        // // 根据条件在当前元素前面插入新元素
        // if (shouldInsertBefore(currentElement))
        // {
        //     it = as_list.insert(it, newElementBefore);
        //     // it 现在指向新插入的元素
        //     ++it; // 移动到原来的元素
        // }

        // // 根据条件在当前元素后面插入新元素
        // if (shouldInsertAfter(currentElement))
        // {
        //     auto newIt = as_list.insert(std::next(it), newElementAfter);
        //     // newIt 现在指向新插入的元素
        //     // it 仍然指向当前元素
        // }
    }
    for (auto it = as_list.begin(); it != as_list.end(); /* no increment here */)
    {
        auto currentElement = *it;
        if (currentElement->type == AS_stmkind::MOV && currentElement->u.MOV->src->type == AS_type::IMM)
        {
            int imm = currentElement->u.MOV->src->u.offset;
            if (imm < 0)
            {
                it++;

                continue;
            }
            auto dst = currentElement->u.MOV->dst;
            uint16_t low = imm & 0xFFFF; // 使用掩码保留低16位

            // 取高16位
            uint16_t high = (imm >> 16) & 0xFFFF; // 先右移16位，然后使用掩码保留这16位
            if (high != 0)
            {
                *it = AS_Movz(new AS_reg(AS_type::IMM, high), dst);
                it = as_list.insert(std::next(it), AS_Movk(new AS_reg(AS_type::IMM, low), dst));
            }
        }
        it++;
    }
}