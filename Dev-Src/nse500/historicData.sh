BhavCopyFilePath="/home/rj1aditya/Dev/Scr/nse500/Data/CSV/"
BhavCopyFilePathRecent200CSV="/home/rj1aditya/Dev/Scr/nse500/Data/Recent200CSV/"
BhavCopyFilePathRecent44CSV="/home/rj1aditya/Dev/Scr/nse500/Data/Recent44CSV/"
rm -rf "$BhavCopyFilePath"/*.csv
rm -rf "$BhavCopyFilePathRecent200CSV"/*.csv
rm -rf "$BhavCopyFilePathRecent44CSV"/*.csv

dat=`date`
month=`date +"%m-%d-%y" | awk -F'-' '{print $1}'`
if [ `echo $month| cut -c1` -eq 0 ]
then
    month=`echo $month|cut  -c2`
fi

year=`echo $dat|awk -F" " '{print $6}'`
day=`echo $dat|awk -F" " '{print $3}'`
weekday=`echo $dat|awk -F" " '{print $1}'`

Months=(XXX JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC)
counter=0;
for((YEAR=2021;YEAR>=2020;YEAR--))
{
    for((;month>=1;month--))
    {
        for((;day>=1;day--))
        {
            j=$day
            if [ `echo $j |wc -c` -eq 2 ]
            then
                j="0$j"
            fi
            x=${Months[month]}
            BhavCopyLink="https://www1.nseindia.com/content/historical/EQUITIES/$YEAR/$x/cm"$j$x$YEAR"bhav.csv.zip"
            curl -o file.zip $BhavCopyLink
            
            filename="cm"$j$x$YEAR"bhav.csv"
            echo $filename
            if [ -f "./file.zip" ]
            then
                unzip file.zip
                rm -rf file.zip
            fi
            if [ -f "./$filename" ]
            then
                let counter=counter+1
                mv "$filename" "$counter$filename"
                echo
                echo 
                echo
                echo
                echo $counter

            fi

            if [ $counter -eq 200 ]
            then
                break
            fi
        }
        if [ $counter -eq 200 ]
        then
            break
        fi
        day=31
    }
    if [ $counter -eq 200 ]
    then
        break
    fi
    month=12

}
echo $counter

mv *.csv $BhavCopyFilePath

cd $BhavCopyFilePath
cp * "$BhavCopyFilePathRecent200CSV"

for i in `ls -lrt | tail -44 | awk -F" " '{print $9}'`
do
    echo $i
    cp "$i" ~/Dev/Scr/nse500/Data/Recent44CSV/
done

cd ~/Dev/Scr/nse500/
chmod -R 755 *