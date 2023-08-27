#ifndef __TY
#define __TY
#include <vector>
#include <assert.h>
#include "temp.h"
#include "templabel.hpp"
#include <fstream>
#include <iostream>
namespace TY
{
    enum class tyType
    {
        Ty_void,
        Ty_array,
        Ty_int,
        Ty_float,
        Ty_func
    };
    class Type
    {
    public:
        Type *tp;
        std::vector<Type *> param;
        tyType kind;
        int dim;
        int arraysize;
        bool isconst;
        int *ivalue;
        float *fvalue;
        // FIXME
        //  int arity;
        Type() {}
        void show()
        {
            switch (kind)
            {
            case tyType::Ty_void:
                std::cout << "type is void" << std::endl;
                break;
            case tyType::Ty_array:
                std::cout << "type is array" << std::endl;
                break;
            case tyType::Ty_int:
                std::cout << "type is int" << std::endl;
                break;
            case tyType::Ty_float:
                std::cout << "type is float" << std::endl;
                break;
            case tyType::Ty_func:
                std::cout << "type is func" << std::endl;
                break;
            default:
                assert(0);
            }
        }
        Type(Type *t, tyType k, bool _isconst)
        {
            arraysize = 1;
            dim = 1;
            tp = t, kind = k;
            ivalue = 0;
            isconst = _isconst;
        }
        Type(Type *t, tyType k, int *_value, bool _isconst)
        {
            arraysize = 1;
            dim = 1;
            tp = t, kind = k;
            ivalue = _value;
            fvalue = nullptr;
            isconst = _isconst;
        }
        Type(Type *t, tyType k, float *_value, bool _isconst)
        {
            arraysize = 1;
            dim = 1;
            tp = t, kind = k;
            ivalue = nullptr;
            fvalue = _value;
            isconst = _isconst;
        }
        Type(Type *t, tyType k, int *_value, int _dim, bool _isconst)
        {
            assert(t);
            arraysize = _dim * t->arraysize;
            tp = t, kind = k;
            ivalue = _value;
            fvalue = nullptr;
            dim = _dim;
            isconst = _isconst;
        }
        Type(Type *t, tyType k, std::vector<Type *> _param, Type *rtn)
        {
            tp = t, kind = k;
            param = _param;
            tp = rtn;
        }
    };

    static inline Type *intType(int *val, bool _isconst)
    {
        return new TY::Type(0, TY::tyType::Ty_int, val, _isconst);
    }
    static inline Type *voidType() { return new TY::Type(0, TY::tyType::Ty_void, false); }
    //  FIXME
    static inline Type *floatType(float *val, bool _isconst)
    {
        return new TY::Type(0, TY::tyType::Ty_float, val, _isconst);
    }
    static inline Type *arrayType(Type *ty, int _dim, bool _isconst)
    {
        return new TY::Type(ty, TY::tyType::Ty_array, NULL, _dim, _isconst);
    }
    static inline Type *funcType(Type *rtn, std::vector<Type *> _param)
    {
        return new TY::Type(0, TY::tyType::Ty_func, _param, rtn);
    }
    enum class tyEntry
    {
        Ty_local,
        Ty_global,
        Ty_func
    };
    struct Entry
    {
        tyEntry kind;
        Type *ty;
    };
    struct LocVar : public Entry
    {
        Temp_temp temp;
        LocVar(Type *_ty, Temp_temp _temp)
        {
            assert(_ty->kind != tyType::Ty_func && _ty->kind != tyType::Ty_void);
            kind = tyEntry::Ty_local;
            ty = _ty;
            temp = _temp;
        }
    };
    struct GloVar : public Entry
    {
        Temp_label_front label;
        GloVar(Type *_ty, Temp_label_front _label)
        {
            assert(_ty->kind != tyType::Ty_func && _ty->kind != tyType::Ty_void);
            kind = tyEntry::Ty_global;
            ty = _ty;
            label = _label;
        }
    };
    struct EnFunc : public Entry
    {
        Temp_label_front label;
        int stksize;
        EnFunc(Type *_ty, Temp_label_front _label)
        {
            assert(_ty->kind == tyType::Ty_func);
            kind = tyEntry::Ty_func;
            ty = _ty;
            label = _label;
            stksize = 16 * 4;
        }
    };
}; // namespace TY
#endif