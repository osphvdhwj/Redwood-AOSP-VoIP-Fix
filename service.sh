#!/system/bin/sh
# AOSP Low-Latency VoIP Fix - service.sh
# Applies optimizations and captures debug logs

LOG_FILE="/data/local/tmp/voip_fix_debug.log"
BOOT_LOG="/data/local/tmp/voip_fix_boot.log"

# Function to log with timestamp
log() {
  echo "$(date '+%H:%M:%S')] $1" >> $LOG_FILE
}

log "[service] Waiting for boot to complete..."
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 2
done

log "[service] Boot completed. Capturing environment state..."

# 1. Log all module-related properties
log "[service] Applied System Properties:"
getprop | grep -E "vendor.audio|aaudio|persist.vendor.audio|ro.vendor.audio.sdk" >> $LOG_FILE

# 2. Capture a snapshot of audio-related logs from boot
log "[service] Capturing audioserver logcat snippet..."
logcat -d -s audioserver AudioHAL AudioPolicyManager | tail -n 100 > $BOOT_LOG

# 3. Optimize audio processes
AUDIO_PROCS="audioserver android.hardware.audio.service vendor.audio-hal audio-hal"

log "[service] Starting process optimization..."
for PROC in $AUDIO_PROCS; do
  PIDS=$(pidof $PROC)
  for PID in $PIDS; do
    if [ ! -z "$PID" ]; then
      renice -n -20 -p $PID >> $LOG_FILE 2>&1
      ionice -c 1 -n 0 -p $PID >> $LOG_FILE 2>&1
      # Set CPU affinity to big cores if possible (Redwood: cores 4-7 are big)
      taskset -p f0 $PID >> $LOG_FILE 2>&1
      log "[service] Optimized $PROC (PID: $PID)"
    fi
  done
done

# 4. Final Verification
log "[service] Optimization cycle complete. Module v2.3 active."
log "------------------------------------------------"
