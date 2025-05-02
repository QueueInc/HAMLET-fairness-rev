#!/bin/bash

echo "Running Experiments"

VERSION="$1"
FAIR_MODE="$2"
FAIR_METRIC="$3"
MINING_TARGET="$4"
TIME_BUDGET=$5
KB_NAME="$6"
GH_TOKEN="$7"
RUN="$8"
ITERATIONS="$9"

upload_results() {

    while true; do
        cd /home
        rm -rf HAMLET-fairness-rev-results

        echo "Cloning repo..."
        if git clone "https://$GH_TOKEN@github.com/QueueInc/HAMLET-fairness-rev-results.git"; then
            cd HAMLET-fairness-rev-results || continue
            
            echo "Cleaning target folder..."
            rm -rf "./$RUN-$TIME_BUDGET-$KB_NAME-$FAIR_MODE-$VERSION-$FAIR_METRIC-$MINING_TARGET"

            echo "Copying results..."
            if cp -r "/test" "./$RUN-$TIME_BUDGET-$KB_NAME-$FAIR_MODE-$VERSION-$FAIR_METRIC-$MINING_TARGET"; then

                echo "Staging changes..."
                if git add . && git commit -m "new results in $RUN-$TIME_BUDGET-$KB_NAME-$FAIR_MODE-$VERSION-$FAIR_METRIC-$MINING_TARGET"; then

                    echo "Pushing to remote..."
                    if git push; then
                        echo "Push succeeded!"
                        break
                    else
                        echo "Push failed. Restarting process..."
                    fi
                fi
            fi
        fi

        echo "Waiting before retrying..."
        sleep 5
    done
    cd /home/HAMLET-fairness-rev
}

wget https://github.com/QueueInc/HAMLET/releases/download/$VERSION/hamlet-$VERSION-all.jar

git config --global user.email "j.giovanelli@unibo.it"
git config --global user.name "Joseph Giovanelli"

python automl/run_hamlet.py --fair-mode "$FAIR_MODE" --workspace /test/hamlet/ika --fair_metric "$FAIR_METRIC" --mining_target "$MINING_TARGET" --batch_size 999999 --time_budget $(expr $TIME_BUDGET / $ITERATIONS) --version $VERSION --iterations $ITERATIONS --kb /home/HAMLET-fairness-rev/resources/$KB_NAME.txt
upload_results
python automl/run_hamlet.py --fair-mode "$FAIR_MODE" --workspace /test/hamlet/pkb_ika --fair_metric "$FAIR_METRIC" --mining_target "$MINING_TARGET" --batch_size 999999 --time_budget $(expr $TIME_BUDGET / $ITERATIONS) --version $VERSION --iterations $ITERATIONS --kb /home/HAMLET-fairness-rev/resources/p$KB_NAME.txt
upload_results
python automl/run_hamlet.py --fair-mode "$FAIR_MODE" --workspace /test/hamlet/baseline --fair_metric "$FAIR_METRIC" --mining_target "$MINING_TARGET" --batch_size 999999 --time_budget $TIME_BUDGET --version $VERSION --iterations 1 --kb /home/HAMLET-fairness-rev/resources/$KB_NAME.txt
upload_results
python automl/run_hamlet.py --fair-mode "$FAIR_MODE" --workspace /test/hamlet/pkb --fair_metric "$FAIR_METRIC" --mining_target "$MINING_TARGET" --batch_size 999999 --time_budget $TIME_BUDGET --version $VERSION --iterations 1 --kb /home/HAMLET-fairness-rev/resources/p$KB_NAME.txt
upload_results

# python automl/run_comparison.py --tool auto-sklearn --budget 3600 --output_folder $1/auto_sklearn
# python automl/run_comparison.py --tool h2o --budget 3600 --output_folder $1/h2o
# python automl/post_processor/etl.py --path $1 --input-folder hamlet --output-folder hamlet --budget 500
