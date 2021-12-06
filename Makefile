symlinks:
ifeq (,$(wildcard ~/.Brewfile))
	ln -s `pwd`/configs/Brewfile ~/.Brewfile
endif
ifeq (,$(wildcard ~/.config/yamllint/config))
	mkdir -p ~/.config/yamllint
	ln -s `pwd`/configs/yamllint.yaml ~/.config/yamllint/config
endif
ifeq (,$(wildcard ~/.gitignore_global))
	ln -s `pwd`/configs/gitignore_global ~/.gitignore_global
endif
ifeq (,$(wildcard ~/.gitconfig))
	ln -s `pwd`/configs/gitconfig ~/.gitconfig
endif
ifeq (,$(wildcard ~/.tmux.conf))
	ln -s `pwd`/configs/tmux.conf ~/.tmux.conf
endif
ifeq (,$(wildcard ~/.config/fish/config.fish))
	mkdir -p ~/.config/fish
	ln -s `pwd`/configs/config.fish ~/.config/fish/config.fish
endif
# ifeq (,$(wildcard ~/.alacritty.yml))
# 	ln -s `pwd`/configs/alacritty.yml ~/.alacritty.yml
# endif
# ifeq (,$(wildcard ~/.config/kitty/kitty.conf))
# 	mkdir -p ~/.config/kitty
# 	ln -s `pwd`/configs/kitty.conf ~/.config/kitty/kitty.conf
# endif

iterm2:
	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "`pwd`/configs/"
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

vim:
ifeq (,$(wildcard ~/.config/nvim/init.lua))
	mkdir -p ~/.config/nvim
	ln -s `pwd`/configs/nvim/init.lua ~/.config/nvim/init.lua
	ln -s `pwd`/configs/nvim/lua/statusline.lua ~/.config/nvim/lua/statusline.lua
endif
ifeq (,$(wildcard ~/.config/nvim/lua/statusline.lua))
	mkdir -p ~/.config/nvim/lua
	ln -s `pwd`/configs/nvim/lua/statusline.lua ~/.config/nvim/lua/statusline.lua
endif
ifeq (,$(wildcard ~/.config/nvim/pack/paqs/start/paq-nvim))
	git clone --depth=1 https://github.com/savq/paq-nvim.git ~/.config/nvim/pack/paqs/start/paq-nvim
endif

configs: symlinks iterm2 vim

brew:
	brew bundle install --global --file=~/.Brewfile

vim_plug:
	nvim -c "execute \"PaqInstall\" | qa"

# https://github.com/mathiasbynens/dotfiles/tree/main/init
# cp -r init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null

