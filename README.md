# kafka-mirrormaker-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/zeelos/kafka-mirrormaker.svg?maxAge=604800)](https://hub.docker.com/r/zeelos/kafka-mirrormaker)

A Docker image that executes a kafka MirrorMaker process. It follows the Dockerfile template creation as specified by Confluent's [own images](https://github.com/confluentinc/cp-docker-images).

The image follows Confluent platform versioning so that is easier for you to match your own Kafka installation, that is you can use either tag `4.1.1` or `5.0.0` to match your specific versions.

An example usage in a `docker-compose.yml` file can be like the following. Note the usage of `MIRRORMAKER_` prefix (for MirrorMaker specific configuration), `CONSUMER_` (for consumer configuration) and `PRODUCER_` (for producer configuration).

      kafka-mirrormaker:
        image: zeelos/kafka-mirrormaker:4.1.1
        environment:
          - MIRRORMAKER_WHITE_LIST=^server1_((?!req).)*$$
          - MIRRORMAKER_ABORT_ON_SEND_FAILURE=true
          - MIRRORMAKER_OFFSET_COMMIT_INTERVAL=60000
          - MIRRORMAKER_NUM_STREAMS=1
          - MIRRORMAKER_CONSUMER_REBALANCE_LISTENER=org.mypackage.MyListener
          - MIRRORMAKER_CONSUMER_REBALANCE_LISTENER_ARGS=arg1,arg2
          - MIRRORMAKER_MESSAGE_HANDLER=org.mypackage.MyHandler
          - MIRRORMAKER_MESSAGE_HANDLER_ARGS=arg1,arg2
          - CONSUMER_BOOTSTRAP_SERVERS=kafka-source-server:9092
          - CONSUMER_GROUP_ID=MirrorMaker
          - CONSUMER_AUTO_OFFSET_RESET=latest
          - PRODUCER_BOOTSTRAP_SERVERS=kafka-destination-server:9092
        ...

> NOTE: Make sure you correctly escape your regular expression for '__MIRRORMAKER\_WHITE\_LIST__' configuration so that no to conflict with docker during expansion. In the example above, we used a double dollar sign ($$) to escape the single dollar ($).