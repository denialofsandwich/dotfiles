# DenialOfSandwichs Dotfiles

Contains all dotfiles for my machines.

## Setup

Here I collect manual steps required to setup the OS after a fresh install.

### Fedora

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
