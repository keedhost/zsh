How to install ZHS config

### 1. Install zsh:
```
sudo apt install zsh
```
or
```
sudo pacman -S zsh
```
### 2. Backup old configs:
```
mv -v ~/.zsh ~/.zsh-$(date +%d-%m-%Y-at-%H-%m)
```
### 3. Clone the repo:
```
git clone --recurse-submodules git@github.com:keedhost/zsh.git ~/.zsh --recursive --progress  --remote
```
### 4. Create symlink for general config file:
```
ln -s ~/.zsh/zshrc ~/.zshrc
```
### 5. Install additional tools:
```
pip install thefuck
```
### 6. Change your default shell
```
chsh -s $(which zsh)
```
