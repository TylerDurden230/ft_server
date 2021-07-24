# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fd-agnes <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/27 17:08:30 by fd-agnes          #+#    #+#              #
#    Updated: 2021/02/27 17:08:45 by fd-agnes         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get install nano
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server

COPY ./srcs/flow.sh ./
COPY ./srcs/nginx-conf_on ./tmp/
COPY ./srcs/nginx-conf_off ./tmp/
COPY ./srcs/activeAutoindex.sh ./
COPY ./srcs/phpmyadmin.inc.php ./tmp/phpmyadmin.inc.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php
RUN chmod 755 ./activeAutoindex.sh

CMD bash flow.sh
