# Glass

The glassmorphism look of **herdr-desk** rebuilt for Herdr, in neutral graphite: sidebar, tab bar, panes and status bar float as separate smoked-glass cards over a near-black background with a faint white haze, with rounded corners, hairline white borders and shadows. No colored glow; color comes only from the text, the `#60b9fc` accent and agent status. Dark only.

![Glass](preview.png)

## What's inside

| File | What it is |
|---|---|
| `layouts/glass.json` | the layout: floating cards, 10px gaps, translucent terminals |
| `layouts/glass.png` | the picture Settings shows for it |
| `mods/spaces-icons/` | the Spaces list, showing each project's own icon on its avatar |
| `themes/glass.json` | the layout's own theme: graphite glass colors with alpha |
| `backgrounds/glass-ambient.png` | the background picture (2560×1640) |
| `tools/ambient.ps1` | regenerates the background (Windows PowerShell) |

**Project icons:** the Spaces list (`mods/spaces-icons`, a clone of Herdr's `spaces`) shows each project's own icon on its avatar when the project has one: a Tauri app icon, `icon.*`, `logo.*`, `assets/`, `public/` logos, or a favicon, in the project folder, one folder down, or in `apps/*` / `packages/*`. Drop an `.herdr/icon.png` (or `.svg`) in a project to choose its icon. Projects without one keep the colored letter.

What it touches: it reads your spaces' project folders, copies the icon it finds into `~/.config/herdr-app/data/spaces-icons/` (PNGs with `cmd /c copy` on Windows, `cp` elsewhere) and remembers the results in shared state. No network access. The other mods are Herdr's own.

## Install

Copy the folders into your Herdr home (`~/.config/herdr-app`, or `HERDR_APP_HOME`), then switch to the layout:

```sh
git clone https://github.com/MarcozVD/herdr-layout-glass
cp -r herdr-layout-glass/{layouts,themes,backgrounds,mods} ~/.config/herdr-app/
herdr-app do layout.switch '{"name":"glass"}'
```

On Windows PowerShell:

```powershell
git clone https://github.com/MarcozVD/herdr-layout-glass
Copy-Item -Recurse -Force herdr-layout-glass/layouts,herdr-layout-glass/themes,herdr-layout-glass/backgrounds,herdr-layout-glass/mods "$HOME/.config/herdr-app/"
herdr-app do layout.switch '{"name":"glass"}'
```

`ctrl-shift-l` cycles back to your other layouts. To remove it, delete the files listed above (and `data/spaces-icons/`) from `~/.config/herdr-app`.

Or ask your agent to add it: *"add the Herdr layout at github.com/MarcozVD/herdr-layout-glass"*.

## Build it yourself

[`RECIPE.md`](RECIPE.md) is the full brief (regions, sizes, exact colors, node tree, gotchas, checks): an agent with an empty folder can rebuild the layout from it.

Herdr draws translucency but no backdrop blur, so the glass is see-through rather than frosted. To tweak the background, edit the colors in `tools/ambient.ps1` and run `powershell -File tools/ambient.ps1 -Out backgrounds/glass-ambient.png` (rename the file if Herdr keeps showing the old one: pictures are cached).

## Related

- [herdr-layout-catppuccin](https://github.com/MarcozVD/herdr-layout-catppuccin): Catppuccin Mocha / Latte, solid panels.
- [herdr-layout-onedark](https://github.com/MarcozVD/herdr-layout-onedark): One Dark / One Light, solid panels.
- [herdr-layout-glass](https://github.com/MarcozVD/herdr-layout-glass): glassmorphism in neutral graphite.
