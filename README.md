# ⌨️ GNOME + Kanata — Full Keyboard-Driven Workflow

> Four layers, home-row modifiers, and native GNOME window-management integration.
> No mouse required.

---

## What is this?

A complete Kanata configuration that turns a standard keyboard into a
keyboard-driven GNOME control surface. Features:

- **Home-row modifiers** — tap for letters, hold for Super/Alt/Ctrl/Shift
- **Four layers** — Base, Symbols, Windows/Workspaces, Text Editing
- **Spatial window positioning** — 3×3 grid to snap windows to corners/edges/center
- **Mouse wheel emulation** — scroll with HJKL
- **Media controls** on the F-row (hold to activate)

**Key concepts:**

| Concept      | What it means                                                                                               |
| ------------ | ----------------------------------------------------------------------------------------------------------- |
| **Tap-hold** | A key sends its normal character when tapped, but acts as a modifier (Ctrl, Alt, Super) when held           |
| **Layer**    | A virtual keymap activated while a modifier is held. Release the modifier and you're back to the base layer |
| **Alias**    | A named shortcut for a complex key sequence or tap-hold definition                                          |

**Timing:** `tap-time 200ms`, `hold-time 200ms` — quick taps register as normal
keys; holds longer than 200ms activate the modifier/layer.

---

## Installation

### NixOS (Declarative)

1. Copy `nixos/kanata.nix` into your NixOS configuration and import it.
2. Copy `nixos/gnome-keybindings.nix` into your Home Manager configuration
   (it uses `dconf.settings` and requires Home Manager).
3. Rebuild:

```bash
sudo nixos-rebuild switch --flake .#yourHost
```

The Kanata service auto-starts on boot. No manual `systemctl` needed.

### Other Linux Distros (Manual)

1. **Install Kanata** following the official instructions:
   <https://github.com/jtroo/kanata>

2. **Ensure your user can access input devices.** Kanata needs to read from
   `/dev/input/event*`. Most distros require your user to be in the `input`
   group:

```bash
sudo usermod -aG input $USER
# Log out and back in for this to take effect
```

3. **Copy the config:**

```bash
mkdir -p ~/.config/kanata
cp standard/kanata.kbd ~/.config/kanata/
```

3. **Set GNOME keybindings** (required for spatial positioning):

```bash
chmod +x standard/setup-gnome-keybindings.sh
./standard/setup-gnome-keybindings.sh
```

4. **Run Kanata:**

```bash
# One-shot (stops when you close the terminal)
kanata --cfg ~/.config/kanata/kanata.kbd

# Or install as a systemd user service:
cp standard/kanata.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
```

5. **Verify it's running:**

```bash
systemctl --user status kanata.service
```

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│  BASE LAYER (Layer 1) — Everyday typing                     │
│  ├─ Home row = tap-hold modifiers (S=Super, D=Alt, F=Ctrl)  │
│  ├─ Thumb keys = layer triggers (Space=L2, Win=L3, Ctrl=L4) │
│  ├─ F-row = media & system controls (hold to activate)      │
│  └─ Number row = shifted symbols on hold                    │
│                                                             │
│  LAYER 2 — Symbols (hold Space)                             │
│  └─ Full symbol layer: !@#$%^*&*()_+ {}[]|\\\                │
│                                                             │
│  LAYER 3 — Windows & Workspaces (hold Left Meta/S key)      │
│  └─ Spatial positioning, workspace nav, window snapping     │
│                                                             │
│  LAYER 4 — Text Editing (hold Left Ctrl)                    │
│  └─ Mouse wheel emulation, arrow keys, word deletion        │
└─────────────────────────────────────────────────────────────┘
```

---

## Layer 1 — Base Layer (Daily Typing)

This is your normal QWERTY layout, but with **dual-function keys** on the home
row and thumb cluster.

### Home Row Tap-Hold Modifiers

The home row keys act as normal letters when tapped, but as modifiers when held:

| Key   | Tap | Hold (modifier)              |
| ----- | --- | ---------------------------- |
| **A** | `a` | **Left Shift**               |
| **S** | `s` | **Left Super** (Windows key) |
| **D** | `d` | **Left Alt**                 |
| **F** | `f` | **Left Ctrl**                |
| **H** | `h` | **~** (Shift+`)              |
| **J** | `j` | **Right Ctrl**               |
| **K** | `k` | **Right Alt**                |
| **L** | `l` | **Right Super**              |
| **;** | `;` | **Right Shift**              |

