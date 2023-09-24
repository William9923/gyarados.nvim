<p align="center"><img width=200" src="./docs/thumbnail/logo.svg"></p>

<p align="center"><b>gyarados.nvim: My Personal Basic Stable IDE</b></p>

<p align="center">
    <img alt="Editor" src="https://img.shields.io/badge/editor-nvim-019733?style=flat-square&logo=neovim" />
    <img alt="Git" src="https://img.shields.io/badge/git-lazygit-pink?style=flat-square&logo=git" />
    <img alt="Workflow Manager" src="https://img.shields.io/badge/multiplexer-tmux-1BB91F?style=flat-square&logo=tmux" />
  </p>
  
<p align="center">
  <a href="https://github.com/nordtheme/nord/releases/tag/v0.2.0" target="_blank">
    <img src="https://img.shields.io/static/v1.svg?style=flat-square&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAACUklEQVRIibXUQUiTcRjH8e+zvaO0AgPd1mDmNvFVI+ng1UNU1wiDoEIIoUNUdOkQUkER1KWTnRJCLyZBIdEhQvAWQVp5KN9X3bskmHunYbeZbu/TaWXRdOLrc3ue5/f/f/6nP+xwycy8m6y0LGqg0N7UsLB+9jmdbQwZQaNawPBKpCstA3g/7fRCl5k68P7PLNjplRgBQtUAYjmuCriqDP690RqQK8A3WSt1mmZsqbyyM+4pVc5tcvdxYD+W46qVdif/l7Ac95bluGo57piqBqt58e+zaXfSclwNbBQyE+F7KKPAMTuzeGcrQLk2BEREV41dvYAD2jeddrt9BQA6DtYtC3QDKyIM2pmlVl+Bublc2ExGpgS9BuxTLT2byuX2+AYUJTAyPq6GmYwOIPoEOLy7IAO+AYgejTW5dwF2UbiM8kGVs9NO/qo/AGRV5Ybl5E4mEokVT0rdwHdBH9pOvmvbgCd6GlgDGZqddVPtydg8aC9gKDqybaA9EX2nyHWgrhTkxUQ2W9uajL4U0QdAbNsAQFsy3C8wBHTsXQk+BmhpitwE3vgCANSGVi8pfATO207uooh4hqc9vgHxeLzgeXIG+KFIv5Ve7GxujuZ9AwAONYfnVLUHCCHec9vO1vsKALSloq9A7gONhILDm/2yWwYAzETDbeC1wgk7k+/bKCuW4yqwDIxtGBSGzURktNzbdrZeQ8EJIA76CJXCP/kLCpEyUE2VVLWnLRV9Wh7MZPJHPNW3QE2lQ0YgSKpKgLWiV1zftyTCn758XUwZ4lUEdrx+ASW88rx2UJY8AAAAAElFTkSuQmCC&label=Nord&message=v0.2.0&colorA=4c566a&colorB=88c0d0"/>
  </a>
</p>

<p align="center">An arctic, north-bluish clean and elegant on outside nvim configuration, but once you used it, you will go on a rampage (picked the description from Pokedex).</p>

<p align="center">Designed for a fluent and clear workflow that allow the user to remains rampage until it demolish every problem with it.</p>

<p align="center">
    <img src="docs/nvim-file-dashboard.png"/>
</p>

## Getting Started

### Features

<div align="center">
  <p><strong>Your editor. Your style.</strong></p>
  <p>The unified editor preference provide a clutter-free and fluidly coding experience.</p>
</div>

<p align="center">
  <p><strong>Syntax Highlighting</strong></p>
  <img src="docs/treesitter.png" />
</p>

<p align="center">
  <p><strong>Language Server (Definition, Reference, etc...)</strong></p>
  <img src="docs/lspsaga.png" />
</p>

<p align="center">
  <p><strong>Telescope (file finder)</strong></p>
  <img src="docs/telescope.png" />
</p>

<p align="center">
  <p><strong>Workspace diagnostic</strong></p>
  <img src="docs/diagnostic.png" />
</p>

<p align="center">
  <p><strong>File Tree viewer</strong></p>
  <img src="docs/tree-viewer.png" />
</p>

<p align="center">
  <p><strong>Symbol Outline</strong></p>
  <img src="docs/outline.png" />
</p>

<p align="center">
  <p><strong>TODO</strong></p>
  <img src="docs/Todo.png" />
</p>


### Quick Start

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  sudo apt install ripgrep
  ```
  
Tree-sitter setup
  ```sh 
  :TSInstall all
  ```
  
## Fonts

I personally like Jetbrains Mono Nerd Font, but the font is not defined in the neovim setting. You should configure it in your terminal settings.

## Configuration

### Formatters and linters

In this neovim configuration, I provided some of the formatters and linters that I personally use:

- Prettier : for javascript and typescript
- Black : for Python
- Stylua : for Lua script
- Goimports : for Golang
- Shfmt : for shell scripts

You can configure new formatters and linters easily in `lua/user/lsp`

## Thanks to...

- [LunarVim](https://github.com/LunarVim/nvim-basic-ide)

## ❤️ Support

If you feel that this repo have helped you provide more example on learning software engineering, then it is enough for me! Wanna contribute more? Please ⭐ this repo so other can see it too!
