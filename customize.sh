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
ui_print "   AOSP Low-Latency VoIP Fix v2.2-Pro"
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
ui_print "  [1/4] audio_policy_configuration.xml  (FAST flags for voip_rx + voip_tx)"
ui_print "  [2/4] audio_io_policy.conf             (FAST path + compr_voip alignment)"
ui_print "  [3/4] system.prop                      (HyperOS-IN Parity + MMAP tuning)"
ui_print "  [4/4] service.sh                       (Real-time process priority)"
ui_print ""
ui_print "- v2.2 Pro Features Applied:"
ui_print "    * HyperOS India/Global Parity Flags"
ui_print "    * Fluence Type set to 'None' (DSP-Direct)"
ui_print "    * Hi-Fi Audio Path Enabled"
ui_print "    * AAudio MMAP Forced (policy=2)"
ui_print "    * Audio HAL Reniced (-20 priority)"
ui_print ""
ui_print "- Performance Profile:"
ui_print "    vendor.audio_hal.period_size           = 128"
ui_print "    vendor.audio_hal.period_multiplier     = 2"
ui_print ""
ui_print "- Reboot to apply. Test mic in Free Fire Max / BGMI / PUBG."
ui_print "- If audio breaks, disable module in Magisk and reboot."
ui_print ""
ui_print "--------------------------------------------"
ui_print "   Installation complete."
ui_print "--------------------------------------------"
