FROM ubuntu:14.04
MAINTAINER Avi "avi@shippable.com"

ADD policy-rc.d /usr/sbin/policy-rc.d
RUN /bin/chmod 755 /usr/sbin/policy-rc.d

RUN apt-get update
RUN apt-get -y -q install wget logrotate

ENV DEBIAN_FRONTEND noninteractive

RUN wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN apt-key add rabbitmq-signing-key-public.asc

RUN echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install rabbitmq-server

ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config

RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management
ADD boot_rabbitmq.sh /
RUN chmod +x /boot_rabbitmq.sh

EXPOSE 5671 5672 15671

ENTRYPOINT ["/boot_rabbitmq.sh"]
