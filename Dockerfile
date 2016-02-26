FROM httpd:latest
MAINTAINER rmelick

ENV FQDN 172.17.0.6
ENV HDP_VERSION 2.3.4.0
ENV HDP_UTILS_VERSION 1.1.0.20
ENV AMBARI_VERSION 2.2.0.0

RUN apt-get update && apt-get clean all && apt-get -y install \
    yum-utils \
    createrepo \
    wget

RUN touch /etc/yum.conf
    
WORKDIR /etc/yum/repos.d
RUN wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/$HDP_VERSION/hdp.repo
RUN yum-config-manager --add-repo http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/$AMBARI_VERSION/ambari.repo

WORKDIR /usr/local/apache2/htdocs
RUN mkdir -p ambari/centos7
WORKDIR ambari/centos7
RUN reposync -r Updates-ambari-$AMBARI_VERSION

WORKDIR /usr/local/apache2/htdocs
RUN mkdir -p hdp/centos7
WORKDIR hdp/centos7
RUN reposync -r HDP-$HDP_VERSION
RUN reposync -r HDP-UTILS-$HDP_UTILS_VERSION

RUN createrepo /usr/local/apache2/htdocs/ambari/centos7/Updates-ambari-$AMBARI_VERSION
RUN createrepo /usr/local/apache2/htdocs/hdp/centos7/HDP-$HDP_VERSION
RUN createrepo /usr/local/apache2/htdocs/hdp/centos7/HDP-UTILS-$HDP_UTILS_VERSION


COPY hdp-clones.repo /tmp/

RUN sed -e "s/FQDN/$FQDN/g" /tmp/hdp-clones.repo | \
	sed -e "s/AMBARI_VERSION/$AMBARI_VERSION/g" | \
	sed -e "s/HDP_VERSION/$HDP_VERSION/g" | \
	sed -e "s/HDP_UTILS_VERSION/$HDP_UTILS_VERSION/g" > /usr/local/apache2/htdocs/hdp-clones.repo
