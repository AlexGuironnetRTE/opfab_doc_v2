#!/usr/bin/env bash

# Setting image dir

export source_folder=src
export output_folder=$(pwd)/docs/documentation
export image_folder=images
export output_imagesdir=$output_folder/$imagesdir

generate_html_from_index() {
    filepath=$1
    dirpath=$(dirname $1)
    output_dirpath=$(echo $dirpath | sed "s $source_folder $output_folder g" )
    imagesdir=$(realpath --relative-to=$output_dirpath $output_imagesdir)/$image_folder
    asciidoctor -a imagesdir=$imagesdir -D $output_dirpath $filepath
};
export -f generate_html_from_index;

# Clear output_dir
rm -r $output_folder/*

# Generate output
## Images    echo imagesdir $imagesdir
cp -r $source_folder/$image_folder $output_folder/$image_folder

## Indexes for documents
find $source_folder -path "*/index.adoc" -exec bash -c 'generate_html_from_index "$0"' {} \;

## Root level documents
find $source_folder -maxdepth 1 -path "*.adoc" -exec bash -c 'generate_html_from_index "$0"' {} \;





