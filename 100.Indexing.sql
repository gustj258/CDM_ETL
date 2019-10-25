/*********************************************************************************
# Copyright 2014 Observational Health Data Sciences and Informatics
#
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
********************************************************************************/

/************************
 ####### #     # ####### ######      #####  ######  #     #           #######    ###                                           
 #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #           #  #    # #####  ###### #    # ######  ####  
 #     # # # # # #     # #     #    #       #     # # # # #    #    # #           #  ##   # #    # #       #  #  #      #      
 #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######      #  # #  # #    # #####    ##   #####   ####  
 #     # #     # #     # #          #       #     # #     #    #    #       #     #  #  # # #    # #        ##   #           # 
 #     # #     # #     # #          #     # #     # #     #     #  #  #     #     #  #   ## #    # #       #  #  #      #    # 
 ####### #     # ####### #           #####  ######  #     #      ##    #####     ### #    # #####  ###### #    # ######  ####  
                                                                              
script to create the required indexes within OMOP common data model, version 5.0 for SQL Server database
last revised: 12 Oct 2014
author:  Patrick Ryan
description:  These indices are considered a minimal requirement to ensure adequate performance of analyses.
*************************/

/*Modified for Korean OHDSI from Patrick Ryan
last revised: 03 Nov 2016
author:  jung hyun byun
*/

/****************************************************************************************************************************************
*****************************************************	Cluster Index  ******************************************************************
*****************************************************************************************************************************************
 **********************************/

/************************
Standardized vocabulary
************************/

CREATE UNIQUE CLUSTERED INDEX idx_concept_concept_id ON cohort_cdm.concept (concept_id ASC);
CREATE INDEX idx_concept_code ON cohort_cdm.concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON cohort_cdm.concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON cohort_cdm.concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON cohort_cdm.concept (concept_class_id ASC);


CREATE UNIQUE CLUSTERED INDEX idx_vocabulary_vocabulary_id ON cohort_cdm.vocabulary (vocabulary_id ASC);
--CREATE UNIQUE CLUSTERED INDEX idx_domain_domain_id ON domain (domain_id ASC);
CREATE UNIQUE CLUSTERED INDEX idx_concept_class_class_id ON cohort_cdm.concept_class (concept_class_id ASC);
CREATE INDEX idx_concept_relationship_id_1 ON cohort_cdm.concept_relationship (concept_id_1 ASC); 
CREATE INDEX idx_concept_relationship_id_2 ON cohort_cdm.concept_relationship (concept_id_2 ASC); 
CREATE INDEX idx_concept_relationship_id_3 ON cohort_cdm.concept_relationship (relationship_id ASC); 
CREATE UNIQUE CLUSTERED INDEX idx_relationship_rel_id ON cohort_cdm.relationship (relationship_id ASC);
CREATE CLUSTERED INDEX idx_concept_synonym_id ON cohort_cdm.concept_synonym (concept_id ASC);
CREATE CLUSTERED INDEX idx_concept_ancestor_id_1 ON cohort_cdm.concept_ancestor (ancestor_concept_id ASC);
CREATE INDEX idx_concept_ancestor_id_2 ON cohort_cdm.concept_ancestor (descendant_concept_id ASC);
--CREATE CLUSTERED INDEX idx_source_to_concept_map_id_3 ON source_to_concept_map (target_concept_id ASC);
--CREATE INDEX idx_source_to_concept_map_id_1 ON source_to_concept_map (source_vocabulary_id ASC);
--CREATE INDEX idx_source_to_concept_map_id_2 ON source_to_concept_map (target_vocabulary_id ASC);
--CREATE INDEX idx_source_to_concept_map_code ON source_to_concept_map (source_code ASC);
CREATE CLUSTERED INDEX idx_drug_strength_id_1 ON cohort_cdm.drug_strength (drug_concept_id ASC);
CREATE INDEX idx_drug_strength_id_2 ON cohort_cdm.drug_strength (ingredient_concept_id ASC);
--CREATE CLUSTERED INDEX idx_cohort_definition_id ON cohort_definition (cohort_definition_id ASC);
--CREATE CLUSTERED INDEX idx_attribute_definition_id ON attribute_definition (attribute_definition_id ASC);

