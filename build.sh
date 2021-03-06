#!/bin/sh
USAGE="$0 [make | clean]"
CUR_PATH=$(/bin/pwd)
HEADER_PATH=${CUR_PATH}/src/rpc
RPC_SOURCE_PATH=${CUR_PATH}/src/rpc
PROTO_PATH=${CUR_PATH}/src/rpc/protos
TEST_PATH=${CUR_PATH}/src/test
if [ 0 -eq $# ] || [ "$1"a = "make"a ]
then
#generate grpc C++ source files
echo "rm old grpc source files..."
rm -f ${RPC_SOURCE_PATH}/*.pb.h ${RPC_SOURCE_PATH}/*.pb.cc
echo "generate new grpc C++ source files to ${RPC_SOURCE_PATH} ..."
protoc -I $PROTO_PATH --grpc_out=$RPC_SOURCE_PATH --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` ${PROTO_PATH}/writer.proto ${PROTO_PATH}/consumer.proto
protoc -I $PROTO_PATH --cpp_out=$RPC_SOURCE_PATH ${PROTO_PATH}/writer.proto ${PROTO_PATH}/consumer.proto ${PROTO_PATH}/common.proto ${PROTO_PATH}/journal.proto
#mv ${RPC_SOURCE_PATH}/*.pb.h ${HEADER_PATH}/

#auto generate Makefiles
touch NEWS README AUTHORS ChangeLog
aclocal
libtoolize
libtoolize
autoheader
autoconf
automake -a
automake -a
automake
#compile...
chmod +x ${CUR_PATH}/configure
${CUR_PATH}/configure
make clean
make -j8
#copy program to bin
#cp ${CUR_PATH}/src/rpc_server ${CUR_PATH}/bin

elif [ "$1"a = "clean"a ]
then
make clean
rm -rf `ls | grep -E -v "README.md|src|bin|Makefile.am|test|build.sh|configure.ac"`
rm -rf bin/*;
find . -name Makefile | xargs rm -f
find . -name Makefile.in | xargs rm -f
find . -name .deps | xargs rm -rf
else
echo ${USAGE}
fi
