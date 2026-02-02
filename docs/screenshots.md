# 🐺 Screenshots & Media

```
███████████████████████████████████████████████████████████████████████████████
█      ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗███████╗           █
█      ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║██╔════╝           █
█      ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║███████╗           █
█      ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║╚════██║           █
█      ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║███████║           █
█      ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚══════╝           █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Visual Documentation

This document outlines required screenshots and media for complete documentation.

---

## 📸 Required Screenshots

To properly document this resource, please capture the following screenshots and save them in:

```
docs/assets/screenshots/
```

---

### 1. Startup Console Output
**Filename**: `01_startup_console.png`

**What to Capture**:
- Server console after resource start
- Framework detection message
- Item registration confirmation
- Startup banner

**Expected Content**:
```
[LXR-CleanGun] Detected framework: LXR-Core
[LXR-CleanGun] Registering item: cleanshort (key: cleanshort)
[LXR-CleanGun] All cleaning items registered successfully

███████████████████████████████████████████████████
        🐺 LXR WEAPON CLEANER - Server Started
      Framework: LXR
      Items Registered: 1
      Cooldowns: true
      wolves.land - The Land of Wolves
███████████████████████████████████████████████████
```

---

### 2. Configuration File Structure
**Filename**: `02_config_sections.png`

**What to Capture**:
- Open `config.lua` in code editor
- Show branded header with ASCII art
- Display multiple configuration sections
- Highlight organization and comments

**Key Sections to Show**:
- Resource name protection
- Server information
- Framework configuration
- Cleaning items
- Cooldowns

---

### 3. In-Game Weapon Cleaning
**Filename**: `03_weapon_cleaning.png`

**What to Capture**:
- Player using cleaning item on weapon
- Cleaning animation in progress
- Camera zoomed on weapon
- Cloth prop visible
- Clean UI (no debug overlays)

**How to Capture**:
1. Equip a dirty weapon
2. Use cleaning item from inventory
3. Capture during camera animation
4. Use high graphics settings

---

### 4. Weapon Inspection UI
**Filename**: `04_weapon_inspection.png`

**What to Capture**:
- Weapon inspection UI open
- Weapon stats displayed
- Clean weapon view
- Inspection animation

**How to Capture**:
1. Equip weapon
2. Press Middle Mouse Button or use `/inspect`
3. Wait for stats UI to appear
4. Capture with stats visible

---

### 5. Framework Detection
**Filename**: `05_framework_detection.png`

**What to Capture**:
- Server console showing framework detection
- Multiple frameworks installed (if available)
- Detection priority working correctly
- Clear framework selection message

---

### 6. Notification System
**Filename**: `06_notifications.png`

**What to Capture**:
- Success notification after cleaning
- Cooldown warning notification
- No weapon equipped notification
- Different notification types

**Examples**:
- ✅ "You cleaned your weapon"
- ⚠️ "Please wait before cleaning again"
- ❌ "You need to have a weapon equipped"

---

### 7. TxAdmin Performance Monitor
**Filename**: `07_txadmin_performance.png`

**What to Capture**:
- TxAdmin performance view
- `lxr-cleangun` resource showing 0.00-0.01ms
- Compare with other resources
- Resource list showing resource is running

**How to Capture**:
1. Open TxAdmin
2. Go to Resources → Performance
3. Locate lxr-cleangun
4. Capture performance metrics

---

### 8. Items in Inventory
**Filename**: `08_inventory_items.png`

**What to Capture**:
- Cleaning items in player inventory
- Item icons (if available)
- Item descriptions
- Usable item indicator

**Show**:
- Weapon Cloth (cleanshort)
- Any additional cleaning items
- Item quantities

---

### 9. Admin Commands
**Filename**: `09_admin_commands.png`

**What to Capture**:
- F8 console showing available commands
- `/inspect` command
- `/cleanweap` command
- Command execution and results

---

### 10. Multi-Language Support
**Filename**: `10_languages.png`

**What to Capture**:
- Side-by-side comparison of notifications in different languages
- English, French, Spanish, German, Georgian
- Show `locales/language.lua` file

---

## 🎥 Video Content (Optional)

### Gameplay Video
**Filename**: `gameplay_demo.mp4`

**Content**:
1. Player equips weapon (0-5s)
2. Uses cleaning item (5-15s)
3. Cleaning animation with camera (15-30s)
4. Weapon inspection demo (30-45s)
5. Admin command demonstration (45-60s)

**Length**: 60 seconds  
**Quality**: 1080p minimum  
**Format**: MP4

---

### Installation Tutorial
**Filename**: `installation_guide.mp4`

**Content**:
1. Download resource (0-15s)
2. Rename folder (15-20s)
3. Copy to resources folder (20-30s)
4. Import SQL (30-45s)
5. Edit server.cfg (45-55s)
6. Start server (55-70s)
7. Test in-game (70-90s)

**Length**: 90 seconds  
**Quality**: 1080p minimum  
**Format**: MP4

---

## 📂 Directory Structure

Create this directory structure:

```
docs/
├── assets/
│   ├── screenshots/
│   │   ├── 01_startup_console.png
│   │   ├── 02_config_sections.png
│   │   ├── 03_weapon_cleaning.png
│   │   ├── 04_weapon_inspection.png
│   │   ├── 05_framework_detection.png
│   │   ├── 06_notifications.png
│   │   ├── 07_txadmin_performance.png
│   │   ├── 08_inventory_items.png
│   │   ├── 09_admin_commands.png
│   │   └── 10_languages.png
│   ├── videos/
│   │   ├── gameplay_demo.mp4
│   │   └── installation_guide.mp4
│   └── banners/
│       ├── lxr_banner.png
│       └── wolves_logo.png
└── (documentation files)
```

---

## 🎨 Screenshot Guidelines

### Quality Standards

**Resolution**:
- Minimum: 1920x1080 (1080p)
- Recommended: 2560x1440 (1440p)
- Format: PNG (for clarity)

**Graphics Settings**:
- High or Ultra graphics
- No FPS overlay
- No debug text (unless required)
- Clean UI

**Composition**:
- Center main subject
- Good lighting
- Clear visibility
- Professional appearance

---

### Capture Tools

**Recommended**:
- **Windows**: Windows + Shift + S (Snipping Tool)
- **F12**: Steam screenshot (if applicable)
- **ShareX**: Advanced screenshot tool
- **OBS Studio**: For video recording

**Settings**:
- PNG format for screenshots
- MP4 format for videos
- 60 FPS for video
- High bitrate

---

## 📝 Caption Examples

When sharing screenshots, use these caption formats:

### Example 1: Weapon Cleaning
```markdown
![Weapon Cleaning Animation](docs/assets/screenshots/03_weapon_cleaning.png)
*Player cleaning a revolver with immersive camera animation*
```

### Example 2: Performance
```markdown
![Performance Monitor](docs/assets/screenshots/07_txadmin_performance.png)
*Excellent performance: 0.00ms idle, 0.01ms active*
```

### Example 3: Framework Detection
```markdown
![Framework Detection](docs/assets/screenshots/05_framework_detection.png)
*Automatic framework detection selecting LXR-Core*
```

---

## 🖼️ Banner Images

### Main Banner
**Filename**: `lxr_banner.png`  
**Dimensions**: 1920x400px  
**Content**:
- LXR Weapon Cleaner logo
- ASCII art from config header
- "The Land of Wolves" branding

### Social Media Banner
**Filename**: `social_banner.png`  
**Dimensions**: 1200x630px (Facebook/Discord)  
**Content**:
- Resource name
- Key features (3-4 bullet points)
- wolves.land branding
- Framework icons

---

## 📱 Social Media Assets

### Discord Embed Image
**Filename**: `discord_embed.png`  
**Dimensions**: 800x450px  

**Content**:
```
🐺 LXR WEAPON CLEANER
━━━━━━━━━━━━━━━━━━━━━━━━
✅ Multi-Framework Support
✅ Immersive Animations
✅ Optimized Performance
✅ Easy Installation

