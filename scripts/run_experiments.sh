#!/bin/bash
echo Running EXPERIMENTS
wget https://github.com/QueueInc/HAMLET/releases/download/$2/hamlet-$2-all.jar
python automl/run_hamlet.py --workspace $1/hamlet/baseline --metric balanced_accuracy --fair_metric $4 --mining_target $5 --mode max --batch_size 500 --time_budget 7200 --version $2 --iterations 1 --volume $3 --kb /home/HAMLET-fairness/resources/kb.txt
python automl/run_hamlet.py --workspace $1/hamlet/pkb --metric balanced_accuracy --fair_metric $4 --mining_target $5 --mode max --batch_size 500 --time_budget 7200 --version $2 --iterations 1 --volume $3 --kb /home/HAMLET-fairness/resources/pkb.txt
python automl/run_hamlet.py --workspace $1/hamlet/ika --metric balanced_accuracy --fair_metric $4 --mining_target $5 --mode max --batch_size 125 --time_budget 1800 --version $2 --iterations 4 --volume $3 --kb /home/HAMLET-fairness/resources/kb.txt
python automl/run_hamlet.py --workspace $1/hamlet/pkb_ika --metric balanced_accuracy --fair_metric $4 --mining_target $5 --mode max --batch_size 125 --time_budget 1800 --version $2 --iterations 4 --volume $3 --kb /home/HAMLET-fairness/resources/pkb.txt
# python automl/run_comparison.py --tool auto-sklearn --budget 3600 --output_folder $1/auto_sklearn
# python automl/run_comparison.py --tool h2o --budget 3600 --output_folder $1/h2o
# python automl/post_processor/etl.py --path $1 --input-folder hamlet --output-folder hamlet --budget 500