/************************
Standardized clinical data
************************/

CREATE UNIQUE CLUSTERED INDEX idx_person_id ON cohort_cdm.person (person_id ASC);

CREATE CLUSTERED INDEX idx_observation_period_id ON cohort_cdm.observation_period (person_id ASC);

CREATE CLUSTERED INDEX idx_specimen_person_id ON cohort_cdm.specimen (person_id ASC);

CREATE INDEX idx_specimen_concept_id ON cohort_cdm.specimen (specimen_concept_id ASC);

CREATE CLUSTERED INDEX idx_death_person_id ON cohort_cdm.death (person_id ASC);

CREATE CLUSTERED INDEX idx_visit_person_id ON cohort_cdm.visit_occurrence (person_id ASC);

CREATE INDEX idx_visit_concept_id ON cohort_cdm.visit_occurrence (visit_concept_id ASC);

CREATE CLUSTERED INDEX idx_procedure_person_id ON cohort_cdm.procedure_occurrence (person_id ASC);

CREATE INDEX idx_procedure_concept_id ON cohort_cdm.procedure_occurrence (procedure_concept_id ASC);

CREATE INDEX idx_procedure_visit_id ON cohort_cdm.procedure_occurrence (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_drug_person_id ON cohort_cdm.drug_exposure (person_id ASC);

CREATE INDEX idx_drug_concept_id ON cohort_cdm.drug_exposure (drug_concept_id ASC);

CREATE INDEX idx_drug_visit_id ON cohort_cdm.drug_exposure (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_device_person_id ON cohort_cdm.device_exposure (person_id ASC);

CREATE INDEX idx_device_concept_id ON cohort_cdm.device_exposure (device_concept_id ASC);

CREATE INDEX idx_device_visit_id ON cohort_cdm.device_exposure (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_condition_person_id ON cohort_cdm.condition_occurrence (person_id ASC);

CREATE INDEX idx_condition_concept_id ON cohort_cdm.condition_occurrence (condition_concept_id ASC);

CREATE INDEX idx_condition_visit_id ON cohort_cdm.condition_occurrence (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_measurement_person_id ON cohort_cdm.measurement (person_id ASC);

CREATE INDEX idx_measurement_concept_id ON cohort_cdm.measurement (measurement_concept_id ASC);

CREATE INDEX idx_measurement_visit_id ON cohort_cdm.measurement (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_note_person_id ON cohort_cdm.note (person_id ASC);

CREATE INDEX idx_note_concept_id ON cohort_cdm.note (note_type_concept_id ASC);

CREATE INDEX idx_note_visit_id ON cohort_cdm.note (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_observation_person_id ON cohort_cdm.observation (person_id ASC);

CREATE INDEX idx_observation_concept_id ON cohort_cdm.observation (observation_concept_id ASC);

CREATE INDEX idx_observation_visit_id ON cohort_cdm.observation (visit_occurrence_id ASC);



/************************
Standardized health economics
************************/

CREATE CLUSTERED INDEX idx_period_person_id ON cohort_cdm.payer_plan_period (person_id ASC);

/************************
Standardized derived elements
************************/


CREATE INDEX idx_cohort_subject_id ON cohort_cdm.cohort (subject_id ASC);

CREATE INDEX idx_cohort_c_definition_id ON cohort_cdm.cohort (cohort_definition_id ASC);

CREATE INDEX idx_ca_subject_id ON cohort_cdm.cohort_attribute (subject_id ASC);

CREATE INDEX idx_ca_definition_id ON cohort_cdm.cohort_attribute (cohort_definition_id ASC);

CREATE CLUSTERED INDEX idx_drug_era_person_id ON cohort_cdm.drug_era (person_id ASC);

CREATE INDEX idx_drug_era_concept_id ON cohort_cdm.drug_era (drug_concept_id ASC);

CREATE CLUSTERED INDEX idx_dose_era_person_id ON cohort_cdm.dose_era (person_id ASC);

CREATE INDEX idx_dose_era_concept_id ON cohort_cdm.dose_era (drug_concept_id ASC);

CREATE CLUSTERED INDEX idx_condition_era_person_id ON cohort_cdm.condition_era (person_id ASC);

CREATE INDEX idx_condition_era_concept_id ON cohort_cdm.condition_era (condition_concept_id ASC);


/****************************************************************************************************************************************
*****************************************************	Non Cluster Index  **************************************************************
 ****************************************************************************************************************************************
 **********************************/

 /* PERSON */


	CREATE NONCLUSTERED INDEX [<PERSON_1, sysname,>]
		ON cohort_cdm.PERSON ([person_id])
			INCLUDE ([year_of_birth],[gender_concept_id] );
			
				 			


	CREATE NONCLUSTERED INDEX [<PERSON_2, sysname,>]
		ON cohort_cdm.PERSON ([location_id])
			INCLUDE ([person_id]);

				 

	CREATE NONCLUSTERED INDEX [<PERSON_3, sysname,>]
		ON cohort_cdm.PERSON ([provider_id]);

				

	CREATE NONCLUSTERED INDEX [<PERSON_4, sysname,>]
		ON cohort_cdm.PERSON ([care_site_id]);

			
/* OBSERVATION */ 
	CREATE NONCLUSTERED INDEX [<OBSERVATION_1, sysname,>]
		ON cohort_cdm.[OBSERVATION] ([provider_id]);
	CREATE NONCLUSTERED INDEX [<OBSERVATION_2, sysname,>]
		ON cohort_cdm.[OBSERVATION] ([visit_occurrence_id]);
	CREATE NONCLUSTERED INDEX [<OBSERVATION_3, sysname,>]
		ON cohort_cdm.[OBSERVATION] ([value_as_number],[unit_concept_id])
			INCLUDE ([observation_concept_id]);

			 

/* OBSERVATION_PERIOD */

	CREATE NONCLUSTERED INDEX [<OBSERVATION_PERIOD_4, sysname,>]
		ON cohort_cdm.[OBSERVATION_PERIOD] ([PERSON_ID])
			INCLUDE ([OBSERVATION_PERIOD_START_DATE]);

			 

	CREATE NONCLUSTERED INDEX [<OBSERVATION_PERIOD_5, sysname,>]
		ON cohort_cdm.[OBSERVATION_PERIOD] ([OBSERVATION_PERIOD_START_DATE],[OBSERVATION_PERIOD_END_DATE])
			INCLUDE ([PERSON_ID]);

			 

/* VISIT */


	CREATE NONCLUSTERED INDEX [<VISIT_1, sysname,>]
		ON cohort_cdm.[VISIT_OCCURRENCE] ([care_site_id]);

		 

/* CONDITION */


	CREATE NONCLUSTERED INDEX [<CONDITION_1, sysname,>]
		ON cohort_cdm.[CONDITION_OCCURRENCE] ([provider_id]);

		

	CREATE NONCLUSTERED INDEX [<CONDITION_2, sysname,>]
		ON cohort_cdm.[CONDITION_OCCURRENCE] ([visit_occurrence_id]);

		

/* CONDITION_ERA */


	CREATE NONCLUSTERED INDEX [<CONDITION_ERA_1, sysname,>]
		ON cohort_cdm.[CONDITION_ERA] ([person_id])
			INCLUDE ([condition_concept_id],[condition_era_start_date]);

			

/* PROCEDURE */


	CREATE NONCLUSTERED INDEX [<PROCEDURE_1, sysname,>]
		ON cohort_cdm.[PROCEDURE_OCCURRENCE] ([provider_id], [visit_occurrence_id]);

		
		

/* DRUG */

	CREATE NONCLUSTERED INDEX [<DRUG_1, sysname,>]
		ON cohort_cdm.[DRUG_EXPOSURE] ([provider_id]);

		
 
	CREATE NONCLUSTERED INDEX [<DRUG_2, sysname,>]
		ON cohort_cdm.[DRUG_EXPOSURE] ([visit_occurrence_id])

		

	CREATE NONCLUSTERED INDEX [<DRUG_3, sysname,>]
		ON cohort_cdm.[DRUG_EXPOSURE] ([days_supply])
			INCLUDE ([drug_concept_id])

			

	CREATE NONCLUSTERED INDEX [<DRUG_4, sysname,>]
		ON cohort_cdm.[DRUG_EXPOSURE] ([refills])
			INCLUDE ([drug_concept_id])

			

	CREATE NONCLUSTERED INDEX [<DRUG_5, sysname,>]
		ON cohort_cdm.[DRUG_EXPOSURE] ([quantity])
			INCLUDE ([drug_concept_id])

			

	CREATE NONCLUSTERED INDEX [<DRUG_6, sysname,>]
		ON cohort_cdm.[DRUG_EXPOSURE] ([drug_concept_id])
			INCLUDE ([drug_source_value])

			

/* DRUG_ERA */

	CREATE NONCLUSTERED INDEX [<DRUG_ERA_1, sysname,>]
		ON cohort_cdm.[DRUG_ERA] ([person_id])
			INCLUDE ([drug_concept_id],[drug_era_start_date])

		

/* MEASUREMENT */

	CREATE NONCLUSTERED INDEX [<MEASUREMENT_1, sysname,>]
		ON cohort_cdm.[MEASUREMENT] ([person_id])
			INCLUDE ([measurement_concept_id],[measurement_date]);

			

	CREATE NONCLUSTERED INDEX [<MEASUREMENT_2, sysname,>]
		ON cohort_cdm.[MEASUREMENT] ([provider_id]);

		

	CREATE NONCLUSTERED INDEX [<MEASUREMENT_3, sysname,>]
		ON cohort_cdm.[MEASUREMENT] ([visit_occurrence_id]);

		

	CREATE NONCLUSTERED INDEX [<MEASUREMENT_4, sysname,>]
		ON cohort_cdm.[MEASUREMENT] ([value_as_number],[value_as_concept_id]);

		

	CREATE NONCLUSTERED INDEX [<MEASUREMENT_5, sysname,>]
		ON cohort_cdm.[MEASUREMENT] ([value_as_number],[unit_concept_id])
			INCLUDE ([measurement_concept_id]);

			

	CREATE NONCLUSTERED INDEX [<MEASUREMENT_6, sysname,>]
		ON cohort_cdm.[MEASUREMENT] ([value_as_number],[unit_concept_id],[range_low],[range_high])
			INCLUDE ([measurement_concept_id]);

			
		
	CREATE NONCLUSTERED INDEX [<MEASUREMENT_7, sysname,>]
		ON cohort_cdm.[MEASUREMENT] ([value_as_number]);

			

/* PROVIDER */

	CREATE NONCLUSTERED INDEX [<PROVIDER_1, sysname,>]
		ON cohort_cdm.[PROVIDER] ([care_site_id]);
			
			

/* PAYER_PLAN_PERIOD */

	CREATE NONCLUSTERED INDEX [<PAYER_PLAN_PERIOD_1, sysname,>]
		ON cohort_cdm.[PAYER_PLAN_PERIOD] ([person_id])
			INCLUDE ([payer_plan_period_start_date],[payer_plan_period_end_date]);

/* ACHILLES_results */

	--CREATE NONCLUSTERED INDEX [<ACHILLES_RESULTS, sysname,>]
		--ON @ResultDatabaseSchema.[ACHILLES_results] ([count_value]);
