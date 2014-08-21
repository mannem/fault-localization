//Raja Mannem

touch    FF.txt
touch  FF1.txt
touch   Result.txt
touch  SC.txt
touch  SU.txt
touch  FC.txt
touch  FU.txt
rm -f FF.txt
rm -f FF1.txt
rm -f  Result.txt
rm -f SC.txt
rm -f SU.txt
rm -f FC.txt
rm -f FU.txt

while read LineNum
do
grep "^$LineNum       1" ./Success/*>> SC.txt
grep "^$LineNum       0" ./Success/*>> SU.txt
grep "^$LineNum       1" ./Failed/*>> FC.txt
grep "^$LineNum       0" ./Failed/*>> FU.txt
SuccessCoveredCount=`wc -l SC.txt`
SuccessUncoveredCount=`wc -l SU.txt`
FailedCoveredCount=`wc -l FC.txt`
FailedUncoveredCount=`wc -l FU.txt`
echo $LineNum $SuccessCoveredCount $SuccessUncoveredCount $FailedCoveredCount $FailedUncoveredCount >> FF.txt
echo $LineNum,$SuccessCoveredCount,$SuccessUncoveredCount,$FailedCoveredCount,$FailedUncoveredCount >> FF1.txt
rm -f SC.txt
rm -f SU.txt
rm -f FC.txt
rm -f FU.txt
done < stmnts.txt

cut -d ' ' -f1,2,4,6,8 FF.txt > Result.txt
grep -v 'Stmt#' Result.txt > temp.txt
rm -f Result.txt
cp temp.txt Result.txt
rm -f Solution.txt
while read LineNumFinal
do
var=$(echo $LineNumFinal | awk -F" " '{print $1,$2,$3,$4,$5}')
set -- $var
stmt=$1
Alpha=$4
Beta=$2
Gamma=$5
Eta=$3
AlphaSqr=`expr $Alpha \* $Alpha`
BetaSqr=`expr $Beta \* $Beta`
Numerator=`expr $AlphaSqr \+ $Eta`
Denominator=`expr $Gamma \+ $BetaSqr`
if [ $Denominator == 0 ]
then
echo $Denominator 
Denominator=1
echo $Denominator
fi
Solution=`echo "scale=2; $Numerator / $Denominator" | bc`
echo $LineNumFinal $Solution >> Solution.txt
done < Result.txt
sort -n -k6 Solution.txt > Temp.txt
tac Temp.txt > Temp2.txt
head -30 Temp2.txt > SortedSolutionDesc.txt
head -30 Temp.txt > SortedSolutionAsc.txt
