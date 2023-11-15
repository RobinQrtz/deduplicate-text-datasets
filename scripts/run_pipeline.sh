DATA_DIR=$1
SPLIT=None
THRESHOLD=$2
CACHE=/tmp/cache/

cargo build

python scripts/load_dataset_hf.py --name from_disk --data_dir $DATA_DIR --tokenize --save_dir $DATA_DIR.suffarr --split $SPLIT

python3 scripts/make_suffix_array.py $DATA_DIR.suffarr/from_disk.None

cargo run self-similar --data-file $DATA_DIR.suffarr/from_disk.None --length-threshold $THRESHOLD --cache-dir $CACHE

cargo run collect --data-file $DATA_DIR.suffarr/from_disk.None --cache-dir $CACHE --length-threshold $THRESHOLD > $DATA_DIR.suffarr.remove.byterange


