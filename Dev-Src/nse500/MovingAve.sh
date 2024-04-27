cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/CSV

#lastTradeDay means whichever the recent bhavcopy file present in the dir will pick the date of it.
lastTradeDay=`ls -lrt *.csv | tail -1 |rev | cut -d ' ' -f 1 | rev | cut -d '_' -f 1`
year=`echo $lastTradeDay| cut -c-4`
month=`echo $lastTradeDay| cut -c5-6`
day=`echo $lastTradeDay| cut -c7-8`

Months=(XXX JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC)
index=$((10#$month))
month=${Months[index]}

lastTradeDay="$day-$month-$year"

#clearing the existing data
rm -rf /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent200CSV/*
rm -rf /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent44CSV/*

cd -
#This func extract equity symbol EQ from csv.
FilterEQFromCSV()
{
    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/CSV/
    rm -rf EquityNames.txt
    for filename in `ls`
    do
        cat $filename | grep SERIES > /dev/null
        if [ $? -eq 1 ]
        then
            echo "formated"
            return;
        fi
        cat $filename | head -1 >RawFile
        grep -w "EQ" $filename >>RawFile
        rm -rf $filename
        mv RawFile $filename
    done
}

# This Function extract Symbol, Open, High, Low, Close, Timestamp coloum from csv file
# then will copy those file in Data/Recent200CSV and Data/Recent44CSV
FilterUseFullColFromCSV()
{
    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/CSV/
    #PQR is temp dir
    mkdir -p /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/PQR
    for filename in `ls`
    do
        cat $filename | grep SERIES > /dev/null
        if [ $? -eq 1 ]
        then
            echo "formated"
            return;
        fi
        cat $filename | awk -F',' '{print $1","$3","$4","$5","$6","$11}' > RawFile
        cp RawFile /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/PQR/$filename       
    done
    rm -rf RawFile

    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/PQR
    #keep only recent 200 files
    for filename in `ls -lv /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/PQR/ | tail -n -200 | awk '{print $NF}'`
    do
        cp $filename /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent200CSV/
    done 
    #keep only recent 44 files
     for filename in `ls -lv /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/PQR/ | tail -n -44 | awk '{print $NF}'`
    do
        cp $filename /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent44CSV/
    done 

    rm -rf /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/PQR
}

FilterEQFromCSV200()
{
    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent200CSV/
    rm -rf EquityNames.txt
    for filename in `ls -lrt | tail -200`
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
    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent44CSV/
    rm -rf EquityNames.txt
    #we need only recent 44 files
    for filename in `ls -lrt | tail -44`
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
    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent200CSV/
    for filename in `ls -lrt | tail -200`
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
    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent44CSV/
    for filename in `ls -lrt | tail -44`
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

#This function make a list of the Stock in EquityNames.txt file
StockList()
{
    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent44CSV/
    cat `ls -lrt *.csv | tail -1 |rev | cut -d ' ' -f 1 | rev` | awk -F',' '{print $1}' > EquityNames.txt
    # sed -i 1d EquityNames.txt
    sed -i '' 1d EquityNames.txt
    cp EquityNames.txt /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent200CSV/
}

# After filter all the data, this is the main function which will first segregate each share name
# from Date e.g. 20240425.csv file into separet share file name  e.g. ABC.csv
# then store those in Data/Equity/44Days/ and Data/Equity/200Days/
# then it will pick each share.csv file name, e.g. ABC.csv and calculate its
# 200 and 44 Days average, its current price, equity name
# redirect equity name, curr price, 200 and 44 avg into Data/Average/Analysis.csv file
findStock()
{
    rm -rf /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/44Days/*
    rm -rf /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/200Days/*
    for equity in `cat /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent200CSV/EquityNames.txt`
    do
        grep -wh $equity /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent200CSV/*.csv > /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/200Days/$equity.csv
        grep -wh $equity /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Recent44CSV/*.csv > /Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/44Days/$equity.csv
    done

    cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500

    for equity in `ls /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/44Days/`
    do
        sum44=0
        sum200=0
        cat "/Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/200Days/$equity" | awk -F',' '{sum200+=$5;}END{print sum200;}' > sm200
        cat "/Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/44Days/$equity" | awk -F',' '{sum44+=$5;}END{print   sum44;}' > sm44

        sum200=`cat sm200`
        sum44=`cat sm44`
        MvAvg200=`./file.sh $sum200 200`
        MvAvg44=`./file.sh $sum44 44`
        CurrPrice=`grep $lastTradeDay /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Equity/44Days/$equity | awk -F',' '{print $5}'`
        equityName=`echo $equity | awk -F'.' '{print $1}'`
        echo "$equityName,$CurrPrice,$MvAvg44,$MvAvg200" >> /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Average/Analysis.csv
    done

    rm -rf sm44
    rm -rf sm200
}

main()
{
    # FilterEQFromCSV200
    # FilterEQFromCSV44
    # FilterUseFullColFromCSV200
    # FilterUseFullColFromCSV44
    FilterEQFromCSV
    FilterUseFullColFromCSV
    StockList
    findStock
}
>/Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Average/Analysis.csv
main
cp /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Average/Analysis.csv "/Users/rj1aditya//Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/Data/Average/Analysis_`date +%d%m%Y`.csv"
cd /Users/rj1aditya/Desktop/T1/Scr/Nifty/Stock-MA44filter/Dev-Src/nse500/
. ./FilterAnalysis.sh