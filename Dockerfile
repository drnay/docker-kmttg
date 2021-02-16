# Alpine Linux with Oracle JRE
FROM sgrio/java:jre_8

RUN apk add --no-cache \
      font-noto \
      gtk+2.0 \
      libxtst \
      tzdata \
      xterm

#RUN apt-get update \
#    && apt-get install --no-install-recommends -y \
#    unzip \
#    net-tools \
#    fluxbox \
#    libgtk2.0-0 \
#    libxtst6 \
#    supervisor \
#    xterm \
#    xvfb \
#    && rm -f /var/lib/apt/lists/*_dists_*

# server port
EXPOSE 8181

# Setup environment variables
ENV LD_LIBRARY_PATH=/lib:/usr/lib

# mount point for input files
VOLUME /files

# Run as a non-root
RUN addgroup -g 10001 -S kmttg \
    && adduser -S -s /bin/false -G kmttg -D -h /home/kmttg -u 10000 kmttg

USER kmttg

# Set the working directory to /home/kmttg/app
WORKDIR /home/kmttg/app

# dowlnoad kmttg
RUN curl -L https://sourceforge.net/projects/kmttg/files/latest/download | busybox unzip -o - \
    && chmod +x /home/kmttg/app/kmttg \
    && mkdir -p /home/kmttg/app/web/cache \
    && mkdir -p /home/kmttg/out

COPY --chown=kmttg config.ini /home/kmttg/app/config.ini
COPY --chown=kmttg auto.ini /home/kmttg/app/auto.ini

# mount point for output files
VOLUME /home/kmttg/out

# persist the install dir
VOLUME /home/kmttg/app

CMD ["/home/kmttg/app/kmttg"]
