steps to execute scripts

1. first copy bhavcopy data from Download/nseReport folder
nse500/Data/CSV
    note:   if bhavcopy data not present then Download it from internet manually
            make sure recent 200 files are there in Download/nseReport


2. Execute nse500/MovingAve.sh script 
    note: this script will generate Analysis_date.CSV
            this file keeps the data like
                equity name, curr price, 200 average, 44 average
    THEN FINALLY IT WILL EXECUTE FilterAnalysis.sh
        note: this script filter shares range 70 to 4000
        then creates the file Analysisfilt.csv
        then calculate the diff in curr mkt price and 44mva, and 44mva - 200 MovingAve
        then based on diff it creates 2 files AnalysisFilt_CurMktPrc_Above_200_44.csv,
        AnalysisFilt_CurMktPrc_Below_200_44.csv
