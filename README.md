How to install ZHS config

### 1. Install zsh:
```
sudo apt install zsh
```
or
```
sudo pacman -S zas
```
### 2. Clone the repo:
```
git clone git@github.com:keedhost/zsh.git ~/.zsh
```
### 3. Create symlink for general config file:
```
ln -s ~/.zsh/zshrc ~/.zshrc
```
### 4. Update submodules (for Oh-my-zsh!):
```
cd ~/.zsh && git submodule update --init
```
### 5. Install additional tools:
```
pip install thefuck
```
