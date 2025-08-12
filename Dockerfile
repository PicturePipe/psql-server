FROM timescale/timescaledb:latest-pg15@sha256:fd0aa35f36f73cfd3ac0a3dca310620ab629b5c01c0d3a3e0599016f5444df67

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
	&& git checkout v0.7.4 \
	&& make clean \
	&& make OPTFLAGS="" \
	&& make install \
	&& mkdir -p /usr/share/doc/pgvector \
	&& cp LICENSE README.md /usr/share/doc/pgvector \
	&& cd / \
	&& rm -r /tmp/pgvector \
	&& apk del .build-deps
