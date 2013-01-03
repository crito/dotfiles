#!/bin/bash
STATUS=$(acpi -b | awk '{print $3, $4, $5}' | sed 's/,//g')
STATE=$(echo $STATUS | cut -d' ' -f1)
PERCENT=$(echo $STATUS | cut -d' ' -f2)
REMAINING=$(echo $STATUS | cut -d' ' -f3)

if [ $STATE = 'Charging' ]
then
    if [ $PERCENT != 100 ]
    then
        echo -n "AC $REMAINING ($PERCENT)"
    else
        echo -n "Charged"
    fi
else
    echo -n "BAT $REMAINING ($PERCENT)"
fi

echo ""