macos:
	# Close any open System Preferences panes, to prevent them from overriding
	# settings we’re about to change
	osascript -e 'tell application "System Preferences" to quit'
	# Set sidebar icon size to medium
	defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
	# Save to disk (not to iCloud) by default
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

	# Trackpad: enable tap to click for this user and for the login screen
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

	# Trackpad: map bottom right corner to right-click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
	defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
	defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

	# Use scroll gesture with the Ctrl (^) modifier key to zoom
	defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
	defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
	# Follow the keyboard focus while zoomed in
	defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

	# Set a blazingly fast keyboard repeat rate
	defaults write NSGlobalDomain KeyRepeat -int 2
	defaults write NSGlobalDomain InitialKeyRepeat -int 25

	# Set language and text formats
	# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
	# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
	defaults write NSGlobalDomain AppleLanguages -array "en" "ru" "ua"
	defaults write NSGlobalDomain AppleLocale -string "en_CY"
	defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
	defaults write NSGlobalDomain AppleMetricUnits -bool true

	# Require password immediately after sleep or screen saver begins
	defaults write com.apple.screensaver askForPassword -int 1
	defaults write com.apple.screensaver askForPasswordDelay -int 0

	# Save screenshots to the desktop
	defaults write com.apple.screencapture location -string "${HOME}/Desktop"

	# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
	defaults write com.apple.screencapture type -string "png"

	# Disable shadow in screenshots
	defaults write com.apple.screencapture disable-shadow -bool true

	# Enable subpixel font rendering on non-Apple LCDs
	# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
	defaults write NSGlobalDomain AppleFontSmoothing -int 1

	# Finder: show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Finder: show status bar
	defaults write com.apple.finder ShowStatusBar -bool true

	# Finder: show path bar
	defaults write com.apple.finder ShowPathbar -bool true

	# Display full POSIX path as Finder window title
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

	# Keep folders on top when sorting by name
	defaults write com.apple.finder _FXSortFoldersFirst -bool true

	# When performing a search, search the current folder by default
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

	# Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	# Avoid creating .DS_Store files on network or USB volumes
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	# Use list view in all Finder windows by default
	# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

	# Set the icon size of Dock items to 33 pixels
	defaults write com.apple.dock tilesize -int 33

	# Change minimize/maximize window effect
	defaults write com.apple.dock mineffect -string "scale"

	# Minimize windows into their application’s icon
	defaults write com.apple.dock minimize-to-application -bool true

	# Show indicator lights for open applications in the Dock
	defaults write com.apple.dock show-process-indicators -bool true

	# Bottom left screen corner → Mission Control
	defaults write com.apple.dock wvous-bl-corner -int 2
	defaults write com.apple.dock wvous-bl-modifier -int 0

	# Bottom right screen corner → Desktop
	defaults write com.apple.dock wvous-br-corner -int Desktop
	defaults write com.apple.dock wvous-br-modifier -int 0

	# bounce
	defaults write com.apple.dock no-bouncing -bool false

	# Show the full URL in the address bar (note: this still hides the scheme)
	defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

	# Set Safari’s home page to `about:blank` for faster loading
	defaults write com.apple.Safari HomePage -string "about:blank"

	# Prevent Safari from opening ‘safe’ files automatically after downloading
	defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

	# Hide Safari’s bookmarks bar by default
	defaults write com.apple.Safari ShowFavoritesBar -bool false

	# Hide Safari’s sidebar in Top Sites
	defaults write com.apple.Safari ShowSidebarInTopSites -bool false

	# Enable Safari’s debug menu
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

	# Enable the Develop menu and the Web Inspector in Safari
	defaults write com.apple.Safari IncludeDevelopMenu -bool true
	defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

	# Add a context menu item for showing the Web Inspector in web views
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

	# Enable continuous spellchecking
	defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
	# Disable auto-correct
	defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

	# Disable AutoFill
	defaults write com.apple.Safari AutoFillFromAddressBook -bool false
	defaults write com.apple.Safari AutoFillPasswords -bool false
	defaults write com.apple.Safari AutoFillCreditCardData -bool false
	defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

	# Warn about fraudulent websites
	defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

	# Disable Java
	defaults write com.apple.Safari WebKitJavaEnabled -bool false
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

	# Block pop-up windows
	defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

	# Disable auto-playing video
	defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
	defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
	defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

	# Update extensions automatically
	defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

	# Enable “Do Not Track”
	defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

	# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
	defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

	# Display emails in threaded mode, sorted by date (oldest at the top)
	defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
	defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
	defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

	defaults write com.apple.spotlight orderedItems -array \
		'{"enabled" = 1;"name" = "APPLICATIONS";}' \
		'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
		'{"enabled" = 0;"name" = "DIRECTORIES";}' \
		'{"enabled" = 0;"name" = "PDF";}' \
		'{"enabled" = 0;"name" = "FONTS";}' \
		'{"enabled" = 0;"name" = "DOCUMENTS";}' \
		'{"enabled" = 0;"name" = "MESSAGES";}' \
		'{"enabled" = 0;"name" = "CONTACT";}' \
		'{"enabled" = 0;"name" = "EVENT_TODO";}' \
		'{"enabled" = 0;"name" = "IMAGES";}' \
		'{"enabled" = 0;"name" = "BOOKMARKS";}' \
		'{"enabled" = 0;"name" = "MUSIC";}' \
		'{"enabled" = 0;"name" = "MOVIES";}' \
		'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
		'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
		'{"enabled" = 0;"name" = "SOURCE";}' \
		'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
		'{"enabled" = 0;"name" = "MENU_OTHER";}' \
		'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
		'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
		'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
		'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

	# Only use UTF-8 in Terminal.app
	defaults write com.apple.terminal StringEncodings -array 4

	# Prevent Time Machine from prompting to use new hard drives as backup volume
	defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

	# Use plain text mode for new TextEdit documents
	defaults write com.apple.TextEdit RichText -int 0
	# Open and save files as UTF-8 in TextEdit
	defaults write com.apple.TextEdit PlainTextEncoding -int 4
	defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

	# Enable the automatic update check
	defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

	# Check for software updates daily, not just once per week
	defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
	# Download newly available updates in background
	defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
	# Install System data files & security updates
	defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
	# Turn on app auto-update
	defaults write com.apple.commerce AutoUpdate -bool true

	# Prevent Photos from opening automatically when devices are plugged in
	defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


all: configs brew vim_plug


a29venv:
	if [ ! -e "${HOME}/.venv/a29/bin/activate_this.py" ] ; then PYTHONPATH=${HOME}/.venv/a29 ; virtualenv --clear ${HOME}/.venv/a29 ; fi
	source ${HOME}/.venv/a29/bin/activate && PYTHONPATH=${HOME}/.venv/a29 ${HOME}/.venv/a29/bin/pip install -U -r a29_requirements.txt
