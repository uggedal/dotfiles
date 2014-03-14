#!/bin/bash

hc() {
  herbstclient "$@"
}

monitor=${1:-0}
font="$2"

PANEL_NOR_BG='#fdfaf6'
PANEL_NOR_FG='#657b83'
PANEL_SEL_BG=$(hc get window_border_active_color)
PANEL_SEL_FG=$PANEL_NOR_BG
PANEL_URG_BG='#dc322f'
PANEL_URG_FG=$PANEL_NOR_BG
PANEL_SEP_FG='#93a1a1'
PANEL_EMP_FG=$PANEL_SEP_FG
PANEL_WIN_FG=$PANEL_SEP_FG

geometry=( $(herbstclient monitor_rect "$monitor") )
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=19

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
    # mawk needs "-W interactive" to line-buffer stdout correctly
    # http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
    uniq_linebuffered() {
      awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
else
    # other awk versions (e.g. gawk) issue a warning with "-W interactive", so
    # we don't want to use it there.
    uniq_linebuffered() {
      awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
fi

hc pad $monitor $panel_height

{
    ### Event generator ###
    # based on different input data (mpc, date, hlwm hooks, ...) this
    # generates events, formed like this:
    #   <eventname>\t<data> [...]

    while true ; do
        # "date" output is checked once a second, but an event is only
        # generated if the output changed compared to the previous run.
        date +$'date\t'"^fg($PANEL_SEP_FG)%Y-%m-%d ^fg($PANEL_NOR_FG)%H:%M"
        sleep 1 || break
    done > >(uniq_linebuffered) &
    childpid=$!
    hc --idle
    kill $childpid
} 2> /dev/null | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    visible=true
    date=""
    windowtitle=""
    while true; do

        ### Output ###
        # This part prints dzen data based on the _previous_ data
        # handling run, and then waits for the next event to happen.

        separator="^bg()^fg($PANEL_SEP_FG) | "
        # draw tags
        for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#')
                    echo -n "^bg($PANEL_SEL_BG)^fg($PANEL_SEL_FG)"
                    ;;
                '+')
                    echo -n "^bg(#9CA668)^fg(#141414)"
                    ;;
                ':')
                    echo -n "^bg()^fg($PANEL_NOR_FG)"
                    ;;
                '!')
                    echo -n "^bg($PANEL_URG_BG)^fg($PANEL_URG_FG)"
                    ;;
                *)
                    echo -n "^bg()^fg($PANEL_EMP_FG)"
                    ;;
            esac
            echo -n " ${i:1} "
        done
        echo -n "$separator"
        echo -n "^bg()^fg($PANEL_WIN_FG) ${windowtitle//^/^^}"
        # small adjustments
        right="$separator^bg()$date$separator"
        right_text_only=$(echo -n "$right" | sed 's.\^[^(]*([^)]*)..g')
        # get width of right aligned text.. and add some space..
        width=$((${#right_text_only} * 8 + 10))
        echo -n "^pa($(($panel_width - $width)))$right"
        echo

        ### Data handling ###
        # This part handles the events generated in the event loop,
        # and sets internal variables based on them. The event and
        # its arguments are read into the array cmd, then action is
        # taken depending on the event name.
        # "Special" events (quit_panel/togglehidepanel/reload) are
        # also handled here.

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
                ;;
            date)
                date="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            togglehidepanel)
                currentmonidx=$(hc list_monitors | sed -n '/\[FOCUS\]$/s/:.*//p')
                if [ "${cmd[1]}" -ne "$monitor" ] ; then
                    continue
                fi
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ] ; then
                    continue
                fi
                echo "^togglehide()"
                if $visible ; then
                    visible=false
                    hc pad $monitor 0
                else
                    visible=true
                    hc pad $monitor $panel_height
                fi
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
        esac
    done

    ### dzen2 ###
    # After the data is gathered and processed, the output of the
    # previous block gets piped to dzen2.

} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y \
    -fn "$font" -h $panel_height \
    -e 'button3=' \
    -ta l -bg $PANEL_NOR_BG -fg $PANEL_NOR_FG