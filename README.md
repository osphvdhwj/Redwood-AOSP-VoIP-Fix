# POCO X5 Pro 5G (Redwood) AOSP Low-Latency VoIP Fix

A Magisk/KernelSU module to fix microphone initialization lag and VoIP latency in games (like Free Fire Max, PUBG, BGMI) on AOSP-based custom ROMs for the POCO X5 Pro 5G (Redwood).

## The Issue

When moving from MIUI/HyperOS to an AOSP custom ROM, users often experience audio stutter, lag, or latency the exact moment they turn on their in-game microphone. 

This happens because AOSP often lacks the proprietary Xiaomi audio routing flags that tell the system how to properly utilize the Snapdragon processor's low-latency hardware paths for Voice over IP (VoIP) streams. Without these instructions, Android panics when the mic is activated and reroutes all audio through a much slower software-based mixing pipeline, causing noticeable lag.

## The Fix

This module implements multiple layers of audio tuning to match the behavior of official HyperOS/MIUI firmware:

1.  **Routing Policy**: Modifies `audio_policy_configuration.xml` to inject `AUDIO_INPUT_FLAG_FAST` and `AUDIO_OUTPUT_FLAG_FAST` into VoIP streams.
2.  **ALSA Mixer Paths**: Injects hardware-level routing improvements into `mixer_paths_yupikidp.xml` for low-latency recording.
3.  **Platform Info**: Includes `audio_platform_info_yupikidp.xml` for consistent PCM mapping.
4.  **System Properties**: Sets critical `vendor.audio.*` and `aaudio.*` flags in `system.prop` to enable features like `kpi_optimize` and `compr_voip`.

This combination ensures that the Android audio framework, the Qualcomm HAL, and the underlying hardware DSP all work together in a low-latency "FAST" mode, eliminating the microphone initialization lag common on AOSP ROMs.


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