#!/bin/bash
echo Running EXPERIMENTS
wget https://github.com/QueueInc/HAMLET/releases/download/1.0.0/hamlet-1.0.0-all.jar
python3 -m venv venv
source venv/bin/activate
python -m pip install --upgrade pip
python -m pip install openml
python -m pip install tqdm
python -m pip install pandas
python automl/run_hamlet.py --workspace $(pwd)/results/hamlet/baseline --metric balanced_accuracy --mode max --batch_size 500 --time_budget 3600 --version 1.0.0 --iterations 1 --kb $(pwd)/resources/kb.txt
python automl/run_hamlet.py --workspace $(pwd)/results/hamlet/pkb --metric balanced_accuracy --mode max --batch_size 500 --time_budget 3600 --version 1.0.0 --iterations 1 --kb $(pwd)/resources/pkb.txt
python automl/run_hamlet.py --workspace $(pwd)/results/hamlet/ika --metric balanced_accuracy --mode max --batch_size 125 --time_budget 900 --version 1.0.0 --iterations 4 --kb $(pwd)/resources/kb.txt
python automl/run_hamlet.py --workspace $(pwd)/results/hamlet/pkb_ika --metric balanced_accuracy --mode max --batch_size 125 --time_budget 900 --version 1.0.0 --iterations 4 --kb $(pwd)/resources/pkb.txt
python automl/run_comparison.py --tool h2o --budget 3600 --output_folder results/h2o
python automl/run_comparison.py --tool auto_sklearn --budget 3600 --output_folder results/auto_sklearn
python automl/post_processor/etl.py --input-folder hamlet --output-folder hamlet --budget 500
deactivate
