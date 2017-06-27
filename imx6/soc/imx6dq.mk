#
# SoC-specific compile-time definitions.
#

BOARD_SOC_TYPE := IMX6DQ
BOARD_HAVE_VPU := true
HAVE_FSL_IMX_GPU2D := true
HAVE_FSL_IMX_GPU3D := true
HAVE_FSL_IMX_IPU := true
HAVE_FSL_IMX_PXP := false
BOARD_KERNEL_BASE := 0x14000000
LOAD_KERNEL_ENTRY := 0x10008000
-include external/fsl_vpu_omx/codec_env.mk
-include external/fsl_imx_omx/codec_env.mk
TARGET_GRALLOC_VERSION := v2
TARGET_HIGH_PERFORMANCE := true
TARGET_HWCOMPOSER_VERSION = v1.3
TARGET_HAVE_VIV_HWCOMPOSER = true
TARGET_FSL_IMX_2D := GPU2D
USE_OPENGL_RENDERER := true
TARGET_CPU_SMP := true

