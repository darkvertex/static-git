VERSION 0.6

FROM alpine

RUN apk add --no-cache \
    curl autoconf gcc flex bison make bash cmake libtool musl-dev g++ \
    zlib-dev zlib-static \
    tcl tk \
    tcl-dev gettext

ARG GIT_VERSION

build:
    RUN curl -sL https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz -o git_v${GIT_VERSION}.tar.gz
    RUN tar zxf git_v${GIT_VERSION}.tar.gz
    WORKDIR /git-${GIT_VERSION}

    RUN make configure && sed -i 's/qversion/-version/g' configure
    RUN ./configure prefix=/dist/git-${GIT_VERSION} LDFLAGS="--static" CFLAGS="${CFLAGS} -static" && cat config.log
    RUN make && make install

    SAVE ARTIFACT /dist/git-${GIT_VERSION}/bin/* AS LOCAL ./dist/
