#!/bin/bash
TOTAL=4096
ALLOCATED=`cat memory_utilization`

function mem_release {
	RELEASED=$1
	if [ $((ALLOCATED-RELEASED)) -ge 0 ]; then
		ALLOCATED=$((ALLOCATED-RELEASED))
		echo $ALLOCATED > memory_utilization
		echo $ALLOCATED
	fi
}

function mem_request {
	REQUEST=$1
	if [ $ALLOCATED -lt $TOTAL ]; then
		ALLOCATED=$((ALLOCATED+REQUEST))
		echo $ALLOCATED > memory_utilization
		echo $REQUEST
	else
		echo FULL
	fi
}

