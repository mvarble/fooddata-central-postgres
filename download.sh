#!/bin/sh
wget https://fdc.nal.usda.gov/fdc-datasets/FoodData_Central_csv_2021-04-28.zip
mkdir -p FoodData_Central
unzip FoodData_Central_csv_2021-04-28.zip -d FoodData_Central
sed -e '/,,,,/d; /0\s*$/d; /0\s*,\s*$/d; /0\s*,,\s*$/d; s/End date,,,/End date/g; s/,,,//g' FoodData_Central/fndds_ingredient_nutrient_value.csv > FoodData_Central/fndds_ingredient_nutrient_value_FIX.csv
