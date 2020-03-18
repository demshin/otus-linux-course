#!/bin/bash

echo "started '$(date)'" >nice.log

high_priority() {
	nice -n-20 ./fibonacci.sh 20
	echo "process with high priority finished at '$(date)'" >>nice.log
}

low_priority() {
	nice -n19 ./fibonacci.sh 20
	echo "process with low priority finished at '$(date)'" >>nice.log
}

high_priority &
low_priority &
wait
