/**
 * Step 3:
 * Alter the tables to have nully non-string columns and add constraints.
 */

-- acquisition_samples
ALTER TABLE acquisition_samples 
  ADD CONSTRAINT acquisition_samples_fdc_id_of_sample_food_fkey 
    FOREIGN KEY (fdc_id_of_sample_food) REFERENCES food(fdc_id),
  ADD CONSTRAINT acquisition_samples_fdc_id_of_acquisition_food_fkey 
    FOREIGN KEY (fdc_id_of_acquisition_food) REFERENCES food(fdc_id);

-- agricultural_samples
ALTER TABLE agricultural_samples
  ADD CONSTRAINT agricultural_samples_fdc_id_fkey 
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id);

-- branded_food
ALTER TABLE branded_food 
  ALTER COLUMN serving_size TYPE FLOAT USING NULLIF(serving_size, '')::FLOAT,
  ALTER COLUMN modified_date TYPE DATE USING NULLIF(modified_date, '')::DATE,
  ALTER COLUMN available_date TYPE DATE USING NULLIF(available_date, '')::DATE,
  ALTER COLUMN discontinued_date TYPE DATE USING NULLIF(discontinued_date, '')::DATE,
  ADD CONSTRAINT branded_food_fdc_id_fkey 
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id);

-- fndds_derivation
ALTER TABLE fndds_derivation
  ADD CONSTRAINT fndds_derivation_pkey 
    PRIMARY KEY (derivation_code);

-- fndds_ingredient_nutrient_value
ALTER TABLE fndds_ingredient_nutrient_value
  ALTER COLUMN sr_addmod_year TYPE INT USING NULLIF(sr_addmod_year, '')::INT,
  ALTER COLUMN start_date TYPE DATE USING NULLIF(start_date, '')::DATE,
  ALTER COLUMN end_date TYPE DATE USING NULLIF(end_date, '')::DATE,
  ADD CONSTRAINT fndds_ingredient_nutrient_value_derivation_code_fkey
    FOREIGN KEY (derivation_code) REFERENCES fndds_derivation(derivation_code);

-- food_attribute
DELETE FROM food_attribute WHERE fdc_id='';

ALTER TABLE food_attribute
  ALTER COLUMN seq_num TYPE INT USING NULLIF(seq_num, '')::INT,
  ALTER COLUMN food_attribute_type_id TYPE INT USING NULLIF(food_attribute_type_id, '')::INT,
  ALTER COLUMN fdc_id SET NOT NULL,
  ALTER COLUMN fdc_id TYPE INT USING fdc_id::INT,
  ADD CONSTRAINT food_attribute_fdc_id_fkey FOREIGN KEY (fdc_id) REFERENCES food(fdc_id),
  ADD CONSTRAINT food_attribute_food_attribute_type_id_fkey
    FOREIGN KEY (food_attribute_type_id) REFERENCES food_attribute_type(id);

-- food_attribute_type
-- none

-- food_calorie_conversion_factor
ALTER TABLE food_calorie_conversion_factor 
  ALTER COLUMN protein_value TYPE FLOAT USING (
    CASE 
      WHEN protein_value='' THEN 0.0
      ELSE protein_value::FLOAT
    END
  ),
  ALTER COLUMN fat_value TYPE FLOAT USING (
    CASE 
      WHEN fat_value='' THEN 0.0
      ELSE fat_value::FLOAT
    END
  ),
  ALTER COLUMN carbohydrate_value TYPE FLOAT USING (
    CASE 
      WHEN carbohydrate_value='' THEN 0.0
      ELSE carbohydrate_value::FLOAT
    END
  );

-- food_category
-- none

-- food_component
ALTER TABLE food_component
  ALTER COLUMN pct_weight TYPE FLOAT USING NULLIF(pct_weight, '')::FLOAT,
  ALTER COLUMN is_refuse TYPE BOOLEAN USING (
    CASE
      WHEN is_refuse='Y' THEN TRUE
      ELSE FALSE
    END
  ),
  ALTER COLUMN is_refuse SET NOT NULL,
  ALTER COLUMN min_year_acquired TYPE INT USING NULLIF(min_year_acquired, '')::INT,
  ADD CONSTRAINT food_component_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id);

