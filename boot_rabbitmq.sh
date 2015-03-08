#!/bin/bash
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/mnesia
chown -R rabbitmq:rabbitmq /var/log/rabbitmq
ulimit -n 4096
/usr/sbin/rabbitmq-server
