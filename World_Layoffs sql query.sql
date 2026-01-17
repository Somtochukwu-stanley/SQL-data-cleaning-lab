-- data cleaning


select *
from layoffs1;


-- standardize the data
-- remove duplicates
-- remove null or blank values
-- remove any column you don't need




-- .1 removing duplicates

with duplicates as (
select *, row_number() over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions ) as row_num
from layoffs1
)
select * 
from duplicates
where row_num>1;



select *
from layoffs1;



CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



select *
from layoffs2;



insert into layoffs2
select *, row_number() over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions ) as row_num
from layoffs1;



select*
from layoffs2
where row_num>1;



delete 
from layoffs2
where row_num>1;



select*
from layoffs2;





-- .2 standardizing the data


select  distinct(company)
from layoffs2;


select distinct(company), trim(company)
from layoffs2;



update layoffs2
set company = trim(company);



select*
from layoffs2; 



select distinct(location)
from layoffs2;




select distinct(industry)
from layoffs2;


update layoffs2
set industry =  'crypto'
where industry like 'crypto%' ;



select distinct(industry)
from layoffs2;



select *
from layoffs2;



select distinct(country)
from layoffs2;



select distinct(country), trim(trailing '.' from country)
from layoffs2;


update layoffs2
set country = trim(trailing '.' from country);



select *
from layoffs2;


select `date`, str_to_date(`date`, '%m/%d/%Y')
from layoffs2;




update layoffs2
set `date` = str_to_date(`date`, '%m/%d/%Y');



select *
from layoffs2;




alter table layoffs2
modify column `date` date;



select *
from layoffs2;






-- removing null values



select *
from layoffs2
where total_laid_off is null and percentage_laid_off is null;



delete 
from layoffs2 
where total_laid_off is null and percentage_laid_off is null;



select *
from layoffs2;



select*
from layoffs2 
where company like 'airbnb%' and industry = '';



alter table layoffs2
drop column row_num;



select *
from layoffs2;





with duplicates as (
select *, row_number() over(partition by company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
 from layoffs2)
 select *
 from duplicates
 where row_num>2;
 
 
 
 
select *
from layoffs2
where company like 'cazoo';
 
 
 
 

CREATE TABLE `layoffs3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` date DEFAULT NULL,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





insert into layoffs3
select *, row_number() over(partition by company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, country, funds_raised_millions) as Row_num
from layoffs2;




select *
from layoffs3;



select *
from layoffs3
where company like '2tm';



delete
from layoffs3
where row_num>2
;



select *
from layoffs3
where row_num>2;



delete
from layoffs3
where row_num>1
;



select *
from layoffs3
where row_num>1;




select *
from layoffs3
where company like 'airbnb%';



select lay1.company, lay2.company, lay1.industry, lay2.industry
from layoffs3 as lay1
join layoffs3 as lay2
	on lay1.company = lay2.company
    and lay1.location = lay2.location
where (lay1.industry is null or lay1.industry = '') and lay2.industry is not null;



update layoffs3 as lay1
join layoffs3 as lay2
 ON lay1.company = lay2.company
 set lay1.industry = lay2.industry
 where (lay1.industry = '' or lay1.industry is null) and lay2.industry is not null;



update layoffs3
set industry = null
where industry = '';



update layoffs3 as lay1
join layoffs3 as lay2
 ON lay1.company = lay2.company
 set lay1.industry = lay2.industry
 where (lay1.industry = '' or lay1.industry is null) and lay2.industry is not null;




select lay1.company, lay2.company, lay1.industry, lay2.industry
from layoffs3 as lay1
join layoffs3 as lay2
	on lay1.company = lay2.company
    and lay1.location = lay2.location
where (lay1.industry is null or lay1.industry = '') and lay2.industry is not null;




select *
from layoffs3
where company like 'juu%';



select *
from layoffs3
where industry is null;



alter table layoffs3
drop column Row_num;



select company, sum(total_laid_off) as total, year(`date`)
from layoffs3
group by company, year(`date`)
;




-- exploratory data analysis


select max(total_laid_off), max(percentage_laid_off)
from layoffs3
;




select *
from layoffs3
where percentage_laid_off = 1
order by total_laid_off desc;




select *
from layoffs3
where percentage_laid_off = 1
order by funds_raised_millions desc;





with new_man as (
select industry, sum(total_laid_off) as total_off
from layoffs3
#where year(`date`) = '2021' 
group by industry
order by 2 desc
)
select industry, total_off
from new_man
group by industry
order by total_off desc;






select max(`date`), min(`date`)
from layoffs3;



select industry, year(`date`), sum(total_laid_off)
from layoffs3
group by industry, year(`date`)
order by 3 desc;



select country,  sum(total_laid_off)
from layoffs3
group by country
order by 2 desc;


select `date`, sum(total_laid_off)
from layoffs3
group by `date`
order by 2 desc;




select year(`date`), sum(total_laid_off)
from layoffs3
group by year(`date`)
order by 2 asc;



select stage, sum(total_laid_off)
from layoffs3
group by stage
order by 2 desc;


with rolling_total as (
select substring(`date`, 1,7) as `month`, sum(total_laid_off) as total_off
from layoffs3
where substring(`date`, 1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off, sum(total_off) over(order by `month`) as rolling_total1
from rolling_total;




select company, year(`date`) as year, sum(total_laid_off) 
from layoffs3
group by company, year(`date`)
order by 3 desc;




with company_year as(
select company, year(`date`) as years, sum(total_laid_off) as total_off
from layoffs3
group by company, year(`date`)
order by total_off desc
), company_ranking as
(
select *, dense_rank() over(partition by years order by total_off desc) as ranking
from company_year
where years is not null
)
select *
from company_ranking
where ranking<=5;



with company_year(company, years, total_off) as (
select company, year(`date`), sum(total_laid_off)
from layoffs3
group by company, year(`date`)
), company_ranking as(
select *, dense_rank() over(partition by years order by total_off desc) as yearly_ranking
from company_year
where years is not null)
select *
from company_ranking
where yearly_ranking <=5
;



 select *
 from layoffs3
 
 
 
 