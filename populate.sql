/**
 * Step 2:
 * Populate the tables with the rows of the CSV files
 */
\copy acquisition_samples FROM './FoodData_Central/acquisition_samples.csv' DELIMITER ',' CSV HEADER
\copy agricultural_samples FROM './FoodData_Central/agricultural_samples.csv' DELIMITER ',' CSV HEADER
\copy branded_food FROM './FoodData_Central/branded_food.csv' DELIMITER ',' CSV HEADER
\copy fndds_derivation FROM './FoodData_Central/fndds_derivation.csv' DELIMITER ',' CSV HEADER
\copy fndds_ingredient_nutrient_value FROM './FoodData_Central/fndds_ingredient_nutrient_value_FIX.csv' DELIMITER ',' CSV HEADER
\copy food_attribute FROM './FoodData_Central/food_attribute.csv' DELIMITER ',' CSV HEADER
\copy food_attribute_type FROM './FoodData_Central/food_attribute_type.csv' DELIMITER ',' CSV HEADER
\copy food_calorie_conversion_factor FROM './FoodData_Central/food_calorie_conversion_factor.csv' DELIMITER ',' CSV HEADER
\copy food_category FROM './FoodData_Central/food_category.csv' DELIMITER ',' CSV HEADER
\copy food_component FROM './FoodData_Central/food_component.csv' DELIMITER ',' CSV HEADER
\copy food FROM './FoodData_Central/food.csv' DELIMITER ',' CSV HEADER
\copy food_nutrient_conversion_factor FROM './FoodData_Central/food_nutrient_conversion_factor.csv' DELIMITER ',' CSV HEADER
\copy food_nutrient FROM './FoodData_Central/food_nutrient.csv' DELIMITER ',' CSV HEADER
\copy food_nutrient_derivation FROM './FoodData_Central/food_nutrient_derivation.csv' DELIMITER ',' CSV HEADER
\copy food_nutrient_source FROM './FoodData_Central/food_nutrient_source.csv' DELIMITER ',' CSV HEADER
\copy food_portion FROM './FoodData_Central/food_portion.csv' DELIMITER ',' CSV HEADER
\copy food_protein_conversion_factor FROM './FoodData_Central/food_protein_conversion_factor.csv' DELIMITER ',' CSV HEADER
\copy food_update_log_entry FROM './FoodData_Central/food_update_log_entry.csv' DELIMITER ',' CSV HEADER
\copy foundation_food FROM './FoodData_Central/foundation_food.csv' DELIMITER ',' CSV HEADER
\copy input_food FROM './FoodData_Central/input_food.csv' DELIMITER ',' CSV HEADER
\copy lab_method_code FROM './FoodData_Central/lab_method_code.csv' DELIMITER ',' CSV HEADER
\copy lab_method FROM './FoodData_Central/lab_method.csv' DELIMITER ',' CSV HEADER
\copy lab_method_nutrient FROM './FoodData_Central/lab_method_nutrient.csv' DELIMITER ',' CSV HEADER
\copy market_acquisition FROM './FoodData_Central/market_acquisition.csv' DELIMITER ',' CSV HEADER
\copy measure_unit FROM './FoodData_Central/measure_unit.csv' DELIMITER ',' CSV HEADER
\copy nutrient FROM './FoodData_Central/nutrient.csv' DELIMITER ',' CSV HEADER
\copy nutrient_incoming_name FROM './FoodData_Central/nutrient_incoming_name.csv' DELIMITER ',' CSV HEADER
\copy retention_factor FROM './FoodData_Central/retention_factor.csv' DELIMITER ',' CSV HEADER
\copy sample_food FROM './FoodData_Central/sample_food.csv' DELIMITER ',' CSV HEADER
\copy sr_legacy_food FROM './FoodData_Central/sr_legacy_food.csv' DELIMITER ',' CSV HEADER
\copy sub_sample_food FROM './FoodData_Central/sub_sample_food.csv' DELIMITER ',' CSV HEADER
\copy sub_sample_result FROM './FoodData_Central/sub_sample_result.csv' DELIMITER ',' CSV HEADER
\copy survey_fndds_food FROM './FoodData_Central/survey_fndds_food.csv' DELIMITER ',' CSV HEADER
\copy wweia_food_category FROM './FoodData_Central/wweia_food_category.csv' DELIMITER ',' CSV HEADER
