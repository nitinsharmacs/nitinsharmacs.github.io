#! /bin/bash

# This script converts the juyter notebook to markdown in the notes directory
# and places the assests beside the generated markdown file.
# Markdown file is generated at the same location of notebook file. 
# It works with symlinks. However, it doesn't follow the link and create markdown there. 
# It uses the same location where link reside.


if [[ -z $(which jupyter) ]]; then
		echo "Please install juypter to run the script"
		echo "Use, conda install jupyter"
		echo "Or"
		echo "pip3 install jupyter"
		exit 1
fi



echo "Converting files"

find -L content -type f -name "*.ipynb" -not -path '*.ipynb_checkpoints*' | xargs jupyter nbconvert --to markdown

echo "Done!!!"

