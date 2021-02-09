#!/usr/bin/env bash

function show_help() {
	echo "Codeceptjs Tests could not be found"
	echo " "
	echo "Please make sure you're mounting your codeceptjs directory correctly."
	echo "*** Run example test: docker run -it --rm -v $(pwd)/test/webkit:/tests image_name:latest "
	echo " "
	exit 1
}

# Check if tests are correctly mounted
if [[ -d "/tests/" ]]; then
	echo "Mounted directory has been found."

	#[ -d "/tests/output" ] || mkdir /tests/output

	cp -a /usr/src/app/test/* /codecept

	[ -d "/codecept/output" ] || mkdir /codecept/output

	yarn codeceptjs run --reporter mocha-multi | tee /codecept/output/output.log

	if [ -d /usr/src/app/test/output ]; then
		echo "/usr/src/app/test/output exists"
	else
		echo "creating directory /usr/src/app/test/output"
		mkdir /usr/src/app/test/output
	fi

	cp -r /codecept/output/* /usr/src/app/test/output

	echo "/codecept/output"
	cd /codecept/output
	ls -la
	printf "\n\n"

	echo "/usr/src/app/test"
	cd /usr/src/app/test
	ls -la
	printf "\n\n"

	echo "/usr/src/app/test/output"
	cd /usr/src/app/test/output
	ls -la
	printf "\n\n"
else
	show_help
fi
