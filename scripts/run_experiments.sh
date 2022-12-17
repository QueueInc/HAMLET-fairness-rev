#!/bin/bash
echo Running EXPERIMENTS
wget https://github.com/QueueInc/HAMLET/releases/download/1.0.0/hamlet-1.0.0-all.jar
python automl/run_hamlet.py --workspace /home/HAMLET-FGCS2022/results/hamlet/baseline --metric balanced_accuracy --mode max --batch_size 500 --time_budget 10 --version 1.0.0 --iterations 1 --kb /home/HAMLET-FGCS2022/resources/kb.txt
python automl/run_hamlet.py --workspace /home/HAMLET-FGCS2022/results/hamlet/pkb --metric balanced_accuracy --mode max --batch_size 500 --time_budget 10 --version 1.0.0 --iterations 1 --kb /home/HAMLET-FGCS2022/resources/pkb.txt
python automl/run_hamlet.py --workspace /home/HAMLET-FGCS2022/results/hamlet/ika --metric balanced_accuracy --mode max --batch_size 125 --time_budget 10 --version 1.0.0 --iterations 4 --kb /home/HAMLET-FGCS2022/resources/kb.txt
python automl/run_hamlet.py --workspace /home/HAMLET-FGCS2022/results/hamlet/pkb_ika --metric balanced_accuracy --mode max --batch_size 125 --time_budget 10 --version 1.0.0 --iterations 4 --kb /home/HAMLET-FGCS2022/resources/pkb.txt
python automl/run_comparison.py --tool h2o --budget 10 --output_folder results/h2o
python automl/run_comparison.py --tool auto_sklearn --budget 10 --output_folder results/auto_sklearn
python automl/post_processor/etl.py --input-folder hamlet --output-folder hamlet --budget 500
