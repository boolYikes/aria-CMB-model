#/usr/bin/env bash
fldr="/workspace/notebooks"
if [ -d "$fldr" ]; then
	echo "$fldr exists. Starting server."
else
	mkdir "$fldr"
	echo "Made dir $fldr . Proceeding."
fi
/root/miniconda3/envs/nnunet01/bin/jupyter notebook --notebook-dir=$fldr --ip='*' --port=8888 --no-browser --allow-root
