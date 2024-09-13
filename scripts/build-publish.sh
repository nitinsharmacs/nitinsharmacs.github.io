#! /bin/bash


# doesn't clean .git directory
function clean_public() {
		rm -rf ./public/*
}

function get_build_id() {
		id=$(cat .build_version)
		new_id=$((id+1))
	
		echo $new_id | tee .build_version
}

function build() {
		npx quartz build -v --concurrency 4 --output ./build
		mv ./build/* ./public
		rmdir ./build
}


function publish() {
		id=$(get_build_id)
		cd ./public
		git add .
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

