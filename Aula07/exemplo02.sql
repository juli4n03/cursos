SET preserve_insertion_order = false;
SET memory_limit = '4GB';
SET threads TO 4;

CREATE TABLE "base_credito_bureau_A" AS
    FROM 'D:\DadosCurso\base_modelo_credito_kaggle\csv_files\train\train_credit_bureau_a_1_*.csv';
   
describe base_credito_bureau_A;

SELECT 
	case_id,
	credlmt_935A,
    sum(credlmt_935A) OVER (
        ROWS BETWEEN 1 PRECEDING
                 AND 1 FOLLOWING) soma_frame
FROM base_credito_bureau_A;

SELECT case_id, dateofcredstart_181D, credlmt_935A, credlmt_935A - lag(credlmt_935A) OVER (ORDER BY case_id) as var_credlmt_935A  FROM base_credito_bureau_A w order by dateofcredstart_181D, case_id;

CREATE TABLE "base_credito_bureau_B_1" AS
FROM read_csv(
    'D:\DadosCurso\base_modelo_credito_kaggle\csv_files\test\test_credit_bureau_b_1.csv',
    rejects_table = 'rejects_table',
    ignore_errors = true
);   
select
	*
from base_credito_bureau_B_1
limit 5;

CREATE TABLE "base_credito_pessoas" as
FROM read_csv(
    'D:\DadosCurso\base_modelo_credito_kaggle\csv_files\train\train_person_*.csv',
    union_by_name = true,
    null_padding = true,
    all_varchar = true
);   
select
	count(*)
from base_credito_pessoas
limit 5;

describe base_credito_pessoas;
