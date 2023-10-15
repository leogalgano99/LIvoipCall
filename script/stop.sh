echo "Halting existing running containers..."

if [ "$( sudo docker  ps -q -f name=agency )" ]; then
        sudo docker  container stop agency
fi

if [ "$( sudo docker  ps -q -f name=provisioner )" ]; then
        sudo docker  container stop provisioner
fi

if [ "$( sudo docker  ps -q -f name=mediator )" ]; then
        sudo docker  container stop mediator
fi

if [ "$( sudo docker  ps -q -f name=collector )" ]; then
        sudo docker  container stop collector
fi

cd ../open5gs

if [ "$( sudo docker  ps -q -f name=upf )" ]; then
        sudo docker  compose down
fi

if [ "$( sudo docker  ps -q -f name=nr_ue_1 )" ] || [ "$( sudo docker  ps -q -f name=nr_ue_2 )" ]; then
        sudo docker  compose -f nr-ue.yaml down
fi

if [ "$( sudo docker  ps -q -f name=nr_gnb_1)" ] || [ "$( sudo docker  ps -q -f name=nr_gnb_2 )" ]; then
        sudo docker  compose -f nr-gnb.yaml down
fi