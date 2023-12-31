

{{ 
    config(
        materialized='table', 
        sort='date_day',
        dist='date_day',
        pre_hook="alter session set timezone = 'Europe/Madrid'; alter session set week_start = 7;" 
        ) }}



WITH date_spine AS (

  {{ dbt_utils.date_spine(
      start_date="to_date('01/01/2021', 'mm/dd/yyyy')",
      datepart="day",
      end_date="dateadd(year, 10, current_date()+1)"
     )
  }}

), calculated as (

    SELECT
      year(date_day)*10000+month(date_day)*100+day(date_day) as id_date,
      date_day,
      DAYNAME(date_day) as day_name,
      DATE_PART('month', date_day) as month,
      monthname(date_day) as desc_month,
      DATE_PART('year', date_day) as year,
      year(date_day)*100+month(date_day) as id_year_month,
      year(date_day)||weekiso(date_day)||dayofweek(date_day) as year_week_day,
      weekiso(date_day) as week
      from date_spine )


select * from calculated
order by date_day desc



--from calculated
--order by 
--    date_day desc