-- food
ALTER TABLE food
  ALTER COLUMN food_category_id TYPE INT USING NULLIF(food_category_id, '')::INT,
  ADD CONSTRAINT food_food_category_id_fk
    FOREIGN KEY (food_category_id) REFERENCES wweia_food_category(id);

-- food_nutrient_conversion_factor
ALTER TABLE food_nutrient_conversion_factor
  ADD CONSTRAINT food_nutrient_conversion_factor_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id);

-- food_nutrient
DELETE FROM food_nutrient WHERE fdc_id BETWEEN 1104805 AND 1104809;

ALTER TABLE food_nutrient
  ALTER COLUMN data_points TYPE INT USING NULLIF(data_points, '')::INT,
  ALTER COLUMN derivation_id TYPE INT USING NULLIF(derivation_id, '')::INT,
  ALTER COLUMN min TYPE FLOAT USING NULLIF(min, '')::FLOAT,
  ALTER COLUMN max TYPE FLOAT USING NULLIF(max, '')::FLOAT,
  ALTER COLUMN median TYPE FLOAT USING NULLIF(median, '')::FLOAT,
  ALTER COLUMN min_year_acquired TYPE INT USING NULLIF(min_year_acquired, '')::INT,
  ADD COLUMN nutrient_id_nid INT,
  ADD COLUMN nutrient_id_nnbr FLOAT;

ALTER TABLE nutrient -- must pre-alter `nutrient` to get keys to work
  ALTER COLUMN nutrient_nbr TYPE FLOAT USING NULLIF(nutrient_nbr, '')::FLOAT,
  ADD CONSTRAINT unique_nutrient_nbr UNIQUE (nutrient_nbr);

UPDATE food_nutrient SET nutrient_id_nid=nutrient_id 
  WHERE nutrient_id IN (SELECT id FROM nutrient);

UPDATE food_nutrient SET nutrient_id_nnbr=nutrient_id 
  WHERE nutrient_id IN (SELECT nutrient_nbr FROM nutrient);

ALTER TABLE food_nutrient
  ADD CONSTRAINT food_nutrient_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id),
  ADD CONSTRAINT food_nutrient_nutrient_id_nid_fk
    FOREIGN KEY (nutrient_id_nid) REFERENCES nutrient(id),
  ADD CONSTRAINT food_nutrient_nutrient_id_nnbr_fk
    FOREIGN KEY (nutrient_id_nnbr) REFERENCES nutrient(nutrient_nbr),
  ADD CONSTRAINT food_nutrient_derivation_id_fk
    FOREIGN KEY (derivation_id) REFERENCES food_nutrient_derivation(id);

-- food_nutrient_derivation
ALTER TABLE food_nutrient_derivation
  ADD CONSTRAINT food_nutrient_derivation_source_id_fk
    FOREIGN KEY (source_id) REFERENCES food_nutrient_source(id);

-- food_nutrient_source
-- none

-- food_portion
ALTER TABLE food_portion
  ALTER COLUMN seq_num TYPE INT USING NULLIF(seq_num, '')::INT,
  ALTER COLUMN data_points TYPE INT USING NULLIF(data_points, '')::INT,
  ALTER COLUMN min_year_acquired TYPE INT USING NULLIF(min_year_acquired, '')::INT,
  ADD CONSTRAINT food_portion_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id),
  ADD CONSTRAINT food_portion_measure_unit_id_fk
    FOREIGN KEY (measure_unit_id) REFERENCES measure_unit(id);

-- food_protein_conversion_factor
-- none

-- food_update_log_entry
-- none

-- foundation_food
ALTER TABLE foundation_food
  ADD CONSTRAINT foundation_food_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id);

