/*
 * Copyright (C) 2012 The Android Open Source Project
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

#define LOG_TAG "audio_hw_generic"
/*#define LOG_NDEBUG 0*/

#include <errno.h>
#include <pthread.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/time.h>
#include <fcntl.h>

#include <cutils/log.h>
#include <cutils/str_parms.h>

#include <hardware/hardware.h>
#include <system/audio.h>
#include <hardware/audio.h>

#define OUT_SAMPLING_RATE 44100
#define OUT_BUFFER_SIZE 4096
#define IN_SAMPLING_RATE 8000
#define IN_BUFFER_SIZE 320


struct generic_audio_device {
    struct audio_hw_device device;
    pthread_mutex_t lock;
    struct audio_stream_out *output;
    struct audio_stream_in *input;
    int fd;
    bool mic_mute;
};


struct generic_stream_out {
    struct audio_stream_out stream;
    struct generic_audio_device *dev;
    audio_devices_t device;
};

struct generic_stream_in {
    struct audio_stream_in stream;
    struct generic_audio_device *dev;
    audio_devices_t device;
};


static uint32_t out_get_sample_rate(const struct audio_stream *stream)
{
    return OUT_SAMPLING_RATE;
}

static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
{
    return -ENOSYS;
}

static size_t out_get_buffer_size(const struct audio_stream *stream)
{
    return OUT_BUFFER_SIZE;
}

static audio_channel_mask_t out_get_channels(const struct audio_stream *stream)
{
    return AUDIO_CHANNEL_OUT_STEREO;
}

static audio_format_t out_get_format(const struct audio_stream *stream)
{
    return AUDIO_FORMAT_PCM_16_BIT;
}

static int out_set_format(struct audio_stream *stream, audio_format_t format)
{
    return -ENOSYS;
}

static int out_standby(struct audio_stream *stream)
{
    return 0;
}

static int out_dump(const struct audio_stream *stream, int fd)
{
    return 0;
}

static int out_set_parameters(struct audio_stream *stream, const char *kvpairs)
{
    return 0;
}

static char * out_get_parameters(const struct audio_stream *stream, const char *keys)
{
    return 0;
}

static uint32_t out_get_latency(const struct audio_stream_out *stream)
{
    return 0;
}

static int out_set_volume(struct audio_stream_out *stream, float left,
                          float right)
{
    return 0;
}

static ssize_t out_write(struct audio_stream_out *stream, const void* buffer,
                         size_t bytes)
{
    return 0;
}

static int out_get_render_position(const struct audio_stream_out *stream,
                                   uint32_t *dsp_frames)
{
    return 0;
}

static int out_add_audio_effect(const struct audio_stream *stream, effect_handle_t effect)
{
    return 0;
}

static int out_remove_audio_effect(const struct audio_stream *stream, effect_handle_t effect)
{
    return 0;
}

static int out_get_next_write_timestamp(const struct audio_stream_out *stream,
                                        int64_t *timestamp)
{
    return 0;
}

static uint32_t in_get_sample_rate(const struct audio_stream *stream)
{
    return IN_SAMPLING_RATE;
}

static int in_set_sample_rate(struct audio_stream *stream, uint32_t rate)
{
    return 0;
}

static size_t in_get_buffer_size(const struct audio_stream *stream)
{
    return IN_BUFFER_SIZE;
}

static audio_channel_mask_t in_get_channels(const struct audio_stream *stream)
{
    return AUDIO_CHANNEL_IN_MONO;
}

static audio_format_t in_get_format(const struct audio_stream *stream)
{
    return AUDIO_FORMAT_PCM_16_BIT;
}

static int in_set_format(struct audio_stream *stream, audio_format_t format)
{
    return -ENOSYS;
}

static int in_standby(struct audio_stream *stream)
{
    return 0;
}

static int in_dump(const struct audio_stream *stream, int fd)
{
    return 0;
}

static int in_set_parameters(struct audio_stream *stream, const char *kvpairs)
{
    return 0;
}

static char * in_get_parameters(const struct audio_stream *stream,
                                const char *keys)
{
    return strdup("");
}

static int in_set_gain(struct audio_stream_in *stream, float gain)
{
    return 0;
}

static ssize_t in_read(struct audio_stream_in *stream, void* buffer,
                       size_t bytes)
{
    return 0;
}

static uint32_t in_get_input_frames_lost(struct audio_stream_in *stream)
{
    return 0;
}

static int in_add_audio_effect(const struct audio_stream *stream, effect_handle_t effect)
{
    return 0;
}

static int in_remove_audio_effect(const struct audio_stream *stream, effect_handle_t effect)
{
    return 0;
}

static int adev_open_output_stream(struct audio_hw_device *dev,
                                   audio_io_handle_t handle,
                                   audio_devices_t devices,
                                   audio_output_flags_t flags,
                                   struct audio_config *config,
                                   struct audio_stream_out **stream_out,
                                   const char *address __unused)
{
    int ret = 0;
    return ret;
}

static void adev_close_output_stream(struct audio_hw_device *dev,
                                     struct audio_stream_out *stream)
{
    return;
}

static int adev_set_parameters(struct audio_hw_device *dev, const char *kvpairs)
{
    return 0;
}

static char * adev_get_parameters(const struct audio_hw_device *dev,
                                  const char *keys)
{
    return strdup("");
}

static int adev_init_check(const struct audio_hw_device *dev)
{
    return 0;
}

static int adev_set_voice_volume(struct audio_hw_device *dev, float volume)
{
    return 0;
}

static int adev_set_master_volume(struct audio_hw_device *dev, float volume)
{
    return -ENOSYS;
}

static int adev_get_master_volume(struct audio_hw_device *dev, float *volume)
{
    return -ENOSYS;
}

static int adev_set_master_mute(struct audio_hw_device *dev, bool muted)
{
    return -ENOSYS;
}

static int adev_get_master_mute(struct audio_hw_device *dev, bool *muted)
{
    return -ENOSYS;
}

static int adev_set_mode(struct audio_hw_device *dev, audio_mode_t mode)
{
    return 0;
}

static int adev_set_mic_mute(struct audio_hw_device *dev, bool state)
{
    return 0;
}

static int adev_get_mic_mute(const struct audio_hw_device *dev, bool *state)
{
    return 0;
}

static size_t adev_get_input_buffer_size(const struct audio_hw_device *dev,
                                         const struct audio_config *config)
{
    return IN_BUFFER_SIZE;
}

static int adev_open_input_stream(struct audio_hw_device *dev,
                                  audio_io_handle_t handle,
                                  audio_devices_t devices,
                                  struct audio_config *config,
                                  struct audio_stream_in **stream_in,
                                  audio_input_flags_t flags __unused,
                                  const char *address __unused,
                                  audio_source_t source __unused)
{
    return 0;
}

static void adev_close_input_stream(struct audio_hw_device *dev,
                                   struct audio_stream_in *stream)
{
    return;
}

static int adev_dump(const audio_hw_device_t *dev, int fd)
{
    return 0;
}

static int adev_close(hw_device_t *dev)
{
    return 0;
}

static int adev_open(const hw_module_t* module, const char* name,
                     hw_device_t** device)
{
    return 0;
}

static struct hw_module_methods_t hal_module_methods = {
    .open = adev_open,
};

struct audio_module HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = AUDIO_MODULE_API_VERSION_0_1,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = AUDIO_HARDWARE_MODULE_ID,
        .name = "Dunny audio HW HAL",
        .author = "The Android Open Source Project",
        .methods = &hal_module_methods,
    },
};
