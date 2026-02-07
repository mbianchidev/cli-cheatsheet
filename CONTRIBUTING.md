# Contributing to CLI Cheatsheet

Thank you for your interest in contributing! This guide will help you add new commands to the cheatsheet.

## Quick Contribution Guide

### 1. Edit the Database

Open `terminal-db.json` and locate the category where you want to add commands.

### 2. Add Your Command

Each command is a simple two-element array:

```json
["the command to run", "brief description of what it does"]
```

**Example:**

```json
{
  "systems": {
    "docker": {
      "name": "Docker",
      "glyph": "🐳",
      "entries": [
        ["docker ps", "display running containers"],
        ["docker images", "list all images"],
        ["YOUR NEW COMMAND HERE", "what it does"]
      ]
    }
  }
}
```

### 3. Guidelines for Good Commands

✅ **Good Command Entries:**
- `["git status", "check repository current state"]`
- `["kubectl get pods -A", "list pods across all namespaces"]`
- `["docker system prune -a", "clean up unused containers and images"]`

❌ **Avoid:**
- Overly complex one-liners that need explanation
- Deprecated or obsolete commands
- Commands with security risks (without warnings)
- Duplicate commands

### 4. Description Best Practices

- Keep descriptions under 60 characters
- Start with a verb (e.g., "display", "create", "remove")
- Be specific about what the command does
- Don't include punctuation at the end
- Use present tense

**Good Descriptions:**
- "list all running containers"
- "remove stopped containers"
- "display real-time logs"

**Bad Descriptions:**
- "Lists all running containers." (punctuation)
- "This command will list containers" (too wordy)
- "ls" (not descriptive enough)

### 5. Add a New Category (Advanced)

If you need a completely new category:

```json
{
  "systems": {
    "terraform": {
      "name": "Terraform",
      "glyph": "🏗️",
      "entries": [
        ["terraform init", "initialize working directory"],
        ["terraform plan", "preview infrastructure changes"],
        ["terraform apply", "create or update infrastructure"]
      ]
    }
  }
}
```

**Category Fields:**
- `name`: Display name (can use spaces and capitals)
- `glyph`: Single emoji to represent the category
- `entries`: Array of command/description pairs

### 6. Test Your Changes

Before submitting:

1. Validate JSON syntax:
   ```bash
   python3 -m json.tool terminal-db.json
   ```

2. Open `index.html` in your browser and verify:
   - New commands appear in the correct category
   - Descriptions are clear and readable
   - Commands can be copied successfully
   - No visual glitches or layout issues

### 7. Submit Your Changes

1. Fork the repository
2. Create a branch: `git checkout -b add-xyz-commands`
3. Make your changes to `terminal-db.json`
4. Test thoroughly
5. Commit: `git commit -m "Add XYZ commands to [category]"`
6. Push: `git push origin add-xyz-commands`
7. Open a Pull Request

## Common Patterns

### Commands with Placeholders

Use `<angle-brackets>` for required values and `[square-brackets]` for optional:

```json
["docker exec -it <container> bash", "open shell in container"]
["git log [--oneline]", "view commit history"]
["kubectl get pods -n <namespace>", "list pods in namespace"]
```

### Commands with Multiple Options

Show the most common form:

```json
["docker logs -f <container>", "stream container logs"]
```

Rather than:
```json
["docker logs [-f|-t|--tail N] <container>", "..."] // Too complex
```

### Piped Commands

Include pipes when they're essential:

```json
["ps aux | grep <process>", "find specific process"]
["docker ps -a | grep exited", "list stopped containers"]
```

## What We're Looking For

**High Priority:**
- Common commands developers use daily
- Commands that solve frequent problems
- Commands that are hard to remember

**Low Priority:**
- Rarely-used advanced options
- Commands with extensive prerequisites
- Tool-specific commands for niche tools

## Questions?

- Open an issue for questions
- Tag @mbianchidev for clarification
- Check existing commands for examples

Thank you for contributing! 🙌
