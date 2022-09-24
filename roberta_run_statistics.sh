#!/bin/bash

thresholds=( -1 1.1 1.075 1.05 1.025 1.0 0.975 0.95 )
for th in "${thresholds[@]}"
do
	# changes compute threshold value in config file
#	prev_th=$(grep compute examples/roberta/config/pretraining/base.yaml | sed -n -e 's/.*compute_threshold: //p')
#	sed -ri "s/^(\s*)(compute_threshold\s*:\s*$prev_th\s*$)/\1compute_threshold: $th/" examples/roberta/config/pretraining/base.yaml

	TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`
	SAVE_DIR=multirun/${TIMESTAMP}_th_${th/./_}_b_64_4

	# runs script 
	fairseq-hydra-train -m --config-dir examples/roberta/config/pretraining \
	 --config-name base task.data=/datasets/wikibooks hydra.sweep.dir=${SAVE_DIR}\
	  optimization.compute_threshold=${th} dataset.batch_size=64 optimization.update_freq=[4]

	# kill remaining processes and wait for recover
	pkill python
	sleep 5

done


thresholds=( -1 1.1 1.075 1.05 1.025 1.0 0.975 0.95 0.925 )
for th in "${thresholds[@]}"
do
	# changes compute threshold value in config file
#	prev_th=$(grep compute examples/roberta/config/pretraining/base.yaml | sed -n -e 's/.*compute_threshold: //p')
#	sed -ri "s/^(\s*)(compute_threshold\s*:\s*$prev_th\s*$)/\1compute_threshold: $th/" examples/roberta/config/pretraining/base.yaml

	TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`
	SAVE_DIR=multirun/${TIMESTAMP}_th_${th/./_}_b_64_4

	# runs script
	fairseq-hydra-train -m --config-dir examples/roberta/config/pretraining \
	 --config-name base task.data=/datasets/wikibooks hydra.sweep.dir=${SAVE_DIR}\
	  optimization.compute_threshold=${th} dataset.batch_size=128 optimization.update_freq=[2]

	# kill remaining processes and wait for recover
	pkill python
	sleep 5

done
#

thresholds=( -1 1.2 1.175 1.15 1.125 1.1 1.075 )
for th in "${thresholds[@]}"
do
	# changes compute threshold value in config file
#	prev_th=$(grep compute examples/roberta/config/pretraining/base.yaml | sed -n -e 's/.*compute_threshold: //p')
#	sed -ri "s/^(\s*)(compute_threshold\s*:\s*$prev_th\s*$)/\1compute_threshold: $th/" examples/roberta/config/pretraining/base.yaml

	TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`
	SAVE_DIR=multirun/${TIMESTAMP}_th_${th/./_}_b_64_4

	# runs script
	fairseq-hydra-train -m --config-dir examples/roberta/config/pretraining \
	 --config-name base task.data=/datasets/wikibooks hydra.sweep.dir=${SAVE_DIR}\
	  optimization.compute_threshold=${th} dataset.batch_size=16 optimization.update_freq=[16]

	# kill remaining processes and wait for recover
	pkill python
	sleep 5

done