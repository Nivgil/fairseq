#!/bin/bash

thresholds=( -1 2 1.975 1.95 1.925 1.9 1.875 1.85 1.825 1.8 1.775 1.75 1.725 1.7 1.675 1.65 1.625 1.6 1.575 1.55 1.525 1.5 1.475 1.45 1.425 1.4 1.375 1.35 1.325 1.3 1.275 1.25 1.225 1.2 )
for th in "${thresholds[@]}"
do
	# changes compute threshold value in config file
	prev_th=$(grep compute examples/roberta/config/pretraining/base.yaml | sed -n -e 's/.*compute_threshold: //p')
	sed -ri "s/^(\s*)(compute_threshold\s*:\s*$prev_th\s*$)/\1compute_threshold: $th/" examples/roberta/config/pretraining/base.yaml

	TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`
	SAVE_DIR=multirun/${TIMESTAMP}_th_${th/./_}_b_64_4

	# runs script 
	fairseq-hydra-train -m --config-dir examples/roberta/config/pretraining --config-name base task.data=/datasets/wikibooks hydra.sweep.dir=${SAVE_DIR}

	# kill remaining processes and wait for recover
	pkill python
	sleep 5

done
