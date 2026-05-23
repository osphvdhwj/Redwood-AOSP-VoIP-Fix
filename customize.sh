#!/system/bin/sh

# Magisk Module Customization Script

# Set to true if you want to skip the default mount process
SKIPMOUNT=false
# Set to true if you want to skip the default prop files loading
PROPFILE=false
# Set to true if you want to skip the default script files loading
POSTFSDATA=false
# Set to true if you want to skip the default script files loading
LATESTARTSERVICE=false

# Print installation messages
ui_print "- Configuring Low-Latency VoIP Fix"
ui_print "- Targeting SKU: yupik"
ui_print "- Applying AUDIO_OUTPUT_FLAG_FAST to voip_rx"
ui_print "- Applying AUDIO_INPUT_FLAG_FAST to voip_tx"

# Check if the device is indeed a yupik/lahaina variant
SKU=$(getprop ro.boot.product.vendor.sku)
if [ "$SKU" != "yupik" ]; then
    ui_print "! Warning: Device SKU is $SKU, not yupik."
    ui_print "! The fix may not apply if the path differs."
fi

ui_print "- Installation complete. Reboot to apply changes."