**How to use:** Type normally — the keys register as letters. Need to press
`Super+T` to open a terminal? Hold **S** and tap **T**.

> ⚠️ **Timing matters:** If you hold S for longer than 200ms before pressing T,
> it registers as `Super+T`. If you tap and release quickly, it's just `s`.

### Thumb Cluster

| Key                   | Tap        | Hold                                |
| --------------------- | ---------- | ----------------------------------- |
| **Left Alt**          | Backspace  | Delete                              |
| **Right Alt**         | Enter      | Right Alt                           |
| **Space**             | Space      | **Layer 2** (Symbols + Programming) |
| **Left Meta (S key)** | Left Super | **Layer 3** (Windows/Workspaces)    |
| **Left Ctrl**         | Left Ctrl  | **Layer 4** (Editing)               |

### Number Row — Shifted Symbols on Hold

Hold any number key to get its shifted symbol:

| Key | Tap     | Hold   |
| --- | ------- | ------ |
| `   | `` ` `` | **~**  |
| 1   | `1`     | **!**  |
| 2   | `2`     | **@**  |
| 3   | `3`     | **#**  |
| 4   | `4`     | **$**  |
| 5   | `5`     | **%**  |
| 6   | `6`     | **^**  |
| 7   | `7`     | **&**  |
| 8   | `8`     | **\*** |
| 9   | `9`     | **(**  |
| 0   | `0`     | **)**  |
| -   | `-`     | **\_** |
| =   | `=`     | **+**  |

### Top Row — Ctrl+Shortcuts on Hold

| Key   | Tap | Hold                   |
| ----- | --- | ---------------------- |
| **Q** | `q` | **Ctrl+Q** (quit app)  |
| **W** | `w` | **Ctrl+W** (close tab) |
| **E** | `e` | **Ctrl+E**             |
| **R** | `r` | **Ctrl+R** (reload)    |
| **T** | `t` | **Ctrl+T** (new tab)   |

### Navigation Row (Y, U, I, O)

| Key   | Tap | Hold          |
| ----- | --- | ------------- |
| **Y** | `y` | **Home**      |
| **U** | `u` | **Page Down** |
| **I** | `i` | **Page Up**   |
| **O** | `o` | **End**       |

### Media Controls (P, [, ], ;, ')

| Key   | Tap | Hold               |
| ----- | --- | ------------------ |
| **P** | `p` | **Play/Pause**     |
| **[** | `[` | **Previous Track** |
| **]** | `]` | **Next Track**     |
| **;** | `;` | **Scroll Left**    |
| **'** | `'` | **Scroll Right**   |

### Bottom Row — Cut/Copy/Paste on Hold

| Key   | Tap | Hold               |
| ----- | --- | ------------------ |
| **Z** | `z` | **Ctrl+Z** (undo)  |
| **X** | `x` | **Ctrl+X** (cut)   |
| **C** | `c` | **Ctrl+C** (copy)  |
| **V** | `v` | **Ctrl+V** (paste) |

### F-Row System Controls

Hold any F-key to activate its secondary function:

| Key     | Tap         | Hold                    |
| ------- | ----------- | ----------------------- |
| **F1**  | F1          | Quake terminal dropdown |
| **F2**  | F2 (rename) | Run command (Alt+F2)    |
| **F3**  | F3          | Decrease brightness     |
| **F4**  | F4          | Increase brightness     |
| **F5**  | F5          | Toggle mute             |
| **F6**  | F6          | Volume down             |
| **F7**  | F7          | Volume up               |
| **F8**  | F8          | Toggle microphone       |
| **F9**  | F9          | Screenshot              |
| **F10** | F10         | Lock screen             |

> **Note:** The hold actions for brightness (F3/F4) and volume/mic (F5–F8) send
> key combinations (`Ctrl+Meta+Down/Up`, `Alt+F5`–`Alt+F8`) that are **not bound
> by default in GNOME**. If these hold actions don't work out of the box, bind
> them manually in GNOME Settings → Keyboard → Custom Shortcuts, or edit the
> Kanata aliases to send different combos.
>
> **F1 hold** requires the
> [Quake Terminal](https://extensions.gnome.org/extension/7604/quake-terminal/)
> GNOME extension.

---

## Layer 2 — Symbols (Hold Space)

Activated by **holding Space**. Release Space to return to Layer 1.

```
┌──────────────────────────────────────────────┐
│  caps  F1   F2   F3   F4   F5   F6   F7... │  (F-row unchanged)
├──────────────────────────────────────────────┤
│  -     -    -    €    £    -    -    -    -  -    -    -    -   bspc
│  tab   !    @    #    $    %    0    (    )    {    }    [    ]    \\
│  esc   ^    &    *    /    `    ~    \    :    "    ...            ret
│        -    +    _    =    \    <    >    ,    .    ?
└──────────────────────────────────────────────┘
```