-- input_food
ALTER TABLE input_food
  DROP COLUMN sr_code,
  DROP COLUMN sr_description,
  DROP COLUMN unit,
  DROP COLUMN portion_code,
  DROP COLUMN portion_description,
  DROP COLUMN gram_weight,
  DROP COLUMN retention_code,
  DROP COLUMN survey_flag,
  ALTER COLUMN seq_num TYPE INT USING NULLIF(seq_num, '')::INT,
  ALTER COLUMN amount TYPE FLOAT USING NULLIF(amount, '')::FLOAT,
  ADD CONSTRAINT input_food_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id),
  ADD CONSTRAINT input_food_fdc_of_input_food_fk
    FOREIGN KEY (fdc_of_input_food) REFERENCES food(fdc_id);

-- lab_method_code
ALTER TABLE lab_method_code
  ADD CONSTRAINT lab_method_code_lab_method_id_fk
    FOREIGN KEY (lab_method_id) REFERENCES lab_method(id);

-- lab_method
-- none

-- lab_method_nutrient
ALTER TABLE lab_method_nutrient
  ADD CONSTRAINT lab_method_nutrient_lab_method_id_fk
    FOREIGN KEY (lab_method_id) REFERENCES lab_method(id),
  ADD CONSTRAINT lab_method_nutrient_nutrient_id_fk
    FOREIGN KEY (nutrient_id) REFERENCES nutrient(id);

-- market_acquisition
ALTER TABLE market_acquisition
  ALTER COLUMN expiration_date TYPE DATE USING NULLIF(expiration_date, '')::DATE,
  ALTER COLUMN label_weight TYPE FLOAT USING NULLIF(label_weight, '')::FLOAT,
  ALTER COLUMN acquisition_date TYPE DATE USING NULLIF(acquisition_date, '')::DATE,
  ALTER COLUMN sell_by_date TYPE DATE USING NULLIF(sell_by_date, '')::DATE;

-- measure_unit
-- none

-- nutrient
-- none

-- nutrient_incoming_name
ALTER TABLE nutrient_incoming_name
  ADD CONSTRAINT nutrient_incoming_name_nutrient_id_fk
    FOREIGN KEY (nutrient_id) REFERENCES nutrient(id);

-- retention_factor
-- none

-- sample_food
ALTER TABLE sample_food
  ADD CONSTRAINT sample_food_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id);

-- sr_legacy_food
ALTER TABLE sr_legacy_food
  ADD CONSTRAINT sr_legacy_food_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id);

-- sub_sample_food
DELETE FROM sub_sample_food WHERE fdc_id_of_sample_food=1104803;
ALTER TABLE sub_sample_food
  ADD CONSTRAINT sub_sample_food_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id),
  ADD CONSTRAINT sub_sample_food_fdc_id_of_sample_food_fk
    FOREIGN KEY (fdc_id_of_sample_food) REFERENCES food(fdc_id);

-- sub_sample_result
DELETE FROM sub_sample_result WHERE food_nutrient_id BETWEEN 13336250 AND 13336266;
ALTER TABLE sub_sample_result
  ALTER COLUMN adjusted_amount TYPE FLOAT USING NULLIF(adjusted_amount, '')::FLOAT,
  ADD CONSTRAINT sub_sample_result_food_nutrient_id_fk
    FOREIGN KEY (food_nutrient_id) REFERENCES food_nutrient(id),
  ADD CONSTRAINT sub_sample_result_lab_method_id_fk
    FOREIGN KEY (lab_method_id) REFERENCES lab_method(id);

-- survey_fndds_food
ALTER TABLE survey_fndds_food
  ADD CONSTRAINT survey_fndds_food_fdc_id_fk
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id),
  ADD CONSTRAINT survey_fndds_food_wweia_category_code_fk
    FOREIGN KEY (wweia_category_code) REFERENCES wweia_food_category(id);

-- wweia_food_category
-- none
