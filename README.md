# POCO X5 Pro 5G (Redwood) AOSP Low-Latency VoIP Fix

A Magisk/KernelSU module to fix microphone initialization lag and VoIP latency in games (like Free Fire Max, PUBG, BGMI) on AOSP-based custom ROMs for the POCO X5 Pro 5G (Redwood).

## The Issue

When moving from MIUI/HyperOS to an AOSP custom ROM, users often experience audio stutter, lag, or latency the exact moment they turn on their in-game microphone. 

This happens because AOSP often lacks the proprietary Xiaomi audio routing flags that tell the system how to properly utilize the Snapdragon processor's low-latency hardware paths for Voice over IP (VoIP) streams. Without these instructions, Android panics when the mic is activated and reroutes all audio through a much slower software-based mixing pipeline, causing noticeable lag.

## The Fix

This module modifies the device's `audio_policy_configuration.xml` to manually inject the `AUDIO_INPUT_FLAG_FAST` and `AUDIO_OUTPUT_FLAG_FAST` tags into the specific VoIP audio streams (`voip_tx` and `voip_rx`). 

The `AUDIO_OUTPUT_FLAG_RAW` was intentionally omitted in recent versions to ensure maximum compatibility with Bluetooth headsets and signal processing (like Dolby Atmos).


## Installation

1. Download the repository as a ZIP file (or check the Releases section).
2. Open **Magisk Manager** or **KernelSU**.
3. Go to the **Modules** tab.
4. Tap **Install from storage** and select the ZIP file.
5. Reboot your device.

## Compatibility
- **Device:** POCO X5 Pro 5G (Redwood / lahaina platform)
- **ROM:** AOSP-based Custom ROMs
- **Requirements:** Magisk or KernelSU

## Notes
If you previously modified your `audio_effects.xml` to disable Dolby (to reduce processing load), you can keep those modifications. This module only touches the routing policy, not the effects processing.