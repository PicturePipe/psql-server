FROM timescale/timescaledb:latest-pg15@sha256:dd082cffdbec5fe14228bb9c31fe87bb6b94e263d069f4e270438cc413c39916

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
