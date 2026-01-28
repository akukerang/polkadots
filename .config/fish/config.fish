source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   # smth smth
end

set -gx MICRO_TRUECOLOR 1

alias venv="source .venv/bin/activate.fish"
alias fishrc="micro ~/.config/fish/config.fish"
