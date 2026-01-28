#!/bin/bash
# https://gitlab.com/xPMo/dotfiles.cli/-/blob/dots/.local/lib/waybar/playerctl.sh

exec 2>"$XDG_RUNTIME_DIR/waybar-playerctl.log"
IFS=$'\n\t'

cleanup(){
    read -r pid <"$XDG_RUNTIME_DIR/waybar-playerctl.pid" 2>/dev/null || return
    [[ -d "/proc/$pid" ]] || return
    read -rd '' cmd < "/proc/$pid/cmdline" 2>/dev/null || return
    case $cmd in
        -playerctl|playerctl|*/playerctl)
            echo >&2 "Killing playerctl [$pid]"
            kill "$pid"
    esac
}

cleanup
trap cleanup EXIT INT

while true; do
    while read -r playing name artist title arturl; do
        playing=${playing:1} name=${name:1}
        artist=${artist:1} title=${title:1} arturl=${arturl:1}

        # Artist - Title
        # line="${artist:+$artist ${title:+- }}${title:+$title}"

        # Title - Artist
        line="${title:+$title ${artist:+- }}${artist:+$artist}"

        case $playing in
            ⏸️ | Paused) class="paused" ; text="$line" ;;
            ▶️ | Playing) class="playing" ; text="$line" ;;
            *) class="stopped" ; text="⏹" ;;
        esac


        # Only Artist - Title in tooltip
        # printf '{"text":"%s","tooltip":"%s"}\n' "$text" "$line" || break 2
        printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$text" "$line" "$class" || break 2

    done < <(
        playerctl --follow metadata --player playerctld --format \
            $':{{emoji(status)}}\t:{{playerName}}\t:{{markup_escape(artist)}}\t:{{markup_escape(title)}}\t:{{mpris:artUrl}}' &
        echo $! >"$XDG_RUNTIME_DIR/waybar-playerctl.pid"
    )

    cleanup
    echo '<span foreground=#dc322f>⏹</span>' || break
    sleep 15
done
