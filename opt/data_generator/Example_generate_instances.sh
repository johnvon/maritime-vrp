#!/bin/bash

scenario="Example"
hub="DEBRV"
discretisation=2
at_hub=6

weeks=(
  1
  2
)

min_handling=(
  2
  3
)
max_handling=(
  4
  5
)

min_tr=60
max_tr=78

bunker_price=(
  250
  375
  500
)
penalty=(
  0
  1
  2
  5
  10
  20
  30
  40
  50
  60
  70
  80
  90
  100
)

min_tw=(
  0
)
max_tw=(
  0
  1
)

for wk in "${weeks[@]}"
do

  for hdl_id in "${!min_handling[@]}"
  do

    for bnk in "${bunker_price[@]}"
    do
    
      for pen in "${penalty[@]}"
      do
      
        for trn in {true,false}
        do
        
          trn_str=""
                
          if [[ "$trn" = false ]]
          then
            trn_str="no_no"
          else
            trn_str="${min_tr}_${max_tr}"
          fi
        
          ./data_generator.rb \
            --scenario="${scenario}" \
            --hub="${hub}" \
            --discretisation="${discretisation}" \
            --weeks="${wk}" \
            --time-spent-at-hub="${at_hub}" \
            --min-handling="${min_handling[hdl_id]}" \
            --max-handling="${max_handling[hdl_id]}" \
            --bunker-price="${bnk}" \
            --tw=false \
            --min-tw=0 \
            --max-tw=0 \
            --transfer="${trn}" \
            --min-transfer="${min_tr}" \
            --max-transfer="${max_tr}" \
            --penalty-coefficient="${pen}" > "../../data/new/${scenario}_${wk}_${min_handling[hdl_id]}_${max_handling[hdl_id]}_${bnk}_${pen}_no_no_${trn_str}.json"

          for mtiw in "${min_tw[@]}"
          do

            for Mtiw in "${max_tw[@]}"
            do

              ./data_generator.rb \
                --scenario="${scenario}" \
                --hub="${hub}" \
                --discretisation="${discretisation}" \
                --weeks="${wk}" \
                --time-spent-at-hub="${at_hub}" \
                --min-handling="${min_handling[hdl_id]}" \
                --max-handling="${max_handling[hdl_id]}" \
                --bunker-price="${bnk}" \
                --tw=true \
                --min-tw="${mtiw}" \
                --max-tw="${Mtiw}" \
                --transfer="${trn}" \
                --min-transfer="${min_tr}" \
                --max-transfer="${max_tr}" \
                --penalty-coefficient="${pen}" > "../../data/new/${scenario}_${wk}_${min_handling[hdl_id]}_${max_handling[hdl_id]}_${bnk}_${pen}_${mtiw}_${Mtiw}_${trn_str}.json"
            
            done
          
          done
  
        done

      done

    done

  done
  
done