# CLI CHEATSHEET

**Interactive terminal command reference** with a retro-futuristic CRT aesthetic. Find, copy, and execute commands instantly.

---

## 🚀 Quick Start

### Local Development

```bash
# Clone repository
git clone https://github.com/mbianchidev/cli-cheatsheet.git
cd cli-cheatsheet

# Open in browser (no build step required)
open index.html

# OR serve with Python
python3 -m http.server 8000
# Navigate to http://localhost:8000
```

### GitHub Pages Deployment

1. Navigate to **Settings** → **Pages** in your GitHub repository
2. Select **Source**: `main` branch, root `/` directory  
3. Save and wait for deployment
4. Access at: `https://[username].github.io/cli-cheatsheet/`

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| **🔍 Live Search** | Filter commands as you type |
| **📋 Quick Copy** | One-click clipboard copy |
| **🎨 CRT Aesthetic** | Retro terminal with scanlines and phosphor glow |
| **⚡ Zero Build** | Pure HTML/CSS/JS, no dependencies |
| **⌨️ Keyboard Shortcuts** | `Ctrl+K` to search, `Esc` to clear |
| **📱 Responsive** | Works on all screen sizes |
| **🌈 8 Categories** | Docker, K8s, Linux, Git, AWS, Helm, Maven, Flutter |

---

## 📝 Adding Commands

All commands are stored in `terminal-db.json`. The structure is straightforward:

### Edit Existing Category

```json
{
  "systems": {
    "docker": {
      "name": "Docker",
      "glyph": "🐳",
      "entries": [
        ["command here", "description of what it does"],
        ["docker ps", "display running containers"],
        ["your new command", "your description"]
      ]
    }
  }
}
```

### Add New Category

```json
{
  "systems": {
    "mynewcategory": {
      "name": "My Tool",
      "glyph": "🔧",
      "entries": [
        ["mytool --help", "show help information"],
        ["mytool run", "execute the tool"]
      ]
    }
  }
}
```

### Data Format

Each category contains:

- **`name`**: Display name shown in UI
- **`glyph`**: Emoji icon for visual identification  
- **`entries`**: Array of `[command, description]` pairs

---

## 🎨 Customization

### Change Color Scheme

Edit CSS variables in `index.html`:

```css
:root {
    --phosphor: #39ff14;  /* Main terminal green */
    --screen: #0d0208;    /* Background */
    --amber: #ffba08;     /* Secondary color */
    --cyan: #00f5ff;      /* Highlight color */
    --purple: #b537f2;    /* Accent */
}
```

### Modify Typography

Change the Google Fonts import:

```html
@import url('https://fonts.googleapis.com/css2?family=YourFont&display=swap');
```

Update font family:

```css
body {
    font-family: 'YourFont', monospace;
}
```

### Disable CRT Effects

Remove the scanlines and vignette:

```css
.monitor::before { display: none; }  /* Remove scanlines */
.monitor::after { display: none; }   /* Remove vignette */
```

---

## 🛠️ Project Structure

```
cli-cheatsheet/
├── index.html              # Main web interface
├── terminal-db.json        # Command database
├── README.md               # Documentation
│
├── docker.sh               # Original Docker commands
├── kubernetes.sh           # Original Kubernetes commands
├── linux.sh                # Original Linux commands
├── git.sh                  # Original Git commands
├── aws.sh                  # Original AWS commands
├── helm.sh                 # Original Helm commands
├── maven.sh                # Original Maven commands
└── flutter.sh              # Original Flutter commands
```

---

## ⌨️ Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+K` / `Cmd+K` | Focus search field |
| `Esc` | Clear search |
| `Tab` | Navigate between buttons |
| `Enter` | Activate focused button |

---

## 🤝 Contributing

### How to Contribute

1. **Fork** this repository
2. **Create** a feature branch: `git checkout -b add-new-commands`
3. **Edit** `terminal-db.json` with your additions
4. **Test** locally by opening `index.html`
5. **Commit**: `git commit -m "Add XYZ commands"`
6. **Push**: `git push origin add-new-commands`
7. **Submit** a Pull Request

### Contribution Guidelines

✅ **DO:**
- Add practical, commonly-used commands
- Keep descriptions concise (under 60 characters)
- Test commands before submitting
- Follow the existing JSON format
- Include examples for complex commands

❌ **DON'T:**
- Add deprecated or obsolete commands
- Include dangerous commands without clear warnings
- Submit commands that require extensive setup
- Break the JSON structure

---

## 📊 Current Stats

**Total Commands**: 134  
**Categories**: 8  
**Lines of Code**: <300  
**Dependencies**: 0  
**Build Time**: 0ms  

---

## 🎯 Philosophy

This project embraces:

- **Simplicity**: No build tools, no frameworks, just HTML/CSS/JS
- **Speed**: Instant load, instant search, instant copy
- **Aesthetics**: Retro-futuristic terminal design that's actually functional
- **Accessibility**: Keyboard navigation and screen reader friendly
- **Maintainability**: Single JSON file for all command data

---

## 🐛 Troubleshooting

### Commands not loading?

Check browser console for errors. Ensure `terminal-db.json` is valid JSON:

```bash
python3 -m json.tool terminal-db.json
```

### Styling broken?

Clear browser cache and hard reload:
- **Chrome/Edge**: `Ctrl+Shift+R` (Windows/Linux) or `Cmd+Shift+R` (Mac)
- **Firefox**: `Ctrl+F5` (Windows/Linux) or `Cmd+Shift+R` (Mac)

### Copy not working?

Modern browsers require HTTPS for clipboard API. Use localhost or deploy to GitHub Pages.

---

## 📜 Original Scripts

The original `.sh` and `.bat` files remain in the repository root. These are the source materials that inspired the interactive web interface.

---

## 🔗 Links

- **Repository**: [github.com/mbianchidev/cli-cheatsheet](https://github.com/mbianchidev/cli-cheatsheet)
- **Issues**: [Report bugs](https://github.com/mbianchidev/cli-cheatsheet/issues)
- **Discussions**: [Join the conversation](https://github.com/mbianchidev/cli-cheatsheet/discussions)

---

## 📄 License

This project is provided as-is without warranty. The original author takes no responsibility for command execution or outcomes. Always understand commands before running them, especially those requiring elevated privileges.

---

## 🙏 Acknowledgments

**Created by**: [mbianchidev](https://github.com/mbianchidev)

**Design Inspiration**: Vintage CRT terminals, phosphor monitors, and 80s sci-fi aesthetics

**Typography**: Cutive Mono (Google Fonts), Orbitron (Google Fonts)

---

**Built with**: Pure HTML, CSS, and JavaScript  
**External Dependencies**: None  
**Framework**: None  
**Bundler**: None  

Just open `index.html` and start copying commands. 🚀
