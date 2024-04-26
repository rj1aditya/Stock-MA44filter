cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent44CSV/
lastTradeDay=`ls 1cm*.csv | cut -c4-12`
day=`echo $lastTradeDay| cut -c-2`
month=`echo $lastTradeDay| cut -c3-5`
year=`echo $lastTradeDay| cut -c6-`
lastTradeDay="$day-$month-$year"
cd -
#This func extract equity symbol from csv.
FilterEQFromCSV200()
{
    cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent200CSV/
    for filename in `ls`
    do
        cat $filename | grep SERIES > /dev/null
        if [ $? -eq 1 ]
        then
            echo "formated"
            return;
        fi
        cat $filename | head -1 >>RawFile
        grep -w "EQ" $filename >>RawFile
        >$filename
        mv RawFile $filename
    done
    rm -rf RawFile
}

FilterEQFromCSV44()
{
    cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent44CSV/
    for filename in `ls`
    do
        cat $filename | grep SERIES > /dev/null
        if [ $? -eq 1 ]
        then
            echo "formated"
            return;
        fi
        cat $filename | head -1 >>RawFile
        grep -w "EQ" $filename >>RawFile
        >$filename
        mv RawFile $filename
    done
    rm -rf RawFile
}

# This Function extract Symbol, Open, High, Low, Close, Timestamp coloum from csv file
FilterUseFullColFromCSV200()
{
    cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent200CSV/
    for filename in `ls`
    do
        cat $filename | grep SERIES > /dev/null
        if [ $? -eq 1 ]
        then
            echo "formated"
            return;
        fi
        cat $filename | awk -F',' '{print $1","$3","$4","$5","$6","$11}' >> RawFile
        >$filename
        mv RawFile $filename
    done
    rm -rf RawFile
}

FilterUseFullColFromCSV44()
{
    cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent44CSV/
    for filename in `ls`
    do
        cat $filename | grep SERIES > /dev/null
        if [ $? -eq 1 ]
        then
            echo "formated"
            return;
        fi
        cat $filename | awk -F',' '{print $1","$3","$4","$5","$6","$11}' >> RawFile
        >$filename
        mv RawFile $filename
    done
    rm -rf RawFile
}

StockList()
{
    cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent44CSV/
    cat 1cm*.csv | awk -F',' '{print $1}' > EquityNames.txt
    sed -i 1d EquityNames.txt
    cp EquityNames.txt /home/rj1aditya/Dev/Scr/nse500/Data/Recent200CSV
}

findStock()
{
    cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent44CSV/
    for equity in `cat EquityNames.txt`
    do
        grep -wh $equity *.csv > /home/rj1aditya/Dev/Scr/nse500/Data/Equity/44Days/$equity.csv
    done

    cd /home/rj1aditya/Dev/Scr/nse500/Data/Recent200CSV
    for equity in `cat EquityNames.txt`
    do
        grep -wh $equity *.csv > /home/rj1aditya/Dev/Scr/nse500/Data/Equity/200Days/$equity.csv
    done

    cd /home/rj1aditya/Dev/Scr/nse500/Data/Equity/44Days

    for equity in `ls`
    do
        sum44=0
        sum200=0
        cat "/home/rj1aditya/Dev/Scr/nse500/Data/Equity/200Days/$equity" | awk -F',' '{sum200+=$5;}END{print sum200;}' > sm200
        cat "/home/rj1aditya/Dev/Scr/nse500/Data/Equity/44Days/$equity" | awk -F',' '{sum44+=$5;}END{print   sum44;}' > sm44

        sum200=`cat sm200`
        sum44=`cat sm44`
        MvAvg200=`divide $sum200 200`
        MvAvg44=`divide $sum44 44`
        CurrPrice=`grep $lastTradeDay /home/rj1aditya/Dev/Scr/nse500/Data/Equity/44Days/$equity | awk -F',' '{print $5}'`
        equityName=`echo $equity | awk -F'.' '{print $1}'`
        echo "$equityName,$CurrPrice,$MvAvg44,$MvAvg200" >> /home/rj1aditya/Dev/Scr/nse500/Data/Average/Analysis.csv
    done

    rm -rf sm44
    rm -rf sm200
}

main()
{
    FilterEQFromCSV200
    FilterEQFromCSV44
    FilterUseFullColFromCSV200
    FilterUseFullColFromCSV44
    StockList
    findStock
}
>/home/rj1aditya/Dev/Scr/nse500/Data/Average/Analysis.csv
main
cp /home/rj1aditya/Dev/Scr/nse500/Data/Average/Analysis.csv "/home/rj1aditya/Dev/Scr/nse500/Data/Average/Analysis_`date +%d%m%Y`.csv"