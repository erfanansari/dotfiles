#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title HID Session
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⚙️

# Documentation:
# @raycast.description Toggle the local HID session agent
# @raycast.author erfan

PID_FILE="/tmp/hid_session.pid"
LOG_FILE="/tmp/hid_session.log"

# Check if cliclick is installed
if ! command -v cliclick &> /dev/null; then
    echo "missing dependency: cliclick (brew install cliclick)"
    exit 1
fi

# Function to get random number in range
random_range() {
    local min=$1
    local max=$2
    echo $(( RANDOM % (max - min + 1) + min ))
}

# Function to scroll using arrow keys
do_scroll() {
    local amount=$1  # positive = down, negative = up
    local abs_amount=${amount#-}

    if [ $amount -gt 0 ]; then
        # Scroll down using down arrow
        for i in $(seq 1 $abs_amount); do
            cliclick "kp:arrow-down"
            sleep 0.05
        done
    else
        # Scroll up using up arrow
        for i in $(seq 1 $abs_amount); do
            cliclick "kp:arrow-up"
            sleep 0.05
        done
    fi
}

# Main session loop
run_session() {
    echo "session start $(date)" > "$LOG_FILE"

    while true; do
        # Very short intervals between actions (1-3 seconds) to simulate active work
        sleep_time=$(random_range 1 3)

        # Occasionally add medium idle periods (3% chance)
        if [ $(random_range 1 100) -le 3 ]; then
            sleep_time=$(random_range 5 12)
            echo "evt idle ${sleep_time}s $(date)" >> "$LOG_FILE"
        fi

        sleep $sleep_time

        # Random movement pattern - weighted towards active behaviors
        pattern=$(random_range 1 100)

        case $pattern in
            [1-9]|1[0-9]|2[0-5])
                # Small movements (25% - simulating reading/hovering)
                offset_x=$(random_range -120 120)
                offset_y=$(random_range -80 80)
                easing=$(random_range 3 8)

                cliclick -e $easing "m:+${offset_x},+${offset_y}"
                ;;
            2[6-9]|3[0-9]|40)
                # Move + click (15% - simulating clicking buttons/links)
                offset_x=$(random_range -300 300)
                offset_y=$(random_range -200 200)
                easing=$(random_range 5 12)

                cliclick -e $easing "m:+${offset_x},+${offset_y}"
                sleep 0.$(random_range 2 5)
                cliclick "c:."
                echo "evt m1 $(date)" >> "$LOG_FILE"
                ;;
            4[1-9]|5[0-2])
                # Scroll down (12%)
                scroll_amount=$(random_range 3 8)
                do_scroll $scroll_amount
                echo "evt s1 ${scroll_amount} $(date)" >> "$LOG_FILE"
                ;;
            5[3-9]|6[0-4])
                # Scroll up (12%)
                scroll_amount=$(random_range -8 -3)
                do_scroll $scroll_amount
                echo "evt s2 ${scroll_amount} $(date)" >> "$LOG_FILE"
                ;;
            6[5-9]|7[0-4])
                # Double click pattern (10% - opening files/folders)
                offset_x=$(random_range -350 350)
                offset_y=$(random_range -250 250)
                easing=$(random_range 6 15)

                cliclick -e $easing "m:+${offset_x},+${offset_y}"
                sleep 0.$(random_range 3 7)
                cliclick "c:."
                sleep 0.$(random_range 1 2)
                cliclick "c:."
                echo "evt m2 $(date)" >> "$LOG_FILE"
                ;;
            7[5-9]|8[0-2])
                # Dragging pattern (8% - selecting text/moving items)
                offset_x1=$(random_range -180 180)
                offset_y1=$(random_range -120 120)
                offset_x2=$(random_range -400 400)
                offset_y2=$(random_range -280 280)
                easing=$(random_range 3 8)

                cliclick -e $easing "m:+${offset_x1},+${offset_y1}"
                sleep 0.$(random_range 1 3)
                cliclick "dd:."
                sleep 0.$(random_range 5 15)
                cliclick -e $easing "m:+${offset_x2},+${offset_y2}"
                cliclick "du:."
                echo "evt m3 $(date)" >> "$LOG_FILE"
                ;;
            8[3-9]|90)
                # Large movement (8% - moving between windows/areas)
                offset_x=$(random_range -500 500)
                offset_y=$(random_range -400 400)
                easing=$(random_range 8 18)

                cliclick -e $easing "m:+${offset_x},+${offset_y}"
                echo "evt m4 $(date)" >> "$LOG_FILE"
                ;;
            9[1-4])
                # Scroll + click (4%)
                scroll_amount=$(random_range -6 6)
                [ $scroll_amount -eq 0 ] && scroll_amount=3
                do_scroll $scroll_amount
                sleep 0.$(random_range 5 10)
                cliclick "c:."
                echo "evt s3 $(date)" >> "$LOG_FILE"
                ;;
            9[5-8])
                # Typing pattern - click then small movements (4% - simulating typing)
                cliclick "c:."
                sleep $(random_range 1 3)
                for i in $(seq 1 $(random_range 5 12)); do
                    offset_x=$(random_range -15 15)
                    offset_y=$(random_range -15 15)
                    cliclick "m:+${offset_x},+${offset_y}"
                    sleep 0.$(random_range 1 3)
                done
                echo "evt k1 $(date)" >> "$LOG_FILE"
                ;;
            *)
                # Just click (2% - random interactions)
                cliclick "c:."
                echo "evt m0 $(date)" >> "$LOG_FILE"
                ;;
        esac

        # Add occasional extra activity bursts (10% chance)
        if [ $(random_range 1 100) -le 10 ]; then
            sleep 0.$(random_range 3 8)
            # Random: either move+click or scroll
            if [ $(random_range 1 2) -eq 1 ]; then
                offset_x=$(random_range -250 250)
                offset_y=$(random_range -180 180)
                cliclick -e $(random_range 5 12) "m:+${offset_x},+${offset_y}"
                sleep 0.$(random_range 2 6)
                cliclick "c:."
                echo "evt m5 $(date)" >> "$LOG_FILE"
            else
                scroll_amt=$(random_range -7 7)
                [ $scroll_amt -eq 0 ] && scroll_amt=4
                do_scroll $scroll_amt
                echo "evt s4 $(date)" >> "$LOG_FILE"
            fi
        fi
    done
}

# Check if already running
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        # Already running, stop it
        kill $PID
        rm "$PID_FILE"
        echo "⏹ Session ended"
        exit 0
    else
        # Stale PID file
        rm "$PID_FILE"
    fi
fi

# Start session agent in background
run_session &
echo $! > "$PID_FILE"

echo "⚙️ Session active (PID: $!)"
echo "Run again to end"
