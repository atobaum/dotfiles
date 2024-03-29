#!/usr/bin/env bash
# source: https://github.com/johngrib/dotfiles/blob/master/bin/term-colors

if [ "$1" = "--introduce" ]; then
    echo "$0 는 Terminal Color를 출력하는 스크립트입니다."
    exit 0
fi

if [ "$1" = "--vim" ]; then
    for((i=16; i<256; i++)); do
        printf "\e[48;5;${i}m%03d" $i;
        printf '\e[0m';
        [ ! $((($i - 15) % 6)) -eq 0 ] && printf ' ' || printf '\n'
    done
    exit 0
fi

if [ "$1" = "--bash" -o "$1" = "" ]; then
    COLOR_END='\e[0m'

    for((i=1; i<111; i++)); do

        if [ $i -ge 8 -a $i -le 28 ] || [ $i -ge 49 -a $i -le 88 ]; then
            continue
        fi

        # \e[0: NORMAL, \e[1: BOLD, \e[2: DIM, \e[3: ITALIC, \e[4: UNDERLINE, \e[7: REVERSE(반전)

        for((j=0; j<5; j++)); do
            printf "\e[${j};${i}m";         # 색칠용
            printf "%-9s" "\\e[${j};${i}m"; # 화면표현용
            printf "$COLOR_END ";
        done

        printf "\e[7;${i}m";
        printf "%-9s" "\\e[7;${i}m";
        printf "$COLOR_END\n"

        # [ ! $(($i % 3)) -eq 0 ] && printf ', ' || printf '\n'
    done
fi
