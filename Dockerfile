# Alpine Linux with Oracle JRE
FROM sgrio/java:jre_8

RUN apk add --no-cache curl bash gawk sed grep bc coreutils xvfb fluxbox supervisor
#RUN apt-get update \
#    && apt-get install --no-install-recommends -y \
#    unzip \
#    && rm -f /var/lib/apt/lists/*_dists_*

# Set the working directory to /app
WORKDIR /app

# dowload kmttg
RUN curl -L https://sourceforge.net/projects/kmttg/files/latest/download > /app/kmttg.zip
RUN unzip kmttg.zip 

# COPY config.ini /app/config.ini
# COPY auto.ini /app/auto.ini
COPY . /app

EXPOSE 8181

VOLUME /files

# Setup demo environment variables
ENV HOME=/root \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768

CMD ["/app/entrypoint.sh"]
# CMD ["/app/kmttg", "-a"]