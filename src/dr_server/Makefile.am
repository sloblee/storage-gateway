noinst_PROGRAMS=rpc_server
AM_CPPFLAGS=-I../ -std=c++11
ACLOCAL_AMFLAGS=-I m4
rpc_server_SOURCES=rpc_server.cc consumer_service.cc writer_service.cc
rpc_server_LDADD=${top_srcdir}/src/rpc/librpc.la
rpc_server_LDFLAGS=-D_GNU_SOURCE
DEFS+=-D_GNU_SOURCE
LIBS=-lpthread -lprotobuf -lpthread -ldl -lgrpc -lgrpc++
SUBDIRS=../rpc
