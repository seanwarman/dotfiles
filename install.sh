export CD3K_CONFIG_DIR=$PWD

sudo pacman -Syu
sudo pacman -S w3m xorg-init the_silver_searcher fbgrab

# use a custom .xinitrc
cp ./X11/.xinitrc $HOME/.xinitrc
echo ''$CD3K_CONFIG_DIR/cd3k.configrc'' >> $HOME/.zshrc
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
ssh-keygen -t ed25519 -C "seanwarman@protonmail.com"
clipcopy < $HOME/.ssh/github.pub
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/github

# Clone my vim/tmux configs
mkdir $HOME/.vim
git clone git@github.com:seanwarman/vimrc.git $HOME/.vim
touch $HOME/.vimrc
echo 'runtime vimrc' > $HOME/.vimrc
touch $HOME/.tmux.conf
echo 'source-file $HOME/.vim/tmux.conf' > $HOME/.tmux.conf

# Install yay (aur installer)
sudo git clone https://aur.archlinux.org/yay-git.git $HOME/.config/yay-git
sudo chown -R cd3k:cd3k $HOME/.config/yay-git
cd $HOME/.config/yay-git
makepkg -si
cd $CD3K_CONFIG_DIR

# Install dwm
git clone git://git.suckless.org/dwm $HOME/.config/dwm
cd $HOME/.config/dwm
make
sudo make install
cd $CD3K_CONFIG_DIR
# use a custom dwm config file
cat $CD3K_CONFIG_DIR/X11/dwm/config.h > $HOME/.config/dwm/config.h

# Install brave
yay brave
cd $HOME/.config/BraveSoftware/Brave-Browser/Default
# Sync my bookmarks
git clone https://github.com/seanwarman/bookmarks.git
mv bookmarks/* .
cd $CD3K_CONFIG_DIR

# TODO tty config files for key mappings...

source $HOME/.zshrc
