#/bin/bash

DATE=`date +%s`
LOG=disperse/disperse-$DATE.log
echo "Logging to $LOG"

mkdir -p disperse
./disperse.pl > disperse/disperse-$DATE.sh
echo "Created disperse/disperse-$DATE.sh:"
cat disperse/disperse-$DATE.sh
echo "Dispersing funds!"
bash disperse/disperse-$DATE.sh &> $LOG &
cat $LOG
