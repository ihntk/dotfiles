#!/bin/bash

xrandr --output LVDS --auto --pos 0x0 --output VGA-0 --auto --pos 0x0
TMP=/tmp
dialog --clear --title "Вибір дисплея" \
	   --menu \
		" Зараз потрібно вибрати дисплей з яким ти хочеш працювати" 10 60 3 \
		"out" "Перемкнути за зовнішній монітор" \
		"in" "Повернутися на основний монітор" \
		"both" "Вивести зображення на обидва монітора" 2> $TMP/reply

 if [ $? = 1 -o $? = 255 ]; then
	   exit
 fi
	 REPLY="`cat $TMP/reply`"
	  rm -f $TMP/reply
   if [ "$REPLY" = "skip" ]; then
      exit
   fi

if [ "$REPLY" = "out" ]; then
	xrandr --output LVDS --off --output VGA-0 --auto --pos 0x0
elif [ "$REPLY" = "in" ]; then
	xrandr --output LVDS --auto --pos 0x0 --output VGA-0 --off
elif [ "$REPLY" = "both" ]; then
	xrandr --output LVDS --auto --pos 0x0 --output VGA-0 --auto --left-of LVDS --pos 1366x0
fi

sh ~/.fehbg
