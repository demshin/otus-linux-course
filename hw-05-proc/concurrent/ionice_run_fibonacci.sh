#!/bin/bash

echo "start '$(date)'" > ionice.log

high_priority () {
    ionice -c 2 -n 0 ./fibonacci.sh 20
    echo "process with high priority finished at '$(date)'" >> ionice.log
}

low_priority () {
    ionice -c 3 -n 7 ./fibonacci.sh 20
    echo "process with low priority finished at '$(date)'" >> ionice.log
}

high_priority &
low_priority &
wait
