#!/bin/bash
TOTAL=30
ALLOCATED=`cat disk_utilization`
source disk_space_management.sh

get_vg_name(){
	echo atomic-dom0
}

alloca_spazio(){
	disk_available=`disk_request 6`
	if [ "$disk_available" != "FULL" ]; then
		echo lvcreate -L6G -n${1} `get_vg_name`
		#controlla se e' stato creato
	else
		echo echo SPAZIO FINITO
	fi
}

#cerca_spazio_adatto(){
	#ritorna se esiste lvm	o altro tipo di storage
		
#}

`alloca_spazio $1`
