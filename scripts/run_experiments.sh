#!/bin/bash
echo Running EXPERIMENTS
wget https://github.com/QueueInc/HAMLET/releases/download/1.0.0/hamlet-1.0.0-all.jar
# python automl/run_hamlet.py --workspace $1/hamlet/baseline --metric balanced_accuracy --mode max --batch_size 500 --time_budget 3600 --version 1.0.0 --iterations 1 --kb /home/HAMLET-FGCS2022/resources/kb.txt
# python automl/run_hamlet.py --workspace $1/hamlet/pkb --metric balanced_accuracy --mode max --batch_size 500 --time_budget 3600 --version 1.0.0 --iterations 1 --kb /home/HAMLET-FGCS2022/resources/pkb.txt
# python automl/run_hamlet.py --workspace $1/hamlet/ika --metric balanced_accuracy --mode max --batch_size 125 --time_budget 900 --version 1.0.0 --iterations 4 --kb /home/HAMLET-FGCS2022/resources/kb.txt
# python automl/run_hamlet.py --workspace $1/hamlet/pkb_ika --metric balanced_accuracy --mode max --batch_size 125 --time_budget 900 --version 1.0.0 --iterations 4 --kb /home/HAMLET-FGCS2022/resources/pkb.txt
python automl/run_comparison.py --tool auto-sklearn --budget 3600 --output_folder $1/auto_sklearn
python automl/run_comparison.py --tool h2o --budget 3600 --output_folder $1/h2o
python automl/post_processor/etl.py --input-folder $1/hamlet --output-folder $1/hamlet --budget 500
