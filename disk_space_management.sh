#!/bin/bash
TOTAL=24
ALLOCATED=`cat disk_utilization`

function disk_release {
	RELEASED=$1
	if [ $((ALLOCATED-RELEASED)) -ge 0 ]; then
		ALLOCATED=$((ALLOCATED-RELEASED))
		echo $ALLOCATED > disk_utilization
		echo $ALLOCATED
	fi
}

function disk_request {
	REQUEST=$1
	if [ $ALLOCATED -lt $TOTAL ]; then
		ALLOCATED=$((ALLOCATED+REQUEST))
		echo $ALLOCATED > disk_utilization
		echo $ALLOCATED
	else
		echo FULL
	fi
}
