//
// Created by zhe.zhu on 3/7/2023.
//

#ifndef VFGS_VFGS_H
#define VFGS_VFGS_H

#ifdef _MSC_VER
#define EXPORT_SYMBOL __declspec(dllexport)
#else
#define EXPORT_SYMBOL
#endif

#ifdef __cplusplus
extern "C" {
#endif

EXPORT_SYMBOL unsigned char*  vfgs(unsigned char* py, unsigned char* pu, unsigned char* pc, int h, int w, float grain_strength);

EXPORT_SYMBOL void  free_mem(unsigned char* p);
#ifdef __cplusplus
}
#endif

#endif //VFGS_VFGS_H
