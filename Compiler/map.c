/** 
 * Copyright (c) 2014 rxi
 *
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the MIT license. See LICENSE for details.
 * https://github.com/rxi/map/blob/master/src/map.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "map.h"




static unsigned map_hash(const char *str) {
  unsigned hash = 5381;
  while (*str) {
    hash = ((hash << 5) + hash) ^ *str++;
  }
  return hash;
}


static map_node_t *map_newnode(const char *key, void *value, int vsize) {
  map_node_t *node;
  int ksize = strlen(key) + 1;
  int voffset = ksize + ((sizeof(void*) - ksize) % sizeof(void*));
  node = (map_node_t *)malloc(sizeof(*node) + voffset + vsize);
  if (!node) return NULL;
  memcpy(node + 1, key, ksize);
  node->hash = map_hash(key);
  node->value = ((char*) (node + 1)) + voffset;
  node->next = NULL;
  memcpy(node->value, value, vsize);
  return node;
}


static int map_bucketidx(map_base_t *m, unsigned hash) {
  /* If the implementation is changed to allow a non-power-of-2 bucket count,
   * the line below should be changed to use mod instead of AND */
  return hash & (m->nbuckets - 1);
}


static void map_addnode(map_base_t *m, map_node_t *node) {
  int n = map_bucketidx(m, node->hash);
  node->next = m->buckets[n];
  m->buckets[n] = node;
}


static int map_resize(map_base_t *m, int nbuckets) {
  map_node_t *nodes, *node, *next;
  map_node_t **buckets;
  int i; 
  /* Chain all nodes together */
  nodes = NULL;
  i = m->nbuckets;
  while (i--) {
    node = (m->buckets)[i];
    while (node) {
      next = node->next;
      node->next = nodes;
      nodes = node;
      node = next;
    }
  }
  /* Reset buckets */
  buckets = (map_node_t**)realloc(m->buckets, sizeof(*m->buckets) * nbuckets);
  if (buckets != NULL) {
    m->buckets = buckets;
    m->nbuckets = nbuckets;
  }
  if (m->buckets) {
    memset(m->buckets, 0, sizeof(*m->buckets) * m->nbuckets);
    /* Re-add nodes to buckets */
    node = nodes;
    while (node) {
      next = node->next;
      map_addnode(m, node);
      node = next;
    }
  }
  /* Return error code if realloc() failed */
  return (buckets == NULL) ? -1 : 0;
}


static map_node_t **map_getref(map_base_t *m, const char *key) {
  unsigned hash = map_hash(key);
  map_node_t **next;
  if (m->nbuckets > 0) {
    next = &m->buckets[map_bucketidx(m, hash)];
    while (*next) {
      if ((*next)->hash == hash && !strcmp((char*) (*next + 1), key)) {
        return next;
      }
      next = &(*next)->next;
    }
  }
  return NULL;
}


void *map_get_(map_base_t *m, const char *key) {
  map_node_t **next = map_getref(m, key);
  return next ? (*next)->value : NULL;
}


int map_set_(map_base_t *m, const char *key, void *value, int vsize) {
  int n, err;
  map_node_t **next, *node;
  /* Find & replace existing node */
  next = map_getref(m, key);
  if (next) {
    memcpy((*next)->value, value, vsize);
    return 0;
  }
  /* Add new node */
  node = map_newnode(key, value, vsize);
  if (node == NULL) goto fail;
  if (m->nnodes >= m->nbuckets) {
    n = (m->nbuckets > 0) ? (m->nbuckets << 1) : 1;
    err = map_resize(m, n);
    if (err) goto fail;
  }
  map_addnode(m, node);
  m->nnodes++;
  return 0;
  fail:
  if (node) free(node);
  return -1;
}


static map_float_t fm;
static float fm_ret;
static float fm_value;
void __built__in__sy_f_init()
{
  map_init(&fm);
}

