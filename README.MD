# Fastboot ROM for OnePlus Pad 2

This repository provides a Fastboot-flashable script. Please follow the steps below to correctly extract, prepare, and flash the ROM to your device.

---

> [!CAUTION]
> This ROM and flashing method are provided as-is, with **no warranties or guarantees**.
> **You are solely responsible** for what you do with your device.
> Flashing firmware can **wipe your data**, and even **brick your phone** if done incorrectly.
> I am **not responsible** for any damage, data loss, or issues that may occur.

---

## Requirements

- A PC with **Windows** or **Linux**
- **Fastboot** tools installed and accessible from terminal or command prompt
- **Unlocked bootloader**
- **Oxygen Updater** app (for downloading full OTA)
- **otadump** tool (for extracting images)

---
### 1. Download this repo
- [Download](https://github.com/OnePlus-Pad-2-development/fastboot_rom/archive/refs/heads/master.zip) and extract

### 2. Download Full ROM

Use [**Oxygen Updater**](https://oxygenupdater.com/) on your device to download the **full OTA ZIP** file.
- Select correct Device (OnePlus Pad 2 in this case) with correct region, Select `Stable (full)` as Update method
- Goto settings, Enable Advanced mode. This will allow you to download the ROM

### 3. Extract Payload
- Transfer the downloaded ROM ZIP to your PC and extract it. (using 7zip or WinRar)
- Upon extraction, you will get `payload.bin`

### 4. Using otadump to extract images from payload.bin
- Setup [otadump](https://github.com/crazystylus/otadump?tab=readme-ov-file#installation)
- Use command `otadump payload.bin` to extract images. A folder named extracted_{date} will be created with images inside
- Move the extracted images to images/ folder of fastboot rom

### 5. Flashing
- Make sure device is in bootloader
- Use `flash.bat` (for windows) or `flash.sh` (for linux) to start flashing
- After flashing is done, Format data from recovery and reboot to system.
