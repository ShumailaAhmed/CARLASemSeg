ROAD_TH = 0.746
VEH_TH = 0.344
echo "WY_echo" | grader "python run.py $ROAD_TH $VEH_TH" | (echo -n "road_th: $ROAD_TH | vehicle_th: $VEH_TH" && cat) >> log.txt