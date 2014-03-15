source memory_mamagement.sh
EXP="^$1 " 
xm list | grep $EXP
if [ $? = 0 ]; then 
	xm shutdown $1
fi
LINE=`grep $EXP active_nodes.log`
PUBIPNET=`echo $LINE | awk '{print $2}'`
PRIVIPNET=`echo $LINE | awk '{print $3}'`
PUBIPV6NET=`echo $LINE | awk '{print $4}'`
MEM=`echo $LINE | awk '{print $5}'`
./dealloca_risorsa.sh publicip.allocation $PUBIPNET
./dealloca_risorsa.sh publicipv6.allocation $PUBIPV6NET
./dealloca_risorsa.sh privip.allocation $PRIVIPNET
mem_release $MEM
sed -i '/'${1}' '${PUBIPNET}' '${PRIVIPNET}' '${PUBIPV6NET}'/d' active_nodes.log

