#!/usr/bin/env bash


# this script downloads files in the current directory and creates the structure as :
# --train
# --|--data ( this contains folders with names as hashes )
# --test
# --|--data ( this contains folders with names as hashes )
#
# masks are downloaded as "mask.png" in each training folder


# download the guide files if test and train are
if [ ! -f "test.txt"   ]
then
    wget "https://storage.googleapis.com/uga-dsp/project4/test.txt"
fi
if [ ! -f "train.txt"   ]
then
    wget "https://storage.googleapis.com/uga-dsp/project4/train.txt"
fi

# create folders
if [ ! -d "train" ]
then
    mkdir "train"
fi

if [ ! -d "test" ]
then
    mkdir "test"
fi

echo "downloading train"

cd train

while read -r line || [[ -n "$line" ]]; do
    echo "$line"
    wget "https://storage.googleapis.com/uga-dsp/project4/data/$line.tar"
    tar -xf  "$line.tar"
    rm "$line.tar"
    cd "data/$line"
    wget  -o "mask.png" "https://storage.googleapis.com/uga-dsp/project4/masks/$line.png"
    cd ../..
done < "../train.txt"


echo "downloading training"
cd ../test

while read -r line || [[ -n "$line" ]]; do
    echo "$line"
    wget "https://storage.googleapis.com/uga-dsp/project4/data/$line.tar"
    tar -xf  "$line.tar"
    rm "$line.tar"
done < "../test.txt"


echo "over and out"