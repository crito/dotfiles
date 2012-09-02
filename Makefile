DOTFILEDIR := ~/.dotfiles
I3DIR := ~/.i3
VIMDIR := ~/.vim
MUTTDIR := ~/.mutt
IRSSIDIR := ~/.irssi
ZSHDIR := ~/.zsh

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

irssi:
	@echo Configuring the chat setup ...
	$(shell [[ -d $(IRSSIDIR) ]] && rm -rf $(IRSSIDIR))
	@ln -sf $(DOTFILEDIR)/irssi $(IRSSIDIR)

tmux: base
	@echo Configuring tmux ...
	@ln -sf $(DOTFILEDIR)/tmux.conf ~/.tmux.conf

X: base
	@echo Configuring the X installation and window manager ...
	$(shell [[ -d $(I3DIR) ]] && rm -rf $(I3DIR))
	@ln -sf $(DOTFILEDIR)/i3 $(I3DIR)
	@ln -sf $(DOTFILEDIR)/Xresources ~/.Xresources
	@ln -sf $(DOTFILEDIR)/xinitrc ~/.xinitrc

vim: base
	@echo Configuring vim ...
	$(shell [[ -d $(VIMDIR) ]] && rm -rf $(VIMDIR))
	@ln -sf $(DOTFILEDIR)/vim $(VIMDIR)
	@ln -sf $(DOTFILEDIR)/vimrc ~/.vimrc

mail: base
	@echo Configuring mail \(Don\'t forget to run offlineimap prior to starting mutt\) ...
	$(shell [[ -d $(MUTTDIR) ]] && rm -rf $(MUTTDIR))
	$(shell [[ -d ~/.offlineimap ]] || mkdir ~/.offlineimap)
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

all: tmux X vim mail zsh bin

.PHONY: base tmux X vim mail zsh all