This layer gives you full access to programming symbols without reaching for
Shift. Hold Space and type:

- **Euro symbol:** Hold Space + 3 → `€`
- **Pound Symbol :** Hold Space + 4 → `£`
- **Round braces:** Hold Space + U or I → `(` or `)`
- **Curly braces:** Hold Space + O or P → `{` or `}`
- **Pipe:** Hold Space + J → `|`

---

## Layer 3 — Windows & Workspaces (Hold Left Meta / S key)

This is the **GNOME integration layer**. Hold the **Left Meta key** (bound to S
via `@ss`) to activate this layer. It's designed to make GNOME feel like a
tiling window manager.

### Spatial Window Positioning — Left-Hand 3×3 Grid

The left-hand Q/W/E, A/S/D, Z/X/C keys form a spatial positioning pad:

```
      Q          W          E
   ┌────────┬──────────┬────────┐
   │  NW    │   Top    │  NE    │
   │ corner │   edge   │ corner │
   ├────────┼──────────┼────────┤
A  │  Left  │  Center  │ Right  │  D
   │  edge  │    S     │  edge  │
   ├────────┼──────────┼────────┤
   │  SW    │  Bottom  │  SE    │
   │ corner │   edge   │ corner │
   └────────┴──────────┴────────┘
      Z          X          C
```

**Modifiers sent:** `Super+Ctrl+...` — these map to GNOME's native
window-positioning actions (configured by `setup-gnome-keybindings.sh` on non-NixOS).

| Key   | Action                      | GNOME Shortcut         |
| ----- | --------------------------- | ---------------------- |
| **Q** | Move to top-left corner     | Super+Ctrl+Shift+Left  |
| **W** | Move to top edge            | Super+Ctrl+Up          |
| **E** | Move to top-right corner    | Super+Ctrl+Shift+Right |
| **A** | Move to left edge           | Super+Ctrl+Left        |
| **S** | Center window               | Super+Ctrl+C           |
| **D** | Move to right edge          | Super+Ctrl+Right       |
| **Z** | Move to bottom-left corner  | Super+Ctrl+Shift+Down  |
| **X** | Move to bottom edge         | Super+Ctrl+Down        |
| **C** | Move to bottom-right corner | Super+Ctrl+Shift+Up    |

**Example workflow:**

1. Open two terminals
2. Hold S (Left Meta), press **A** → first terminal snaps to left half
3. Hold S, press **D** → second terminal snaps to right half
4. Hold S, press **Q** → first terminal moves to top-left quadrant
5. Hold S, press **C** → second terminal moves to bottom-right quadrant

### Window Snapping — Right-Hand Keys (H, J, K, L)

| Key   | Action             | GNOME Shortcut |
| ----- | ------------------ | -------------- |
| **H** | Snap to left       | Super+Left     |
| **J** | Restore/unmaximize | Super+Down     |
| **K** | Maximize           | Super+Up       |
| **L** | Snap to right      | Super+Right    |

These are the classic half-screen snaps, accessible while holding the layer.

### Workspace Navigation — Y, [, ], O

| Key   | Action                       | GNOME Shortcut |
| ----- | ---------------------------- | -------------- |
| **Y** | Switch to first workspace    | Super+Home     |
| **[** | Switch to previous workspace | Super+PageUp   |
| **]** | Switch to next workspace     | Super+PageDown |
| **O** | Switch to last workspace     | Super+End      |

### Move Windows Between Workspaces/Monitors — N, M, ,, .

| Key   | Action                         | GNOME Shortcut       |
| ----- | ------------------------------ | -------------------- |
| **N** | Move window to monitor left    | Shift+Super+Left     |
| **M** | Move window to workspace left  | Shift+Super+PageUp   |
| **,** | Move window to workspace right | Shift+Super+PageDown |
| **.** | Move window to monitor right   | Shift+Super+Right    |

