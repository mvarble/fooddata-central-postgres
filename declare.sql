/**
 * Step 1:
 * Create tables matching columns of CSV files.
 */
-- acquisition_samples
CREATE TABLE acquisition_samples(
  fdc_id_of_sample_food INT NOT NULL,
  fdc_id_of_acquisition_food INT NOT NULL
);

--- agricultural_samples
CREATE TABLE agricultural_samples(
  fdc_id INT NOT NULL,
  acquisition_date DATE NOT NULL,
  market_class VARCHAR(255),
  treatment VARCHAR(255),
  state VARCHAR(255)
);

-- branded_food
CREATE TABLE branded_food(
  fdc_id INT NOT NULL,
  brand_owner VARCHAR(255),
  brand_name VARCHAR(255),
  subbrand_name VARCHAR(255),
  gtin_upc VARCHAR(255),
  ingredients VARCHAR(4095),
  not_a_significant_source_of VARCHAR(255),
  serving_size VARCHAR(255),
  serving_size_unit VARCHAR(255),
  household_serving_fulltext VARCHAR(255),
  branded_food_category VARCHAR(255),
  data_source VARCHAR(255),
  modified_date VARCHAR(255),
  available_date VARCHAR(255),
  market_country VARCHAR(255),
  discontinued_date VARCHAR(255)
);

-- fndds_derivation
CREATE TABLE fndds_derivation(
  derivation_code VARCHAR(4),
  derivation_description VARCHAR(255)
);

-- fndds_nutrient_value
CREATE TABLE fndds_ingredient_nutrient_value(
  ingredient_code INT NOT NULL,
  sr_description VARCHAR(255),
  nutrient_code INT NOT NULL,
  nutrient_value REAL NOT NULL,
  nutrient_value_source VARCHAR(255),
  derivation_code VARCHAR(4),
  sr_addmod_year VARCHAR(255),
  start_date VARCHAR(255),
  end_date VARCHAR(255)
);

-- food_attribute
CREATE TABLE food_attribute(
  id INT PRIMARY KEY,
  fdc_id VARCHAR(255),
  seq_num VARCHAR(255),
  food_attribute_type_id VARCHAR(255),
  name VARCHAR(255),
  value VARCHAR(4095)
);

-- food_attribute_type
CREATE TABLE food_attribute_type(
  id INT PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255)
);

-- food_calorie_conversion_factor
CREATE TABLE food_calorie_conversion_factor(
  food_nutrient_conversion_factor_id INT PRIMARY KEY,
  protein_value VARCHAR(7),
  fat_value VARCHAR(7),
  carbohydrate_value VARCHAR(7)
);

-- food_category
CREATE TABLE food_category(
  id INT PRIMARY KEY,
  code VARCHAR(7),
  description VARCHAR(255)
);

-- food_component
CREATE TABLE food_component(
  id INT PRIMARY KEY,
  fdc_id INT NOT NULL,
  name VARCHAR(255),
  pct_weight VARCHAR(15),
  is_refuse VARCHAR(1),
  gram_weight REAL NOT NULL,
  data_points INT NOT NULL,
  min_year_acquired VARCHAR(5)
);

-- food
CREATE TABLE food(
  fdc_id INT PRIMARY KEY,
  data_type VARCHAR(255),
  description VARCHAR(4095),
  food_category_id VARCHAR(255),
  publication_date DATE NOT NULL
);

-- food_nutrient_conversion_factor
CREATE TABLE food_nutrient_conversion_factor(
  id INT PRIMARY KEY,
  fdc_id INT NOT NULL
);

-- food_nutrient
CREATE TABLE food_nutrient(
  id INT PRIMARY KEY,
  fdc_id INT NOT NULL,
  nutrient_id INT NOT NULL,
  amount REAL NOT NULL,
  data_points VARCHAR(255),
  derivation_id VARCHAR(255),
  min VARCHAR(255),
  max VARCHAR(255),
  median VARCHAR(255),
  footnote VARCHAR(255),
  min_year_acquired VARCHAR(255)
);

-- food_nutrient_derivation
CREATE TABLE food_nutrient_derivation(
  id INT PRIMARY KEY,
  code VARCHAR(4),
  description VARCHAR(4095),
  source_id INT NOT NULL
);

-- food_nutrient_source
CREATE TABLE food_nutrient_source(
  id INT PRIMARY KEY,
  code INT NOT NULL,
  description VARCHAR(255)
);

