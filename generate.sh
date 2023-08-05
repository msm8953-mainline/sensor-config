#!/bin/bash

SNS_REG_DIR="sns-reg"
SNS_REG_GENERATOR="$SNS_REG_DIR/sns-reg-generator"
CONFIG_DIR="$(pwd)/config"
BINARY_DIR="$(pwd)/binary"

build_snsreg() {
	echo "Building sns-reg-generator"
	pushd $SNS_REG_DIR
	scons tools
	popd
}

generate_configs() {
	mkdir -p $CONFIG_DIR
	
	for f in $BINARY_DIR/*; do
		FILE=$(basename $f)
		DEVICE=${FILE/\_sns\.reg/}
		echo "Generating sensor config for $DEVICE"
		$SNS_REG_GENERATOR $f > $CONFIG_DIR/${DEVICE}_registry.reg
	done
}

if [ ! -f $SNS_REG_GENERATOR ]; then
	build_snsreg
fi	

generate_configs
