# script to remove blank spaces

echo "############################################"
echo "Cutting" $# "files:"
echo "############################################"

while [ $# -gt 0 ]
do
	ps2epsi $1 $1.tmp
	echo "cutting $1"
	mv $1.tmp $1

	shift
done




