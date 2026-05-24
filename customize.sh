#!/system/bin/sh
# AOSP Low-Latency VoIP Fix v2.2 (Pro Edition)
# customize.sh - Magisk Module Installation Script

# -----------------------------------------------
# Verify device compatibility before installing
# -----------------------------------------------

EXPECTED_SKU="yupik"
DEVICE_SKU=$(getprop ro.boot.product.vendor.sku)
DEVICE_BOARD=$(getprop ro.board.platform)

ui_print "--------------------------------------------"
ui_print "   AOSP Low-Latency VoIP Fix v2.3-Pro"
ui_print "   For POCO X5 Pro 5G (Redwood / yupik)"
ui_print "--------------------------------------------"
ui_print ""
ui_print "- Detected SKU   : $DEVICE_SKU"
ui_print "- Detected Board : $DEVICE_BOARD"
ui_print ""

# Hard abort if SKU does not match
if [ "$DEVICE_SKU" != "$EXPECTED_SKU" ]; then
    ui_print "! ERROR: Incompatible device detected."
    ui_print "! Expected SKU : $EXPECTED_SKU"
    ui_print "! Found SKU    : $DEVICE_SKU"
    ui_print "! Aborting installation to prevent audio breakage."
    abort "Installation aborted: wrong device SKU."
fi

# Warn if board platform is unexpected (lahaina is the correct platform)
if [ "$DEVICE_BOARD" != "lahaina" ]; then
    ui_print "! Warning: Board platform is '$DEVICE_BOARD', expected 'lahaina'."
    ui_print "! Proceeding, but verify audio works after reboot."
fi

# -----------------------------------------------
# Verify the target config file actually exists
# -----------------------------------------------
TARGET_POLICY="/vendor/etc/audio/sku_yupik/audio_policy_configuration.xml"
TARGET_IOPOLICY="/vendor/etc/audio/sku_yupik/audio_io_policy.conf"

if [ ! -f "$TARGET_POLICY" ]; then
    ui_print "! ERROR: Cannot find $TARGET_POLICY"
    ui_print "! Your ROM may use a different audio config path."
    abort "Installation aborted: target audio config not found."
fi

if [ ! -f "$TARGET_IOPOLICY" ]; then
    ui_print "! WARNING: Cannot find $TARGET_IOPOLICY"
    ui_print "! IO policy fix will not apply - audio_policy_configuration fix only."
fi

# -----------------------------------------------
# All checks passed - install
# -----------------------------------------------
ui_print "- Device verified. Installing files..."
ui_print ""
ui_print "  [1/5] audio_policy_configuration.xml  (FAST flags for voip_rx + voip_tx)"
ui_print "  [2/5] audio_io_policy.conf             (FAST path alignment)"
ui_print "  [3/5] system.prop                      (Latency tuning + Fluence)"
ui_print "  [4/5] service.sh                       (Optimization & Debug Logs)"
ui_print "  [5/5] post-fs-data.sh                  (Early Boot Logging)"
ui_print ""
ui_print "- v2.3 Pro Hotfix Applied:"
ui_print "    * Optimized HAL buffers to 128 samples"
ui_print "    * Hardware AEC Compatibility Fix (removed voip_tx RAW)"
ui_print "    * Qualcomm Fluence Re-enabled (Voice Quality)"
ui_print "    * AAudio MMAP Forced (policy=2)"
ui_print "    * Audio HAL Reniced (-20 priority)"
ui_print ""
ui_print "- Debugging & Logs:"
ui_print "    * Logs saved to /data/local/tmp/voip_fix_debug.log"
ui_print "    * Early logcat: /data/local/tmp/voip_fix_early_logcat.log"
ui_print "    * Boot snippet: /data/local/tmp/voip_fix_boot.log"
ui_print ""
ui_print "- If you get stuck at the Poco screen:"
ui_print "    1. Force reboot into Recovery (Power + Vol+)"
ui_print "    2. Flash the Magisk Uninstaller or delete the module folder"
ui_print "       via TWRP File Manager (/data/adb/modules/low_latency_voip_aosp)"
ui_print ""
ui_print "--------------------------------------------"
ui_print "   Installation complete."
ui_print "--------------------------------------------"
