WITH date_spine AS (

  {{ dbt_utils.date_spine(
      start_date="to_date('11/01/2009', 'mm/dd/yyyy')",
      datepart="day",
      end_date="dateadd(year, 40, current_date)"
     )
  }}

), calculated as (

    SELECT
      date_day,
      DATE_PART('month', date_day) as month,
      DATE_PART('year', date_day) as year 
      from date_spine )

select * from calculated

