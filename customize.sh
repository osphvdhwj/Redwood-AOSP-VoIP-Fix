# Set to true if you want to skip the default mount process
# These are no longer used in modern Magisk but kept for legacy/clarity
SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false

# Magisk provides ui_print function
ui_print "- Configuring Low-Latency VoIP Fix"
ui_print "- Targeting SKU: yupik"

# Verify SKU
SKU=$(getprop ro.boot.product.vendor.sku)
if [ "$SKU" != "yupik" ]; then
    ui_print "! ERROR: Device SKU is $SKU, not yupik."
    ui_print "! This module is specifically tuned for Redwood/Yupik."
    abort "! Installation aborted: Incompatible device."
fi

ui_print "- Applying AUDIO_OUTPUT_FLAG_FAST to voip_rx"
ui_print "- Applying AUDIO_INPUT_FLAG_FAST to voip_tx"
ui_print "- Installation complete. Reboot to apply changes."
