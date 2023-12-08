set -e
# python3 scripts/make_suffix_array.py $1
# python scripts/load_dataset_hf.py --save_dir $1.dedup --name from_disk --data_dir $1 --tokenize --num_workers $4
cargo run make --data-file $1
cargo run self-similar --data-file $1 --length-threshold $3 --cache-dir /tmp/cache --num-threads $4 # --only-save-one
cargo run collect --data-file $1 --cache-dir /tmp/cache --length-threshold $3 > /tmp/drop_tokens_file
python3 scripts/finish_single_file.py $1 /tmp/drop_tokens_file $2
