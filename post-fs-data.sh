#!/system/bin/sh
# AOSP Low-Latency VoIP Fix - post-fs-data.sh
# This script runs early in the boot process.

MODDIR=${0%/*}
LOG_FILE="/data/local/tmp/voip_fix_debug.log"
EARLY_LOGCAT="/data/local/tmp/voip_fix_early_logcat.log"

# Initialize/Clear log
echo "--- VoIP Fix Debug Log ($(date)) ---" > $LOG_FILE
echo "[post-fs-data] Module directory: $MODDIR" >> $LOG_FILE

# Start an early logcat in the background to catch HAL crashes
# This will stop once the file reaches 2MB to prevent filling storage
(
  logcat -b all -f $EARLY_LOGCAT -r 2048 -n 1
) &
echo "[post-fs-data] Early logcat started in background (PID: $!)" >> $LOG_FILE

# Log if files exist in the module's system folder
echo "[post-fs-data] Files being overlaid:" >> $LOG_FILE
find "$MODDIR/system" -type f >> $LOG_FILE 2>&1

echo "[post-fs-data] Early init complete." >> $LOG_FILE
