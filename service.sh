#!/system/bin/sh
# AOSP Low-Latency VoIP Fix - service.sh
# Applies real-time priority to audio processes after boot

LOG_FILE="/data/local/tmp/voip_fix_service.log"
echo "$(date): VoIP Fix Service started" > $LOG_FILE

# Wait for boot to complete
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 5
done

# Wait for audio services to fully stabilize (Increased to 30s)
sleep 30

# List of critical audio processes to optimize
# Added variants for different ROM HAL naming conventions
AUDIO_PROCS="audioserver android.hardware.audio.service vendor.audio-hal audio-hal"

# Run optimization in a loop to catch processes that might restart during boot
for attempt in 1 2 3; do
  echo "$(date): Optimization attempt $attempt" >> $LOG_FILE
  for PROC in $AUDIO_PROCS; do
    PIDS=$(pidof $PROC)
    for PID in $PIDS; do
      if [ ! -z "$PID" ]; then
        # -20 is the highest priority for the scheduler
        renice -n -20 -p $PID >> $LOG_FILE 2>&1
        # ionice -c 1 is "Realtime" class for I/O
        ionice -c 1 -n 0 -p $PID >> $LOG_FILE 2>&1
        echo "$(date): Optimized $PROC (PID: $PID)" >> $LOG_FILE
      fi
    done
  done
  # Wait before next attempt
  sleep 20
done

echo "$(date): VoIP Fix Service completed" >> $LOG_FILE
