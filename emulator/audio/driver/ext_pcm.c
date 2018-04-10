/*
 * Copyright (C) 2018 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <stdlib.h>

#include "ext_pcm.h"

static pthread_mutex_t ext_pcm_init_lock = PTHREAD_MUTEX_INITIALIZER;
static struct ext_pcm *shared_ext_pcm = NULL;

struct ext_pcm *ext_pcm_open(unsigned int card, unsigned int device,
                             unsigned int flags, struct pcm_config *config) {
  pthread_mutex_lock(&ext_pcm_init_lock);
  if (shared_ext_pcm == NULL) {
    shared_ext_pcm = calloc(1, sizeof(struct ext_pcm));
    pthread_mutex_init(&shared_ext_pcm->lock, (const pthread_mutexattr_t *) NULL);
    shared_ext_pcm->pcm = pcm_open(card, device, flags, config);
  }
  pthread_mutex_unlock(&ext_pcm_init_lock);

  pthread_mutex_lock(&shared_ext_pcm->lock);
  shared_ext_pcm->ref_count += 1;
  pthread_mutex_unlock(&shared_ext_pcm->lock);

  return shared_ext_pcm;
}

int ext_pcm_close(struct ext_pcm *ext_pcm) {
  if (ext_pcm == NULL || ext_pcm->pcm == NULL) {
    return -EINVAL;
  }

  pthread_mutex_lock(&ext_pcm->lock);
  ext_pcm->ref_count -= 1;
  pthread_mutex_unlock(&ext_pcm->lock);

  pthread_mutex_lock(&ext_pcm_init_lock);
  if (ext_pcm->ref_count <= 0) {
    pthread_mutex_destroy(&ext_pcm->lock);
    pcm_close(ext_pcm->pcm);
    free(ext_pcm);
    shared_ext_pcm = NULL;
  }
  pthread_mutex_unlock(&ext_pcm_init_lock);
  return 0;
}

int ext_pcm_is_ready(struct ext_pcm *ext_pcm) {
  if (ext_pcm == NULL || ext_pcm->pcm == NULL) {
    return 0;
  }

  return pcm_is_ready(ext_pcm->pcm);
}

int ext_pcm_write(struct ext_pcm *ext_pcm, const void *data,
                  unsigned int count) {
  if (ext_pcm == NULL || ext_pcm->pcm == NULL) {
    return 0;
  }

  return pcm_write(ext_pcm->pcm, data, count);
}

const char *ext_pcm_get_error(struct ext_pcm *ext_pcm) {
  if (ext_pcm == NULL || ext_pcm->pcm == NULL) {
    return NULL;
  }

  return pcm_get_error(ext_pcm->pcm);
}

unsigned int ext_pcm_frames_to_bytes(struct ext_pcm *ext_pcm,
                                     unsigned int frames) {
  if (ext_pcm == NULL || ext_pcm->pcm == NULL) {
    return -EINVAL;
  }

  return pcm_frames_to_bytes(ext_pcm->pcm, frames);
}
