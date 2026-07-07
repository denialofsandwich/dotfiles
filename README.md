# DenialOfSandwichs Dotfiles

Contains all dotfiles for my machines.

## Setup

Here I collect manual steps required to setup the OS after a fresh install.

### General

#### Setup git

```bash
git config --global user.email "nameyour1337@email.addr"
git config --global user.name "Your Name"
```

### Fedora

#### Set hostname

```bash
hostnamectl set-hostname rf-pc
```

#### Enable Additional repos

Open Discover -> Settings -> enable...:

- RPM Fusion - Nvidia Driver
- Flathub

#### Use proprietary nvidia driver

`libva-nvidia-driver` and `ffmpeg` is fixing a stuttering issue in firefox due to missing proprietary codecs

```bash
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf install nvidia-driver libva-nvidia-driver
```

### MacOS

#### Fix keyboard mapping

- system > keyboard > repeat rate: max
- system > keyboard > shortcuts > modifier:
  - ctrl: cmd
  - cmd: ctrl

#### Install Easy Move Resize

**Repo**: https://github.com/dmarcotte/easy-move-resize

```bash
brew install --cask easy-move-plus-resize
xattr -dr com.apple.quarantine /Applications/Easy\ Move+Resize.app
```

#### Install Mac Mouse Fix

```bash
brew install mac-mouse-fix
```

#### Fix scrolling

- system > mouse -> disable "Natural scrolling"
- Install:

  ```bash
  brew install mac-mouse-fix
  ```
