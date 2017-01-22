# Dylan's .bashrc

# Set the prompt.
# $USER ~/path/to/dir >
export PS1="$USER \w \[$(tput setaf 5)\]>\[$(tput sgr0)\]"

# Set nvim as editor.
export EDITOR="nvim"

# Add ~/bin to path
PATH="$PATH:$HOME/bin"

# Set XDG_CONFIG_HOME
export XDG_CONFIG_HOME="${HOME}/.config"

# Fix CSGO mouse issues
export SDL_VIDEO_X11_DGAMOUSE=0

# Make steam not close to tray.
export STEAM_FRAME_FORCE_CLOSE=0

# Source colors generated by wal.
source "$HOME/.cache/wal/colors.sh"

# ALIASES

alias steam="steam-native"
alias sxiv="sxiv -b -s f"
alias handbrake="ghb"

# Use Roboto Mono on laptop.
[[ "$HOSTNAME" == "rosebud" ]] && printf "\033]710;%s\007" "xft:Roboto Mono:size=20"

# Import colorscheme from 'wal'
[[ -z "$VTE_VERSION" ]] && (wal -r &)

# Auto start X.
[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && exec startx -- vt1 &> /dev/null
