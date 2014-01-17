#!/bin/bash

run_with_confirmation(){
    if [[ "${AUTO_AGREE}" == "true" ]]; then
        eval $1
    else
        for (( ; ; )); do
            echo -n "Execute command: $1? (type 'yes' if you do, type 'no' if you don't, type 'yes for all' if you want to answer 'yes' for all remain packages) > "
            read ANSWER
            if [[ $ANSWER == "yes" ]]; then
                eval $1
                break
            elif [[ $ANSWER == "no" ]]; then
                break
            elif [[ $ANSWER == "yes for all" ]]; then
                eval $1
                AUTO_AGREE="true"
                break
            else
                echo "Wrong input. Will ask again."
            fi
        done
    fi
}