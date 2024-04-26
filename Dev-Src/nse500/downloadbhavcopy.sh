dat=`date "+%a %b %d %H:%M %S %Y"`
month=`echo $dat|awk -F" " '{print $2}'`
month=`echo $month| tr [:lower:] [:upper:]`
year=`echo $dat|awk -F" " '{print $6}'`
day=`echo $dat|awk -F" " '{print $3}'`
weekday=`echo $dat|awk -F" " '{print $1}'`

BhavCopyFileFormat="cm07AUG2021bhav.csv.zip"
BhavCopyLink="https://www1.nseindia.com/content/historical/EQUITIES/$year/$month/cm"$day$month$year"bhav.csv.zip"

BhavCopyFilePath="/home/rj1aditya/Dev/Scr/nse500/Data/CSV/"
BhavCopyFileName="$BhavCopyFilePath/cm"$day$month$year"bhav.csv"
testBhavCopyFileName="$BhavCopyFilePath/cm06AUG2021bhav.csv"
testBhavCopyLink="https://www1.nseindia.com/content/historical/EQUITIES/$year/$month/cm06AUG2021bhav.csv.zip"
testweekday="Mon"

main()
{
    if [ $weekday = "Sat" ] || [ $weekday = "Sun" ]
    then
        echo "Its weekend :)p"
    else
        if [ -f "$BhavCopyFileName" ]
        then
            echo "$BhavCopyFileName File already downloded"
        else
            curl -o file.zip $BhavCopyLink
            unzip file.zip
            mv *.csv $BhavCopyFilePath
            rm -rf file.zip
        fi
    fi
}

main