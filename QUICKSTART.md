# Quick Start Guide

Get the CLI cheatsheet running in under 60 seconds.

## Option 1: Open Locally (Fastest)

```bash
# Navigate to the repository
cd cli-cheatsheet

# Open in your default browser
open index.html

# Or on Linux
xdg-open index.html

# Or on Windows
start index.html
```

That's it! The site works completely offline.

## Option 2: Local Server

```bash
# Python 3
python3 -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000

# Node.js (if you have npx)
npx http-server

# Then visit: http://localhost:8000
```

## Option 3: Deploy to GitHub Pages

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Add interactive CLI cheatsheet"
   git push origin main
   ```

2. **Enable GitHub Pages**
   - Go to repository Settings
   - Click "Pages" in sidebar
   - Under "Source", select `main` branch and `/ (root)` folder
   - Click "Save"

3. **Access Your Site**
   - Wait 1-2 minutes for deployment
   - Visit: `https://[username].github.io/cli-cheatsheet/`

## Using the Website

### Search Commands
1. Type in the search box at the top
2. Results filter instantly
3. Press `Ctrl+K` to focus search from anywhere
4. Press `Esc` to clear search

### Copy Commands
1. Click any category button (Docker, Linux, etc.)
2. Find the command you need
3. Click "COPY TO BUFFER"
4. Paste into your terminal with `Ctrl+V`

### Navigate Categories
- Click the emoji buttons to switch categories
- All commands are organized by tool/technology
- Each command has a clear description

## Adding Your Own Commands

1. **Open `terminal-db.json` in your editor**

2. **Find the category** (e.g., "docker")

3. **Add a new line** in the `entries` array:
   ```json
   ["your command here", "brief description"]
   ```

4. **Save and reload** your browser

Example:
```json
{
  "systems": {
    "docker": {
      "name": "Docker",
      "glyph": "🐳",
      "entries": [
        ["docker ps", "display running containers"],
        ["docker version", "show Docker version"]
      ]
    }
  }
}
```

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+K` or `Cmd+K` | Focus search field |
| `Esc` | Clear search |
| `Tab` | Navigate between buttons |
| `Enter` | Activate focused button |

## Troubleshooting

### Page doesn't load?
- Make sure `index.html` and `terminal-db.json` are in the same directory
- Try opening in a different browser
- Check browser console for errors (F12)

### Copy doesn't work?
- Use HTTPS or localhost (clipboard API requirement)
- Deploy to GitHub Pages for HTTPS
- Check browser clipboard permissions

### JSON errors?
Validate your JSON:
```bash
python3 -m json.tool terminal-db.json
```

## What's Next?

- Read [CONTRIBUTING.md](CONTRIBUTING.md) to add more commands
- Check [README.md](README.md) for full documentation
- Customize colors by editing CSS in `index.html`
- Share your deployment with your team!

---

**Need Help?** Open an issue on GitHub or check the full README.
