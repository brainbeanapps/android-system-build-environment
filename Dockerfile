FROM brainbeanapps/base-linux-build-environment:v3.0.0

LABEL maintainer="devops@brainbeanapps.com"

# Switch to root
USER root

# Set shell as non-interactive during build
# NOTE: This is discouraged in general, yet we're using it only during image build
ARG DEBIAN_FRONTEND=noninteractive

# Install OpenJDK
# Ref: https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update \
  && apt-get install -y --no-install-recommends openjdk-8-jdk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/oracle-jdk8-installer;

# Setup JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# Install Android Source dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git-core \
    gnupg \
    flex \
    bison \
    gperf \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    lib32ncurses5-dev \
    x11proto-core-dev \
    libx11-dev \
    lib32z-dev \
    ccache \
    libgl1-mesa-dev \
    libxml2-utils \
    xsltproc \
    unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Node.js & npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g npm@latest

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN apt-get update \
  && apt-get install -y --no-install-recommends ruby \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN apt-get update \
  && apt-get install -y --no-install-recommends maven \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Switch to user
USER user
WORKDIR /home/user
