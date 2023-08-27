#ifndef __TEMP_DSU__
#define __TEMP_DSU__

#include <vector>
#include <unordered_set>
#include <unordered_map>
#include <algorithm>
#include <numeric>
#include <memory>
#include "deadce.h"

class TempDsu
{
public:
    explicit TempDsu(int num,AS_block2List bl) : pa(num),_size(num,1)
    {
        std::iota(pa.begin(),pa.end(),0);
        gen_num_temp_map(bl);
        for(int i = 0;i <= num;++i)
        {
            auto s = std::make_shared<std::unordered_set<Temp_temp>>();
            s->emplace(num_temp_map[i]);
            m.emplace(i,s);
        }
    }
    explicit TempDsu() {}
    void unite(int x,int y);
    void gen_num_temp_map(AS_block2List bl);
    int find(int num);
    std::shared_ptr<std::unordered_set<Temp_temp>> getSet(int num);
private:
    std::vector<int> pa,_size;
    std::unordered_map<int,std::shared_ptr<std::unordered_set<Temp_temp>>> m;
    std::unordered_map<int,Temp_temp> num_temp_map;
};


#endif