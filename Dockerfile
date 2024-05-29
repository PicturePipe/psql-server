FROM timescale/timescaledb:latest-pg15@sha256:2e730f223a33e73e4c003ee531e063d8973e3509de55e3981fc154c9e93cbc96

RUN apk add --no-cache --virtual .build-deps \
		ca-certificates \
		clang15 \
		git \
		llvm15 \
		openssl \
		openssl-dev \
		tar \
		coreutils \
		gcc \
		libc-dev \
		make \
	&& mkdir -p /tmp \
	&& git clone https://github.com/pgvector/pgvector /tmp/pgvector \
	&& cd /tmp/pgvector \
	&& git checkout v0.5.1 \
	&& make clean \
	&& make OPTFLAGS="" \
	&& make install \
	&& mkdir -p /usr/share/doc/pgvector \
	&& cp LICENSE README.md /usr/share/doc/pgvector \
	&& cd / \
	&& rm -r /tmp/pgvector \
	&& apk del .build-deps
