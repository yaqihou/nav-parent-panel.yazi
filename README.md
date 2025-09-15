# nav-parent-panel.yazi

Navigate between sibling directories in the parent folder without leaving your current directory.

## Description

This plugin allows you to cycle through sibling directories (directories at the same level as your current directory) without having to go up to the parent directory first. You can navigate to the previous or next sibling directory while maintaining your current directory context.

- **Sibling Navigation**: Move to previous/next directory in the parent folder
- **Edge Navigation**: Jump directly to first/last directory in the parent folder
- **Seamless Experience**: Navigate without changing your working context
- **Wraparound**: Automatically cycles from first to last directory and vice versa (for prev/next)
- **Directory-Only Navigation**: Only navigates to directories, skipping files
- **Quiet Mode**: Optional notifications (quiet by default)

## Todo List

- [ ] Add arguments to control if cycle or stop at the edge 

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

## Setup (Optional)

Add this to your `~/.config/yazi/init.lua`:

```lua
require("nav-parent-panel"):setup({
    -- quite = true  -- Enable quiet mode (default: true)
})
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

    # Navigate to first sibling directory
    { on = "<C-Home>", run = "plugin nav-parent-panel first", desc = "Go to first sibling directory" },

    # Navigate to last sibling directory
    { on = "<C-End>", run = "plugin nav-parent-panel last", desc = "Go to last sibling directory" },
]
```

### Commands

- `plugin nav-parent-panel prev` - Navigate to the previous sibling directory
- `plugin nav-parent-panel next` - Navigate to the next sibling directory
- `plugin nav-parent-panel first` - Navigate to the first sibling directory
- `plugin nav-parent-panel last` - Navigate to the last sibling directory

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
- Running `first` will navigate to `documents/` (first directory)
- Running `last` will navigate to `pictures/` (last directory)
- From `documents/`, running `prev` will wrap around to `pictures/`

## Requirements

- Tested on Yazi v25.20 or later
