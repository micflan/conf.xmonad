# xmonad Setup

1. Install xmonad, xmonad-extras and xmobar
```bash
sudo apt-get install xmonad cabal-install
sudo cabal update; sudo cabal install xmonad-extras
```

2. Install extras: trayer, xscreensaver, scrot (for screenshots)
```bash
sudo apt-get install trayer xscreensaver scrot
```

3. Checkout these files to ~/.xmonad
```bash
git clone git@github.com:micflan/conf.xmonad.git ~/.xmonad
```

4. Create symlinks
```bash
ln -s ~/.xmonad/.xmobarrc ~/.xmobarrc
ln -s ~/.xmonad/.xsession ~/.xsession
```
