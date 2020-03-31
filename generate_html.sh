#!/usr/bin/env bash

# Setting image dir

repo_root=$(pwd)
export imagesdir=$repo_root/"images"

export source_folder=src
export output_folder=html_output

generate_html_from_index() {
    filepath=$1
    dirpath=$(dirname $1)
    output_dirpath=$(echo $dirpath | sed "s/$source_folder/$output_folder/g" )
    #filename=$(basename "./${filepath%.*}")
    asciidoctor -a imagesdir=$imagesdir -D $output_dirpath $filepath
};
export -f generate_html_from_index;

# Clear output_dir
rm -r $repo_root/$output_folder/*

# Generate output
find $source_folder -path "*/index.adoc" -exec bash -c 'generate_html_from_index "$0"' {} \;





