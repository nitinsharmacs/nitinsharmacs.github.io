#! /bin/bash


# doesn't clean .git directory
function clean_public() {
		rm -rf ./public/*
}

function get_build_id() {
		echo "build 1"
}

function build() {
		npx quartz build -v --concurrency 4 --output ./build
		mv ./build/* ./public
		rmdir ./build
}


function publish() {
		cd ./public
		git add .
		id=$(get_build_id)
		git commit -m "build - $id"
		git push origin gh-pages
}


function main() {

		echo "Cleaning public directory" && \
		clean_public && \
		echo "Creating build" && \
		build && \
		echo "Creating git commit and pushing the changes" && \
		publish
}

main

