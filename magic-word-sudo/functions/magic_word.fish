function magic_word --description "Ah, ah, ah... you didn't say the magic word!"
    set -l dir ~/.local/share/magic-word

    # Use the first clip found (gif or video)
    set -l clip
    for f in $dir/clip.gif $dir/clip.mp4 $dir/clip.webm
        if test -f $f
            set clip $f
            break
        end
    end

    # Show the clip in a centered, borderless, always-on-top window for 6 seconds
    if test -n "$clip"; and command -q mpv
        timeout 6 mpv --really-quiet --no-terminal \
            --loop-file=inf --ontop --no-border \
            --geometry=400x400+50%+50% --autofit=400x400 \
            --title="ACCESS DENIED" \
            $clip &>/dev/null &
        disown
    end

    # Desktop notification
    if command -q notify-send
        notify-send -u critical -a sudo "ACCESS DENIED" "Ah, ah, ah... you didn't say the magic word!"
    end

    clear
    set_color --bold red
    if command -q figlet
        figlet -c -w (tput cols) "ACCESS DENIED"
    else
        echo "=== ACCESS DENIED ==="
    end

    set_color --bold yellow
    echo
    echo "  Ah, ah, ah..."
    sleep 0.8

    set_color --bold red
    for i in (seq 30)
        echo "  YOU DIDN'T SAY THE MAGIC WORD!"
        sleep 0.07
    end
    set_color normal
end
