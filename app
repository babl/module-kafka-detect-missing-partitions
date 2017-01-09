#!/bin/sh

if [[ $BABL_DEBUG ]]; then
  set -x
fi

topics=$(babl babl/kafka-topics -e ACTION=list | grep .IO)

for topic in $topics; do
  n=$(babl babl/kafka-topics -e ACTION=describe -e TOPIC=$topic | egrep -o "PartitionCount:\d+" | egrep -o "\d+")

  if [ "$n" -lt "10" ]; then
    echo MISSING partitions for topic $topic, firing event
    babl babl/events -e EVENT=babl:kafka:missing-partitions -e TOPIC=$topic
  fi
done
