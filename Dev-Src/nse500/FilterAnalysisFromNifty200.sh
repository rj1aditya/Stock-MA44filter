#This function compare the Current Mkt price from 44MVA and 200MVA, and make entries in the AnalysisFilt.csv
WatchList()
{
    cd /home/rj1aditya/Dev/Scr/nse500/Data/
    >./Average/Analysis_CurMktPrc_Below_200_44.csv
    >./Average/Analysis_CurMktPrc_Above_200_44.csv
    for equityName in `cat Nifty200`
    do
        grep -w $equityName ./Average/AnalysisFilt_CurMktPrc_Below_200_44.csv >> ./Average/Analysis_CurMktPrc_Below_200_44.csv
    done
    for equityName in `cat Nifty200`
    do
        grep -w $equityName ./Average/AnalysisFilt_CurMktPrc_Above_200_44.csv >> ./Average/Analysis_CurMktPrc_Above_200_44.csv
    done
}

main()
{
    WatchList
}

main