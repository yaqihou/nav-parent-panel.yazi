# nav-parent-panel.yazi

Navigate between sibling directories in the parent folder without leaving your current directory.

## Description

This plugin allows you to cycle through sibling directories (directories at the same level as your current directory) without having to go up to the parent directory first. You can navigate to the previous or next sibling directory while maintaining your current directory context.

## Features

- **Sibling Navigation**: Move to previous/next directory in the parent folder
- **Seamless Experience**: Navigate without changing your working context
- **Wraparound Support**: Automatically cycles from first to last directory and vice versa
- **Directory-Only Navigation**: Only navigates to directories, skipping files
- **User Feedback**: Clear notifications for navigation status and errors

## Installation

### Using ya pack (Recommended)

```bash
ya pkg add yaqihou/nav-parent-panel
```

### Manual Installation

```bash
cd ~/.config/yazi/plugins
git clone git@github.com:yaqihou/nav-parent-panel.yazi.git
```

## Usage

Add key bindings to your `~/.config/yazi/keymap.toml`:

```toml
[manager]
keymap = [
    # Navigate to previous sibling directory
    { on = "<C-k>", run = "plugin nav-parent-panel prev", desc = "Go to previous sibling directory" },

    # Navigate to next sibling directory
    { on = "<C-j>", run = "plugin nav-parent-panel next", desc = "Go to next sibling directory" },
]
```

### Commands

- `plugin nav-parent-panel prev` - Navigate to the previous sibling directory
- `plugin nav-parent-panel next` - Navigate to the next sibling directory

## Example

Consider this directory structure on the left (parent) panel:
```
/home/user/
├── documents/
├── downloads/     ← current directory
├── music/
└── pictures/
```

If you're currently in `downloads/`:
- Running `prev` will navigate to `documents/`
- Running `next` will navigate to `music/`
- From `documents/`, running `prev` will wrap around to `pictures/`

## Requirements

- Yazi v0.2.5 or later
- The plugin requires a parent directory with multiple subdirectories to function

## Error Handling

The plugin provides clear notifications for various scenarios:
- No parent directory available
- No sibling directories found
- Invalid direction parameter
- No directories found in parent folder

