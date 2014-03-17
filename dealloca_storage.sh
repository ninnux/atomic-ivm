#!/bin/bash
TOTAL=18
ALLOCATED=`cat disk_utilization`
source disk_space_management.sh
source lvmlib.sh

dealloca_spazio(){
	echo lvremove /dev/`get_vg_name`/$1 
	#controlla se e' stato deallocato
}

#cerca_cosa_cancellare(){
	#ritorna se esiste lvm	o altro tipo di storage
		
#}

`dealloca_spazio $1`
disk_release 6
