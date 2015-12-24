#
# Apache Archiva Standalone
#

FROM java:8

MAINTAINER Brian Schalme bschalme@airspeed.ca

ENV ARCHIVA_VERSION 2.2.0
ENV ARCHIVA_SHA1 69c922441b02bf75e5a3067220bf8f13dbd0bb98

RUN curl -sSLo /apache-archiva-$ARCHIVA_VERSION-bin.tar.gz https://archive.apache.org/dist/archiva/$ARCHIVA_VERSION/binaries/apache-archiva-$ARCHIVA_VERSION-bin.tar.gz \
  && echo "$ARCHIVA_SHA1 /apache-archiva-$ARCHIVA_VERSION-bin.tar.gz" | sha1sum -c \
  && tar --extract --ungzip --file apache-archiva-$ARCHIVA_VERSION-bin.tar.gz --directory / \
  && rm /apache-archiva-$ARCHIVA_VERSION-bin.tar.gz && mv /apache-archiva-$ARCHIVA_VERSION /apache-archiva

RUN useradd -d /apache-archiva/data -m archiva \
  && rm /apache-archiva/conf/archiva.xml \
  && ln -s /apache-archiva/data/archiva.xml /apache-archiva/conf/archiva.xml \
  && mkdir /apache-archiva/repositories \
  && chown archiva:archiva /apache-archiva/logs /apache-archiva/repositories /apache-archiva/temp

ENV ARCHIVA_BASE /apache-archiva
WORKDIR /apache-archiva

USER archiva

VOLUME /apache-archiva/data
VOLUME /apache-archiva/logs
VOLUME /apache-archiva/repositories
VOLUME /apache-archiva/temp
VOLUME /apache-archiva/conf

EXPOSE 8080
CMD bin/archiva console

