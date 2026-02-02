# 🐺 Installation Guide

```
███████████████████████████████████████████████████████████████████████████████
█      ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗                     █
█      ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║                     █
█      ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║                     █
█      ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║                     █
█      ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗                █
█      ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝                █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Installation Instructions

---

## 📋 Prerequisites

Before installing LXR Weapon Cleaner, ensure you have:

- ✅ A working RedM server
- ✅ One of the supported frameworks (LXR-Core, RSG-Core, VORP Core, etc.) **OR** use Standalone mode
- ✅ Access to your server files
- ✅ Database access (MySQL/MariaDB)

---

## 📦 Step 1: Download the Resource

1. Download the latest release from [GitHub](https://github.com/iBoss21/lxr-cleangun)
2. Extract the archive

---

## 📁 Step 2: Install Resource Files

1. **Rename the folder** to `lxr-cleangun` (exact name required)
2. **Copy the folder** to your server's `resources` directory
3. **Verify the structure**:

```
resources/
└── lxr-cleangun/
    ├── client/
    │   └── main.lua
    ├── server/
    │   └── main.lua
    ├── shared/
    │   └── framework.lua
    ├── locales/
    │   └── language.lua
    ├── docs/
    │   └── (documentation files)
    ├── sql/
    │   └── (database files)
    ├── config.lua
    └── fxmanifest.lua
```

---

## 🗄️ Step 3: Database Setup

Import the appropriate SQL file for your language into your database:

### For LXR-Core / RSG-Core / QBR-Core
```sql
-- Use your framework's item import method or add manually
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) 
VALUES ('cleanshort', 'Weapon Cloth', 10, 1, 'item_standard', 1);
```

### For VORP Core
Choose your language and import the corresponding SQL file:
- `sql/En_cleanitem.sql` - English
- `sql/Fr_cleanitem.sql` - French
- `sql/Es_cleanitem.sql` - Spanish
- `sql/De_cleanitem.sql` - German

**Example (English)**:
```bash
mysql -u username -p database_name < sql/En_cleanitem.sql
```

### For Standalone
No database changes required. You can skip this step.

---

## ⚙️ Step 4: Configure the Resource

1. **Open `config.lua`**
2. **Set your language**:
   ```lua
   Config.Lang = 'en' -- Options: 'en', 'fr', 'es', 'de', 'ka'
   ```

3. **Configure framework detection** (usually keep as 'auto'):
   ```lua
   Config.Framework = 'auto' -- Auto-detect framework
   ```

4. **Add additional cleaning items** (optional):
   ```lua
   Config.Items = {
       cleanshort = {
           dbname = "cleanshort",
           label = "Weapon Cloth"
       },
       cleankit = {
           dbname = "cleankit",
           label = "Advanced Cleaning Kit"
       }
   }
   ```

5. **Adjust cooldowns** (optional):
   ```lua
   Config.Cooldowns = {
       cleanWeapon = 10,    -- 10 seconds between cleanings
       inspectWeapon = 2    -- 2 seconds between inspections
   }
   ```

---

## 🚀 Step 5: Start the Resource

1. **Add to `server.cfg`**:
   ```cfg
   ensure lxr-cleangun
   ```

2. **Start your server** or **restart the resource**:
   ```
   restart lxr-cleangun
   ```

3. **Check console** for successful startup:
   ```
   [LXR-CleanGun] Detected framework: LXR-Core
   [LXR-CleanGun] All cleaning items registered successfully
   [LXR-CleanGun] Server Started
   ```

---

## ✅ Step 6: Verify Installation

### In-Game Testing

1. **Join your server**
2. **Give yourself a cleaning item**:
   - LXR/RSG/QBR: `/giveitem [player_id] cleanshort 5`
   - VORP: `/giveitem cleanshort 5`

3. **Equip a weapon**
4. **Use the cleaning item** from inventory
5. **Verify**:
   - Cleaning animation plays
   - Camera zooms on weapon
   - Weapon is cleaned
   - Item is consumed

6. **Test inspection**:
   - Equip weapon
   - Press **Middle Mouse Button** in weapon wheel
   - OR use `/inspect` command

---

## 🔧 Framework-Specific Notes

### LXR-Core
- Ensure `lxr-core` is started before `lxr-cleangun`
- Items are automatically registered
- No additional dependencies required

### RSG-Core
- Ensure `rsg-core` is started before `lxr-cleangun`
- Items are automatically registered
- Compatible with `rsg-inventory`

### VORP Core
- Ensure `vorp_core` and `vorp_inventory` are started first
- Use the VORP SQL import files
- Legacy event support maintained for compatibility

### Standalone
- No framework required
- Basic chat notifications used
- No inventory integration
- Commands still work

---

## ❓ Troubleshooting

### Resource Won't Start
- ✅ Verify folder name is exactly `lxr-cleangun`
- ✅ Check `fxmanifest.lua` exists
- ✅ Check console for error messages

### Framework Not Detected
- ✅ Ensure your framework resource is started first
- ✅ Check framework name in resource folder
- ✅ Try setting `Config.Framework` manually

### Items Not Working
- ✅ Verify SQL was imported correctly
- ✅ Check item names match in config and database
- ✅ Restart both inventory and lxr-cleangun resources

### No Notifications Showing
- ✅ Verify framework integration is working
- ✅ Check `Config.Lang` matches an available language
- ✅ Test with `/cleanweap` command

---

## 🆘 Support

Need help? Join our community:

- **Discord**: [The Land of Wolves](https://discord.gg/CrKcWdfd3A)
- **GitHub Issues**: [Report Problems](https://github.com/iBoss21/lxr-cleangun/issues)

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**
