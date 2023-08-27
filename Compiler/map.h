/** 
 * Copyright (c) 2014 rxi
 *
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the MIT license. See LICENSE for details.
 * https://github.com/rxi/map/blob/master/src/map.h
 */

#ifndef MAP_H
#define MAP_H

#include <string.h>

#define MAP_VERSION "0.1.0"

typedef struct map_node_t {
  unsigned hash;
  void *value;
  struct map_node_t *next;
  /* char key[]; */
  /* char value[]; */
} map_node_t;

typedef struct {
  map_node_t **buckets;
  unsigned nbuckets, nnodes;
} map_base_t;

typedef struct {
  unsigned bucketidx;
  map_node_t *node;
} map_iter_t;


#define map_t(T)\
  struct { map_base_t base; T *ref; T tmp; }
  

#define map_init(m)\
  memset(m, 0, sizeof(*(m)))


#define map_get(m, key)\
  ( (m)->ref = map_get_(&(m)->base, key) )


#define map_set(m, key, value)\
  ( (m)->tmp = (value),\
    map_set_(&(m)->base, key, &(m)->tmp, sizeof((m)->tmp)) )

void *map_get_(map_base_t *m, const char *key);
int map_set_(map_base_t *m, const char *key, void *value, int vsize);

typedef map_t(int) map_int_t;
typedef map_t(float) map_float_t;

void __built__in__sy_i_init();
void __built__in__sy_i_set(int func_no,int count,int flag,int value,...);
int __built__in__sy_i_find(int func_no,int count,int flag,...);
int __built__in__sy_i_get();

#endif