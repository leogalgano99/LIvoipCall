echo "Halting existing running containers..."

if [ "$( docker ps -q -f name=agency )" ]; then
        docker container stop agency
fi

if [ "$( docker ps -q -f name=provisioner )" ]; then
        docker container stop provisioner
fi

if [ "$( docker ps -q -f name=mediator )" ]; then
        docker container stop mediator
fi

if [ "$( docker ps -q -f name=collector )" ]; then
        docker container stop collector
fi

cd ../open5gs

if [ "$( docker ps -q -f name=upf )" ]; then
        docker compose down
fi

if [ "$( docker ps -q -f name=nr_ue_1 )" ] || [ "$( docker ps -q -f name=nr_ue_2 )" ]; then
        docker compose -f nr-ue.yaml down
fi

if [ "$( docker ps -q -f name=nr_gnb_1)" ] || [ "$( docker ps -q -f name=nr_gnb_2 )" ]; then
        docker compose -f nr-gnb.yaml down
fi