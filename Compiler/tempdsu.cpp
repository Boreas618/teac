#include "tempdsu.h"

using namespace std;

int TempDsu::find(int num)
{
    return pa[num] == num ? num : pa[num] = find(pa[num]);
}

void TempDsu::gen_num_temp_map(AS_block2List bl)
{
    num_temp_map.clear();
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->i->kind == AS_instr_::I_OPER)
            {
                for(auto tl = ins->i->u.OPER.dst;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head->kind == AS_operand_::T_TEMP)
                    {
                        num_temp_map.emplace(tl->head->u.TEMP->num,tl->head->u.TEMP);
                    }
                }
            }
            else if(ins->i->kind == AS_instr_::I_MOVE)
            {
                for(auto tl = ins->i->u.MOVE.dst;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head->kind == AS_operand_::T_TEMP)
                    {
                        num_temp_map.emplace(tl->head->u.TEMP->num,tl->head->u.TEMP);
                    }
                }
            }
        }
    }
}

void TempDsu::unite(int x,int y)
{
    x = find(x);
    y = find(y);
    if(x == y) return;
    if(_size[x] < _size[y])
    {
        swap(x,y);
    }
    pa[y] = x;
    _size[x] += _size[y];
    m[x]->merge(*m[y]);
}

std::shared_ptr<std::unordered_set<Temp_temp>> TempDsu::getSet(int num)
{
    int p = find(num);
    return m[p];
}