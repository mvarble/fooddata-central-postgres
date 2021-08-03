# FoodData Central Postgres

[FoodData Central](https://fdc.nal.usda.gov/index.html) is an amazing service provided by the U.S. Department of Agriculture, hosting nutritional and agricultural information for massive amounts of branded and foundational foods.
They provide a convenient REST API for querying foods and also allow us to download the raw data.
The data is available for download as either several CSV files or a Microsoft Access database.
The purpose of this repository is to continue the *free and open source* spirit that FoodData Central encourages by providing simple scripts which migrate the data to a Postgres database, as opposed to the proprietary Microsoft Access format. 🤢

## Install

Note that `download.sh` simply uses `wget`, `unzip`, and `sed` to put all the CSV files into the local filesystem.
This can easily be done by hand, but the script is convenient.

```
chmod +x ./download.sh
./download.sh
```

On Ubuntu, the required commands can be downloaded easily.

```
apt-get install wget unzip sed
```

Once the CSV files are in the directory `FoodData_Central`, we can populate the Postgres database by running the PostgreSQL transactions in the file `setup.sql`.

```
psql -f setup.sql
```

Surely, this requires we have a Postgres client, which we can do on Ubuntu like so.

```
apt-get install postgresql-12
```

## Cleanup

The `cleanup.sql` file will undo the work of `setup.sql`.
Running 

```
psql -f cleanup.sql
```

will remove all the data, as though it were never installed.

## Caveats

- The `fndds_ingredient_nutrient_value.csv` file is corrupted, so I needed to remove the messed up rows.
- The `food_attribute` table has rows without `fdc_id` column which seem to be useless logs for my use cases, so I drop said rows.
- The `food_nutrient` table references `fdc_id` values from `1104805` to `1104809` which are not present in `food`, so those rows were deleted.
- The `food_nutrient` table has a column `food_nutrient_id` which refers to one of `nutritient.id` or `nutirient.nutrient_nbr`, so shadow columns `nutrient_id_nid` and `nutrient_id_nnbr` are created in `food_nutrient` to satisfy the foreign keys.
- Many of the columns for `input_food` are useless and were thus dropped.
- The `sub_sample_food` table references `fdc_id` value `1104803` which is not present in `food`, so those rows were deleted.
- The `sub_sample_result` table references `food_nutrient_id` values from `13336250` to `13336266` which we needed to remove from `fdc_id` null-pointers (see earlier caveat).

## Rest API

To host a webservice that offers a Rest API similar to that provided by FoodData Central, consider cloning [my Rust (working progress) implementation](https://github.com/mvarble/nutrition).
