#!/bin/bash

## Use this script to launch training jobs in the background

JOB_NAME="finetune_boman_pt_on_display_kdpe"

DATA_ROOT_DIR="/home/ec2-user/other/slu/projects/bh-experimental/wizard_hat/conditional_plm/res/datasets/rt"
DATA_JOB_DIR="${DATA_ROOT_DIR}/capulet_188_1ct_random_and_twist_helper-display-ml_kdpe-otf-0_0/"

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
	--batch_size 128 \
	--train_batch_size 128 \
	--per_device_train_batch_size 128 \
	--eval_steps 1000 \
	--gradient_interval 1 \
	--eval_accumulation_steps 1 \
	--num_train_epochs 10 \
	--report_to wandb