float __built__in__sy_f_get()
{
  return fm_ret;
}
void __built__in__sy_f_i_set(int func_no,int a1,float value)
{
  char as[100];
  sprintf(as,"%d_%d",func_no,a1);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_i_find(int func_no,int a1)
{
  char as[100];
  sprintf(as,"%d_%d",func_no,a1);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_f_set(int func_no,float a1,float value)
{
  char as[100];
  sprintf(as,"%d_%f",func_no,a1);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_f_find(int func_no,float a1)
{
  char as[100];
  sprintf(as,"%d_%f",func_no,a1);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_ii_set(int func_no,int a1,int a2,float value)
{
  char as[100];
  sprintf(as,"%d_%d_%d",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_ii_find(int func_no,int a1,int a2)
{
  char as[100];
  sprintf(as,"%d_%d_%d",func_no,a1,a2);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_if_set(int func_no,int a1,float a2,float value)
{
  char as[100];
  sprintf(as,"%d_%d_%f",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_if_find(int func_no,int a1,float a2)
{
  char as[100];
  sprintf(as,"%d_%d_%f",func_no,a1,a2);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_fi_set(int func_no,float a1,int a2,float value)
{
  char as[100];
  sprintf(as,"%d_%f_%d",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_fi_find(int func_no,float a1,int a2)
{
  char as[100];
  sprintf(as,"%d_%f_%d",func_no,a1,a2);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_ff_set(int func_no,float a1,float a2,float value)
{
  char as[100];
  sprintf(as,"%d_%f_%f",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_ff_find(int func_no,float a1,float a2)
{
  char as[100];
  sprintf(as,"%d_%f_%f",func_no,a1,a2);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_iii_set(int func_no,int a1,int a2,int a3,float value)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_iii_find(int func_no,int a1,int a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%d",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_iif_set(int func_no,int a1,int a2,float a3,float value)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_iif_find(int func_no,int a1,int a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%f",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_ifi_set(int func_no,int a1,float a2,int a3,float value)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_ifi_find(int func_no,int a1,float a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%d",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_iff_set(int func_no,int a1,float a2,float a3,float value)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_iff_find(int func_no,int a1,float a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%f",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_fii_set(int func_no,float a1,int a2,int a3,float value)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_fii_find(int func_no,float a1,int a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%d",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_fif_set(int func_no,float a1,int a2,float a3,float value)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_fif_find(int func_no,float a1,int a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%f",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_ffi_set(int func_no,float a1,float a2,int a3,float value)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_ffi_find(int func_no,float a1,float a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%d",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_f_fff_set(int func_no,float a1,float a2,float a3,float value)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&fm,p,value);
}
int __built__in__sy_f_fff_find(int func_no,float a1,float a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%f",func_no,a1,a2,a3);
  float *ret = map_get(&fm,as);
  if(ret)
  {
    fm_ret = *ret;
    return 1;
  }
  else
    return 0;
}

static map_int_t im;
static int im_ret;
void __built__in__sy_i_init()
{
  map_init(&im);
}

int __built__in__sy_i_get()
{
  return im_ret;
}

void __built__in__sy_i_i_set(int func_no,int a1,int value)
{
  char as[100];
  sprintf(as,"%d_%d",func_no,a1);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_i_find(int func_no,int a1)
{
  char as[100];
  sprintf(as,"%d_%d",func_no,a1);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_f_set(int func_no,float a1,int value)
{
  char as[100];
  sprintf(as,"%d_%f",func_no,a1);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_f_find(int func_no,float a1)
{
  char as[100];
  sprintf(as,"%d_%f",func_no,a1);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_ii_set(int func_no,int a1,int a2,int value)
{
  char as[100];
  sprintf(as,"%d_%d_%d",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_ii_find(int func_no,int a1,int a2)
{
  char as[100];
  sprintf(as,"%d_%d_%d",func_no,a1,a2);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_if_set(int func_no,int a1,float a2,int value)
{
  char as[100];
  sprintf(as,"%d_%d_%f",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_if_find(int func_no,int a1,float a2)
{
  char as[100];
  sprintf(as,"%d_%d_%f",func_no,a1,a2);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_fi_set(int func_no,float a1,int a2,int value)
{
  char as[100];
  sprintf(as,"%d_%f_%d",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_fi_find(int func_no,float a1,int a2)
{
  char as[100];
  sprintf(as,"%d_%f_%d",func_no,a1,a2);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_ff_set(int func_no,float a1,float a2,int value)
{
  char as[100];
  sprintf(as,"%d_%f_%f",func_no,a1,a2);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_ff_find(int func_no,float a1,float a2)
{
  char as[100];
  sprintf(as,"%d_%f_%f",func_no,a1,a2);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_iii_set(int func_no,int a1,int a2,int a3,int value)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_iii_find(int func_no,int a1,int a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%d",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_iif_set(int func_no,int a1,int a2,float a3,int value)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_iif_find(int func_no,int a1,int a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%d_%d_%f",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_ifi_set(int func_no,int a1,float a2,int a3,int value)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_ifi_find(int func_no,int a1,float a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%d",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_iff_set(int func_no,int a1,float a2,float a3,int value)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_iff_find(int func_no,int a1,float a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%d_%f_%f",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_fii_set(int func_no,float a1,int a2,int a3,int value)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_fii_find(int func_no,float a1,int a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%d",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_fif_set(int func_no,float a1,int a2,float a3,int value)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_fif_find(int func_no,float a1,int a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%f_%d_%f",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_ffi_set(int func_no,float a1,float a2,int a3,int value)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%d",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_ffi_find(int func_no,float a1,float a2,int a3)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%d",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}

void __built__in__sy_i_fff_set(int func_no,float a1,float a2,float a3,int value)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%f",func_no,a1,a2,a3);
  char *p = malloc(strlen(as)+1);
  strcpy(p,as);
  map_set(&im,p,value);
}
int __built__in__sy_i_fff_find(int func_no,float a1,float a2,float a3)
{
  char as[100];
  sprintf(as,"%d_%f_%f_%f",func_no,a1,a2,a3);
  int *ret = map_get(&im,as);
  if(ret)
  {
    im_ret = *ret;
    return 1;
  }
  else
    return 0;
}
