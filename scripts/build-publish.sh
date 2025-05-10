#! /bin/bash


# doesn't clean .git directory
function clean_public() {
		rm -rf ./public/*
}


function build() {
    cd ./quartz/
    npx quartz build -v --concurrency 4 --output ./build
    mv ./build/* ../public
    cp ../googleb336269767bb6f1c.html ../public
    rmdir ./build
    cd ..
}


function publish() {
		local commit_msg="$1"
		cd ./public
		git add .
		git commit -m "$1"
		git push origin gh-pages
}


function main() {
		local bulid_msg="$1"

		echo "Cleaning public directory" && \
		clean_public && \
		echo "Converting notebooks to markdowns" && \
		./scripts/resolve_notebooks.sh && \
		echo "Creating build" && \
		build && \
		echo "Creating git commit and pushing the changes" && \
		publish "$1"
}

main "$1"

