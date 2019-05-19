all: runwithr

runwithr: inflate
	Rscript src/data/script_02_join_data_with_column_names.r
	Rscript src/data/script_03_clean_data.r

runwithpy: inflate
	python src/data/script_02_join_data_with_column_names.py
	python src/data/script_03_clean_data.py

inflate: clean
	bash src/data/script_01_unzip_data.sh

clean:
	bash src/data/script_00_clean.sh

