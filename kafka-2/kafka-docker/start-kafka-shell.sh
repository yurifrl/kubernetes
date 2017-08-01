#!/bin/bash
DOCKER_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
ZOO_CONTAINER=$(docker ps | grep zookeeper | awk '{print $1}')
ZOO_PORT=$(docker port $ZOO_CONTAINER | sed -E 's/.+://g')

# This is the internal docker ip
ZK=172.17.0.1:2181

# $KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper $ZK --replication-factor 1 --partitions 1 --topic fast-messages
# $KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper $ZK --replication-factor 1 --partitions 1 --topic summary-markers
# $KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper $ZK --replication-factor 1 --partitions 1 --topic topic
# $KAFKA_HOME/bin/kafka-topics.sh --list --zookeeper $ZK

# $KAFKA_HOME/bin/kafka-topics.sh --describe --zookeeper $ZK --topic topic
# $KAFKA_HOME/bin/kafka-console-producer.sh --topic=topic --broker-list=`broker-list.sh`

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e HOST_IP=$DOCKER_IP -e ZK=$ZK -i -t wurstmeister/kafka /bin/bash
