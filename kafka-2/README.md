cd kafka_docker
docker-compose up -d
./start-kafka-shell.sh
$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper $ZK --replication-factor 1 --partitions 1 --topic topic

> docker network ls
> /sbin/ip route|awk '/default/ { print $3 }'
> docker run --rm --link kafkadocker_zookeeper_1 --net kafkadocker_default producer`

