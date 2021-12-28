#!/usr/bin/env bash

tmp_dir=$(mktemp -d)
init_dir=$(pwd)
cd $tmp_dir

# Getting the latest version of coreutils.
latest_coreutil=$(curl -s http://ftp.gnu.org/gnu/coreutils/ \
	| sed 's/^.*\(\"coreutils-.*\.tar\.xz\"\).*$/\1/g' \
	| sed '/^[^"].*/d' | tr -d '"' | sort -r | head -n 1)

# Getting the latest patches for coreutils.
git clone https://github.com/jarun/advcpmv --depth 1 1>/dev/null 2>&1
cd advcpmv
find . -mindepth 1 -not -iname "*\.patch" -exec rm -rf {} +

latest_patch=$(ls | sort -r | head -n 1)

# Sanity check.
if [[ ! $(echo $latest_patch | sed 's/advcpmv-.*-\(.*\).patch/\1/g') == $(echo $latest_coreutil | sed 's/coreutils-\(.*\)\.tar\.xz/\1/g') ]];then
	echo "Error: latest patch version doesn't match latest coreutils version. Manual intervention is the safest option."
	exit 1
fi

# Fetching latest coreutils.
cd ..
wget -q "https://ftp.gnu.org/gnu/coreutils/$latest_coreutil" 1>/dev/null 2>&1
tar xvJf "$latest_coreutil" 1>/dev/null 2>&1
rm -rf $latest_coreutil
mv "./advcpmv/${latest_patch}" ./$(echo "$latest_coreutil" | sed 's/\.tar\.xz//')
cd $(echo "$latest_coreutil" | sed 's/\.tar\.xz//')
patch -p1 -i $latest_patch
./configure
make

mv "${tmp_dir}/$(echo ${latest_coreutil} | sed 's/\.tar\.xz//')/src/cp" $init_dir
mv "${tmp_dir}/$(echo ${latest_coreutil} | sed 's/\.tar\.xz//')/src/mv" $init_dir
cd $init_dir
rm -rf $tmp_dir
