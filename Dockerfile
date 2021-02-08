# Alpine Linux with Oracle JRE
FROM sgrio/java:jre_8

RUN apk add --no-cache curl bash gawk sed grep bc coreutils
#RUN apt-get update \
#    && apt-get install --no-install-recommends -y \
#    unzip \
#    && rm -f /var/lib/apt/lists/*_dists_*

# Set the working directory to /app
WORKDIR /app

# dowload kmttg
RUN curl -L https://sourceforge.net/projects/kmttg/files/latest/download > /app/kmttg.zip
RUN unzip kmttg.zip 

COPY config.ini /app/config.ini
COPY auto.ini /app/auto.ini

EXPOSE 8181

VOLUME /files

CMD ["/app/kmttg", "-a"]