#!/bin/bash

## Use this script to launch training jobs in the background

JOB_NAME="finetune_boman_pt_on_10ct_tm"

DATA_ROOT_DIR="/home/ec2-user/other/slu/projects/bh-experimental/wizard_hat/conditional_plm/res/datasets/rt"
DATA_JOB_DIR="${DATA_ROOT_DIR}/capulet_382_10ct_random_mut_hsa-display-ml_helper-tm-otf-0_0/"

OUTPUT_ROOT_DIR="/home/ec2-user/other/slu/projects/bh-experimental/wizard_hat/conditional_plm/res/experiments/rt"
OUTPUT_DIR="${OUTPUT_ROOT_DIR}/${JOB_NAME}"

PRETRAINED_MODEL_PATH="/home/ec2-user/other/slu/.gt4sd/algorithms/conditional_generation/RegressionTransformer/RegressionTransformerProteins/stability/"

# Finetuning job
gt4sd-trainer \
	--training_pipeline_name regression-transformer-trainer \
	--model_path ${PRETRAINED_MODEL_PATH} \
	--do_train \
	--do_eval \
	--cc_loss \
	--output_dir ${OUTPUT_DIR} \
	--train_data_path ${DATA_JOB_DIR}/train.csv \
	--test_data_path ${DATA_JOB_DIR}/val.csv \
	--overwrite_output_dir \
	--batch_size 16 \
	--train_batch_size 16 \
	--per_device_train_batch_size 16 \
	--eval_steps 100 \
	--logging_steps 100 \
	--alternate_steps 50 \
	--gradient_accumulation_steps 1 \
	--eval_accumulation_steps 1 \
	--cc_loss_weight 1 \
	--save_total_limit 2 \
	--save_steps 0 \
	--num_train_epochs 5
