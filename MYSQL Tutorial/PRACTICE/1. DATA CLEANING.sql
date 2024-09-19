-- DATA CLEANING

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standarize the data
-- 3. Null values or blank values
-- 4. Remove any columns

CREATE TABLE layoffs_staging1
LIKE layoffs;

SELECT *
FROM layoffs_staging1;

INSERT layoffs_staging1
SELECT *
FROM layoffs;


SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,`date`) AS row_num
FROM layoffs_staging1;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging1
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging1
where company = 'Casper';

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging1
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- standardizing data

SELECT company, (TRIM(company))
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);


SELECT *
FROM layoffs_staging2
where industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry like 'Crypto%';

SELECT distinct industry 
FROM layoffs_staging2
order by 1;

SELECT *
FROM layoffs_staging2
WHERE country like 'United States%';

SELECT distinct country, trim(TRAILING '.' FROM country) 
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country = trim(TRAILING '.' FROM country) 
WHERE country like 'United States%';

SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` date;

SELECT *
FROM layoffs_staging2;

-- Removing Null values

SELECT *
FROM layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoffs_staging2
set industry = null
where industry = '';

SELECT *
FROM layoffs_staging2
where industry is null
or industry = '';

SELECT *
FROM layoffs_staging2
where company like 'Bally%';

select t1.industry,t2.industry
FROM layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '') 
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '') 
and t2.industry is not null;

select *
from layoffs_staging2;


SELECT *
FROM layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;


DELETE 
FROM layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

SELECT *
FROM layoffs_staging2;

alter table layoffs_staging2
drop column row_num;