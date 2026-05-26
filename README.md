# POCO X5 Pro 5G (Redwood) — AOSP Low-Latency VoIP Fix v2.6 (Latency & Ducking Fixed)

A Magisk/KernelSU module to eliminate microphone initialization lag and VoIP
latency in games (Free Fire Max, BGMI, PUBG) on AOSP custom ROMs.

## What's New in v2.6

| Component | v2.5-verified | v2.6 (Latest) |
|---|---|---|
| **AAudio MMAP** | Forced (`policy=2`) | **Relaxed** (`policy=1`) (Prevents Free Fire OpenSL fallback) |
| **AEC / Fluence** | Forced VoiceComm | **Disabled VoiceComm** (Fixes volume ducking/dropping) |
| **Buffer (Out)**| 192 | **192** (Hardware Aligned) |
| **Buffer (In)** | 144 | **144** (Hardware Aligned) |

## Features

- **Zero Latency**: Aligned with hardware-preferred periodicity (192 samples out / 144 samples in).
- **Direct Hardware Path**: Forces `FAST` flags and `MMAP` hardware bypassing.
- **Real-Time HAL**: `service.sh` elevates Audio HAL priority to `renice -20`.
- **HyperOS Parity**: Includes official Xiaomi routing flags (`use.voice.path.for.pcm.voip`) and Hi-Fi audio enablement.
- **Maximum Compatibility**: Preserves Dolby Atmos and BT headset compatibility by avoiding the `RAW` flag on VoIP streams.

## Installation

1. Download the ZIP from the Releases section (or zip this folder).
2. Open **Magisk Manager** or **KernelSU**.
3. Go to the **Modules** tab.
4. Tap **Install from storage** and select the ZIP.
5. Reboot.

## Rollback

Disable or remove the module in Magisk → reboot. No permanent changes are made.

## Compatibility

- **Device:** POCO X5 Pro 5G (codename: Redwood, SKU: yupik, platform: lahaina)
- **ROM:** AOSP-based custom ROMs (crDroid, EvolutionX, LineageOS, etc.)
- **Root:** Magisk (any recent version) or KernelSU
- **Not compatible with:** MIUI / HyperOS (has these fixes natively)

## Notes

- Dolby Atmos and Bluetooth headsets remain fully compatible (`RAW` flag removed
  from `voip_rx` specifically to preserve Dolby processing chain).
- If you also use an `audio_effects.xml` mod to disable Dolby, it remains
  unaffected — this module does not touch effects processing.
- The `customize.sh` will **hard abort** installation if the device SKU is not
  `yupik`, preventing audio breakage on incompatible devices.