### Media Controls (Still Active)

**P**, **;**, **'** remain active for play/pause and scrolling even in Layer 3.

### Special: F12 = Reload Kanata Config

While in Layer 3, tapping **F12** sends `lrld` — Kanata's live-reload command.
Useful when iterating on this config.

---

## Layer 4 — Text Editing (Hold Left Ctrl)

Activated by **holding Left Ctrl**. This layer transforms the right side of the
keyboard into text-editing tools.

### Mouse Wheel Emulation (H, J, K, L)

| Key   | Action            |
| ----- | ----------------- |
| **H** | Mouse wheel left  |
| **J** | Mouse wheel down  |
| **K** | Mouse wheel up    |
| **L** | Mouse wheel right |

### Arrow Keys (Replaces H/J/K/L on home row)

In Layer 4, the actual **arrow keys** are available on the home row right side —
for terminals and editors that don't support mouse wheel.

### Word Deletion (M, ,, .)

| Key   | Action                                |
| ----- | ------------------------------------- |
| **M** | Delete word backward (Ctrl+Backspace) |
| **,** | Delete word forward (Alt+Delete)    |
| **.** | Delete to beginning of line (Ctrl+U)  |
| **[** | Delete to end of line (Ctrl+K)        |

---

## Quick Reference Card

### Layer Activation

| Hold Key              | Layer   | Purpose              |
| --------------------- | ------- | -------------------- |
| **Space**             | Layer 2 | Symbols              |
| **S key (Left Meta)** | Layer 3 | Windows & Workspaces |
| **Left Ctrl**         | Layer 4 | Text Editing         |

### Most-Used Combos

| Action                            | How                     |
| --------------------------------- | ----------------------- |
| **Snap window left**              | Hold S, tap H           |
| **Snap window right**             | Hold S, tap L           |
| **Maximize**                      | Hold S, tap K           |
| **Center window**                 | Hold S, tap S (spatial) |
| **Next workspace**                | Hold S, tap ]           |
| **Prev workspace**                | Hold S, tap [           |
| **Move window to next workspace** | Hold S, tap ,           |
| **New terminal**                  | Hold S, tap T           |
| **Close tab**                     | Hold F, tap W           |
| **Play/Pause**                    | Tap P (hold)            |
| **Volume up**                     | Hold F7                 |
| **Screenshot**                    | Hold F9                 |
| **Type `#`**                      | Hold Space, tap 3       |
| **Type `{`**                      | Hold Space, tap [       |

---

## Repository Layout

```
gnome-kanata/
├── README.md                          # This file
├── nixos/
│   ├── kanata.nix                     # NixOS `services.kanata` module
│   └── gnome-keybindings.nix          # Home Manager dconf settings
└── standard/
    ├── kanata.kbd                     # Standalone Kanata config
    ├── setup-gnome-keybindings.sh    # One-shot gsettings script
    └── kanata.service                 # systemd user service unit
```

---

## Tips

1. **Start slow.** Learn Layer 1 tap-holds first (S=Super, F=Ctrl). Add Layer 3
   spatial positioning after a few days.
2. **Timing is configurable.** If 200ms feels too fast or slow, edit `tap-time`
   and `hold-time` in `kanata.kbd` / `kanata.nix`.
3. **Layer 3 is modal.** You're either in the workspace layer (holding S) or
   you're not. This is intentional — it prevents accidental window moves during
   normal typing.
4. **The scroll keys (; and ') work everywhere** — in browsers, terminals, file
   managers. No mouse needed.
5. **F-row media controls are hold-only.** Tap F5 for F5; hold F5 for mute.
   Muscle memory develops quickly.

---

## Troubleshooting

| Problem                               | Fix                                                                                         |
| ------------------------------------- | ------------------------------------------------------------------------------------------- |
| Kanata not starting (standard)        | Ensure your user is in the `input` group; then `systemctl --user restart kanata.service` |
| Kanata not starting (NixOS)           | `systemctl status kanata-kanata.service`                                                    |
| Keys feel "sticky"                    | Increase `hold-time` in `kanata.kbd`                                                        |
| Spatial positioning doesn't work      | Re-run `./setup-gnome-keybindings.sh` (standard) or verify dconf values (NixOS)             |
| Want to reload config without restart | Hold S, tap F12 (Layer 3)                                                                   |

---

_License: MIT_  
_Kanata: <https://github.com/jtroo/kanata>_
