FROM timescale/timescaledb:latest-pg15@sha256:7206963d50262d757c8ff81cd056c5acda15e77eb1327701ff00e80e02a1686b

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
