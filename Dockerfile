FROM timescale/timescaledb:latest-pg15@sha256:30a98d1980c11744c2fadddbc9883860a7631fc16f199f35b92af650c6a49784

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
