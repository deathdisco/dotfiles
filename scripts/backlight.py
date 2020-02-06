#!/usr/bin/env python3
import curses
max_b = int(open('/sys/class/backlight/intel_backlight/max_brightness', 'r').read())
min_b = 40
columns = 70

def main(stdscr):
    stdscr.clear()
    k = 'x'
    stdscr.addstr(1, 0, 'q to quit')
    while k not in 'qQ':
        brightness_file = open('/sys/class/backlight/intel_backlight/brightness', 'w+')
        current = brightness_file.read()
        stdscr.addstr(3, 0, current)
        baseline = int(min_b / max_b * columns)
        filled = int(int(current) / max_b * columns) - baseline
        empty = columns - filled - baseline
        stdscr.addstr(5, 0, '|' * baseline + '*' * filled + '-' * empty)
        k = stdscr.getkey()
        if k in 'uUkKpP' or k == 'KEY_UP':
            new_brightness = int(int(current) * 1.1)
        elif k in 'dDjJnN' or k == 'KEY_DOWN':
            new_brightness = int(int(current) * (10.0/11))
        stdscr.refresh()

        if new_brightness < min_b:
            new_brightness = min_b
        if new_brightness > max_b:
            new_brightness = max_b
        brightness_file.write(str(new_brightness) + '\n')
        brightness_file.close()

curses.wrapper(main)
