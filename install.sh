# Make this more general so we could put the install directory anywhere (symlinks?)
export CD3K_CONFIG_DIR=$HOME/dotfiles

sudo pacman -S w3m xorg-xinit the_silver_searcher fbgrab

# use a custom .xinitrc
cp ./X11/.xinitrc $HOME/.xinitrc
echo 'source '$CD3K_CONFIG_DIR/cd3k.configrc'' >> $HOME/.zshrc
# make vim the default editor (rather than nvim)
echo 'export EDITOR=/usr/bin/vim' >> $HOME/.zshrc
echo 'export VISUAL=/usr/bin/vim' >> $HOME/.zshrc

# Add custom keyboard mappings for tty
sudo mkdir /usr/local/share/kbd
sudo mkdir /usr/local/share/kbd/keymaps
sudo cp tty/cd3k.map /usr/local/share/kbd/keymaps/cd3k.map
sudo cat tty/vconsole.conf > /etc/vconsole.conf
sudo loadkeys /usr/local/share/kbd/keymaps/cd3k.map

# Create ssh key for github
mkdir $HOME/.ssh
ssh-keygen -t ed25519 -C "seanwarman@protonmail.com"
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/github
# Can't use clipcopy inside the script for some reason...
# clipcopy < $HOME/.ssh/github.pub

# Clone my vim/tmux configs
mkdir $HOME/.vim
git clone https://github.com/seanwarman/vimrc.git $HOME/.vim
touch $HOME/.vimrc
echo 'runtime vimrc' > $HOME/.vimrc
touch $HOME/.tmux.conf
echo 'source-file $HOME/.vim/tmux.conf' > $HOME/.tmux.conf

# Install yay (aur installer)
git clone https://aur.archlinux.org/yay-git.git $HOME/.config/yay-git
sudo chown -R cd3k:cd3k $HOME/.config/yay-git
cd $HOME/.config/yay-git
makepkg -si
cd $CD3K_CONFIG_DIR

# Install dwm
# use a custom dwm config file
cat X11/dwm/config.h > $HOME/.config/dwm/config.h
git clone git://git.suckless.org/dwm $HOME/.config/dwm
cd $HOME/.config/dwm
make
sudo make install
cd $CD3K_CONFIG_DIR

# Install brave
yay brave

# Sync my bookmarks
mkdir $HOME/.config/BraveSoftware
mkdir $HOME/.config/BraveSoftware/Brave-Browser
mkdir $HOME/.config/BraveSoftware/Brave-Browser/Default
cd $HOME/.config/BraveSoftware/Brave-Browser/
git clone https://github.com/seanwarman/bookmarks.git Default
cd $CD3K_CONFIG_DIR