The Land of Wolves - wolves.land
```

---

## 🎬 YouTube Thumbnail
**Filename**: `youtube_thumbnail.png`  
**Dimensions**: 1280x720px  

**Content**:
- Large weapon image
- "LXR WEAPON CLEANER" text
- "FREE & OPEN SOURCE" badge
- wolves.land logo

---

## 📊 Feature Comparison Image
**Filename**: `feature_comparison.png`

**Table Format**:
```
Feature               | LXR Weapon Cleaner | Others
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Multi-Framework      | ✅ 7 Frameworks    | ⚠️ 1-2
Performance          | ✅ 0.00ms idle     | ❌ 0.05ms+
Camera Animation     | ✅ Cinematic       | ❌ Basic
Security             | ✅ Server-side     | ⚠️ Client
Cooldown System      | ✅ Advanced        | ⚠️ Basic
Customizable         | ✅ Extensive       | ⚠️ Limited
```

---

## 🔗 References

Include these in README.md:

```markdown
## 📸 Screenshots

![Weapon Cleaning](docs/assets/screenshots/03_weapon_cleaning.png)
*Immersive weapon cleaning with cinematic camera*

![Performance](docs/assets/screenshots/07_txadmin_performance.png)
*Optimized for production servers*

![Framework Detection](docs/assets/screenshots/05_framework_detection.png)
*Automatic multi-framework support*

[View All Screenshots →](docs/screenshots.md)
```

---

## ✅ Screenshot Checklist

Before publishing:

- [ ] All 10 required screenshots captured
- [ ] Screenshots are high quality (1080p+)
- [ ] No FPS overlay or debug text
- [ ] Good lighting and composition
- [ ] Saved in correct directory
- [ ] Filenames match exactly
- [ ] Captions written
- [ ] Referenced in README
- [ ] Video content recorded (optional)
- [ ] Banner images created

---

## 🎯 Usage Rights

All screenshots and media should:
- Be original content
- Not contain copyrighted material
- Follow RedM/FiveM ToS
- Credit The Land of Wolves / iBoss21
- Be free to use and share

---

## 📧 Submission

If you create quality screenshots/videos:

1. Save in proper directory structure
2. Name files exactly as specified
3. Create pull request on GitHub
4. Or share in Discord community

**Community contributions welcome!**

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**

**Great documentation needs great visuals!**