-- food_portion
CREATE TABLE food_portion(
  id INT PRIMARY KEY,
  fdc_id INT NOT NULL,
  seq_num VARCHAR(5),
  amount REAL NOT NULL,
  measure_unit_id INT NOT NULL,
  portion_description VARCHAR(255),
  modifier VARCHAR(255),
  gram_weight REAL NOT NULL,
  data_points VARCHAR(7),
  footnote VARCHAR(255),
  min_year_acquired VARCHAR(255)
);

-- food_protein_conversion_factor
CREATE TABLE food_protein_conversion_factor(
  food_nutrient_conversion_factor_id INT PRIMARY KEY,
  value REAL NOT NULL
);

-- food_update_log_entry
CREATE TABLE food_update_log_entry(
  id INT PRIMARY KEY,
  description VARCHAR(4095),
  last_updated DATE NOT NULL
);

-- foundation_food
CREATE TABLE foundation_food(
  fdc_id INT NOT NULL,
  ndb_number INT NOT NULL,
  footnote VARCHAR(255)
);

-- input_food
CREATE TABLE input_food(
  id INT PRIMARY KEY,
  fdc_id INT NOT NULL,
  fdc_of_input_food INT NOT NULL,
  seq_num VARCHAR(4),
  amount VARCHAR(4),
  sr_code VARCHAR(255),
  sr_description VARCHAR(4095),
  unit VARCHAR(255),
  portion_code VARCHAR(255),
  portion_description VARCHAR(255),
  gram_weight VARCHAR(255),
  retention_code VARCHAR(255),
  survey_flag VARCHAR(255)
);

-- lab_method_code
CREATE TABLE lab_method_code(
  id INT PRIMARY KEY,
  lab_method_id INT,
  code VARCHAR(255)
);

-- lab_method
CREATE TABLE lab_method(
  id INT PRIMARY KEY,
  description VARCHAR(255),
  technique VARCHAR(255)
);

-- lab_method_nutrient
CREATE TABLE lab_method_nutrient(
  id INT PRIMARY KEY,
  lab_method_id INT NOT NULL,
  nutrient_id INT NOT NULL
);

-- market_acquisition
CREATE TABLE market_acquisition(
  fdc_id INT NOT NULL,
  brand_description VARCHAR(255),
  expiration_date VARCHAR(255),
  label_weight VARCHAR(255),
  location VARCHAR(255),
  acquisition_date VARCHAR(255),
  sales_type VARCHAR(255),
  sample_lot_nbr VARCHAR(255),
  sell_by_date VARCHAR(255),
  store_city VARCHAR(255),
  store_name VARCHAR(255),
  store_state VARCHAR(255),
  upc_code VARCHAR(255)
);

-- measure_unit
CREATE TABLE measure_unit(
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

-- nutrient
CREATE TABLE nutrient(
  id INT PRIMARY KEY,
  name VARCHAR(255),
  unit_name VARCHAR(255),
  nutrient_nbr VARCHAR(255),
  rank VARCHAR(255)
);

-- nutrient_incoming_name
CREATE TABLE nutrient_incoming_name(
  id INT PRIMARY KEY,
  name VARCHAR(255),
  nutrient_id INT NOT NULL
);

-- retention_factor
CREATE TABLE retention_factor(
  id INT PRIMARY KEY,
  code INT NOT NULL,
  food_group_id INT NOT NULL,
  description VARCHAR(255)
);

-- sample_food
CREATE TABLE sample_food(
  fdc_id INT
);

-- sr_legacy_food
CREATE TABLE sr_legacy_food(
  fdc_id INT NOT NULL,
  ndb_number INT NOT NULL
);

-- sub_sample_food
CREATE TABLE sub_sample_food(
  fdc_id INT NOT NULL,
  fdc_id_of_sample_food INT NOT NULL
);

-- sub_sample_result
CREATE TABLE sub_sample_result(
  food_nutrient_id INT NOT NULL,
  adjusted_amount VARCHAR(255),
  lab_method_id INT NOT NULL,
  nutrient_name VARCHAR(255)
);

-- survey_fndds_food
CREATE TABLE survey_fndds_food(
  fdc_id INT NOT NULL,
  food_code INT PRIMARY KEY,
  wweia_category_code INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL
);

-- wweia_food_category
CREATE TABLE wweia_food_category(
  id INT PRIMARY KEY,
  description VARCHAR(255)
);
