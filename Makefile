DOTFILEDIR := ~/.dotfiles
I3DIR := ~/.i3
VIMDIR := ~/.vim
MUTTDIR := ~/.mutt
IRSSIDIR := ~/.irssi
ZSHDIR := ~/.zsh
UNISONDIR := ~/.unison

base: | $(DOTFILEDIR)
	@echo Updating the git repository ...
	@cd $(DOTFILEDIR)
	@git pull
	@cd ~
	

$(DOTFILEDIR):
	@echo $(DOTFILEDIR) doesn\'t exist. I will clone it now ...
	@cd ~
	@git clone git@github.com:crito/dotfiles.git $(DOTFILEDIR)
	# Use the below string to access the dotfiles readonly
	# @git clone git://github.com/crito/dotfiles.git $(DOTFILEDIR)

mimetypes: base
	@echo Configuring mimetypes and default applications ...
	$(shell [[ -d ~/.local/share ]] || mkdir -p ~/.local/share)
	$(shell [[ -d ~/.local/share/applications ]] && rm -rf ~/.local/share/applications)
	@ln -sf $(DOTFILEDIR)/mimetypes ~/.local/share/applications
	
git: base
	@echo Configuring git
	@ln -sf $(DOTFILEDIR)/gitconfig ~/.gitconfig

mercurial: base
	@echo Configuring mercurial
	@ln -sf $(DOTFILEDIR)/hgrc ~/.hgrc

rtorrent: base
	@echo Commiting piracy ...
	@ln -sf $(DOTFILEDIR)/rtorrent.rc ~/.rtorrent.rc

unison: base
	@echo Configuring file replication ...
	$(shell [[ -d $(UNISONDIR) ]] && rm -rf $(UNISONDIR))
	@ln -sf $(DOTFILEDIR)/unison $(UNISONDIR)

irssi: base
	@echo Configuring the chat setup ...
	$(shell [[ -d $(IRSSIDIR) ]] || mkdir $(IRSSIDIR))
	@ln -sf $(DOTFILEDIR)/irssi/scripts $(IRSSIDIR)/scripts

tmux: base
	@echo Configuring tmux ...
	@ln -sf $(DOTFILEDIR)/tmux.conf ~/.tmux.conf

X: base
	@echo Configuring the X installation and window manager ...
	$(shell [[ -d $(I3DIR) ]] && rm -rf $(I3DIR))
	@ln -sf $(DOTFILEDIR)/i3 $(I3DIR)
	@ln -sf $(DOTFILEDIR)/Xresources ~/.Xresources
	@ln -sf $(DOTFILEDIR)/xinitrc ~/.xinitrc
	@ln -sf $(DOTFILEDIR)/swapkeys ~/.Xmodmap

vim: base
	@echo Configuring vim ...
	$(shell [[ -d $(VIMDIR) ]] && rm -rf $(VIMDIR))
	@ln -sf $(DOTFILEDIR)/vim $(VIMDIR)
	@ln -sf $(DOTFILEDIR)/vimrc ~/.vimrc

mail: base
	@echo Configuring mail \(Don\'t forget to run offlineimap prior to starting mutt\) ...
	$(shell [[ -d $(MUTTDIR) ]] && rm -rf $(MUTTDIR))
	$(shell [[ -d ~/.offlineimap ]] || mkdir ~/.offlineimap)
	$(shell [[ -d ~/Maildir ]] || mkdir ~/Maildir)
	@ln -sf $(DOTFILEDIR)/mutt $(MUTTDIR)
	@ln -sf $(DOTFILEDIR)/offlineimaprc ~/.offlineimaprc
	@ln -sf $(DOTFILEDIR)/muttrc ~/.muttrc
	@ln -sf $(DOTFILEDIR)/mailcap ~/.mailcap

zsh: base
	@echo Configuring zsh ...
	$(shell [[ -d $(ZSHDIR) ]] && rm -rf $(IZSHDIR))
	@ln -sf $(DOTFILEDIR)/zsh $(ZSHDIR)
	@ln -sf $(DOTFILEDIR)/zshrc ~/.zshrc

bin: base
	@echo Creating the scripts directory ...
	$(shell [[ -d ~/bin ]] && rm -rf ~/bin)
	@ln -sf $(DOTFILEDIR)/bin ~/bin

twmn: base
	@echo Configure notification daemon ...
	$(shell [[ -d ~/.config ]] || mkdir ~/.config)
	$(shell [[ -d ~/.config/twmn ]] && rm -rf ~/.config/twmn)
	@ln -sf $(DOTFILEDIR)/twmn ~/.config/twmn

mpd: base
	@echo Configure mpd music daemon ...
	$(shell [[ -d ~/.mpd ]] || mkdir ~/.mpd)
	$(shell [[ -d ~/.mpd/playlists ]] || mkdir ~/.mpd/playlists)
	$(shell [[ -d ~/Music ]] || mkdir ~/Music)
	@ln -sf $(DOTFILEDIR)/mpdconf ~/.mpdconf
	@touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}

font: base
	@echo Placing fonts.conf
	@ln -sf $(DOTFILEDIR)/fonts.conf ~/.fonts.conf

systemd: base
	@echo Configure systemd user processes
	@sudo ln -sf $(DOTFILEDIR)/systemd/offlineimap.service /etc/systemd/system/offlineimap.service
	@sudo systemctl --system daemon-reload

nm-dispatcher: base
	@echo Setting network manager dispatch scripts
	@sudo cp $(DOTFILEDIR)/nm-dispatcher/fileserver /etc/NetworkManager/dispatcher.d/10-fileserver
	@sudo cp $(DOTFILEDIR)/nm-dispatcher/offlineimap /etc/NetworkManager/dispatcher.d/20-offlineimap
	@sudo chmod 0700 /etc/NetworkManager/dispatcher.d/10-fileserver
	@sudo chmod 0700 /etc/NetworkManager/dispatcher.d/20-offlineimap

all: tmux X vim mail zsh bin unison twmn mpd font git irssi mercurial rtorrent mimetypes systemd nm-dispatcher

.PHONY: base tmux X vim mail zsh all unison irssi twmn mpd font git irssi mercurial rtorrent mimetypes systemd nm-dispatcher
