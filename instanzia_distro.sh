source lvmlib.sh
source memory_mamagement.sh
MACHINE_NAME=$1
VG_NAME=`get_vg_name`
BLOCK_DEVICE=/dev/$VG_NAME/$MACHINE_NAME
MOUNTING_POINT=/mnt/$MACHINE_NAME
if [ ! -e $BLOCK_DEVICE ]; then
	echo DISCO LVM NON PRESENTE
	exit 1
fi
PUBIPNET=`./alloca_risorsa.sh publicip.allocation`
PUBIP=`echo $PUBIPNET | awk -F"_" '{print $1}'`
PUBNET=`echo $PUBIPNET | awk -F"_" '{print $2}'`
PUBIPV6NET=`./alloca_risorsa.sh publicipv6.allocation`
PUBIPV6=`echo $PUBIPV6NET | awk -F"_" '{print $1}'`
PUBNETV6=`echo $PUBIPV6NET | awk -F"_" '{print $2}'`
PRIVIPNET=`./alloca_risorsa.sh privip.allocation`
PRIVIP=`echo $PRIVIPNET | awk -F"_" '{print $1}'`
PRIVNET=`echo $PRIVIPNET | awk -F"_" '{print $2}'`
MEM=`mem_request 512`

if [ "$PUBIP" != "NONE" -a "$PRIVIP" != "NONE" -a "$PUBIPV6" != "NONE" -a "$MEM" != "FULL" ]; then
	echo $1" "$PUBIPNET" "$PRIVIPNET" "$PUBIPV6NET" "$MEM>> active_nodes.log
	mkfs.ext2 $BLOCK_DEVICE
	mkdir $MOUNTING_POINT
	mount $BLOCK_DEVICE $MOUNTING_POINT
	#debootstrap --no-check-gpg  --include openssh-server,screen,linux-headers-amd64,linux-image-amd64 stable $MOUNTING_POINT http://mi.mirror.garr.it/mirrors/debian/
	debootstrap --no-check-gpg --unpack-tarball=`pwd`/master.tar --include openssh-server,screen,linux-headers-amd64,linux-image-amd64 stable $MOUNTING_POINT
	#set hostnane
	echo $MACHINE_NAME > $MOUNTING_POINT/etc/hostname
	#root passwd done //pass:pippopippo
	cat $MOUNTING_POINT/etc/shadow | sed 's/root:.*/root:$6$llV68BFn$lVz\/0l3ruAqrVpIA4FtWe\/1H9dZzhhUPtfBLqp21VrX\/d295opruhv2I9k5GJkmr0DpqpelxPD7Gb6tzjBe7\/1:16030:0:99999:7:::/' > $MOUNTING_POINT/etc/shadow.new 
	mv $MOUNTING_POINT/etc/shadow.new $MOUNTING_POINT/etc/shadow
	#hvc0 su inittab done 
	cat $MOUNTING_POINT/etc/inittab | sed 's/tty1$/hvc0/' > $MOUNTING_POINT/etc/inittab.tmp
	mv $MOUNTING_POINT/etc/inittab.tmp $MOUNTING_POINT/etc/inittab
	#xen config /vedi /etc/xen/nodo.cfg done
	./crea_xen_config.sh $MACHINE_NAME $MEM
	#imposta IP
	./crea_net_interface.sh $MACHINE_NAME $PUBIP $PUBNET $PRIVIP $PRIVNET $PUBIPV6 $PUBNETV6
	#smonta done
	umount $MOUNTING_POINT
	#xm create done
	xm create /etc/xen/$MACHINE_NAME.cfg
else
	echo RISORSE NON SUFFICIENTI
fi	
