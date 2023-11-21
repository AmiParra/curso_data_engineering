WITH date_spine AS (

  {{ dbt_utils.date_spine(
      start_date="to_date('01/01/2021', 'mm/dd/yyyy')",
      datepart="day",
      end_date="dateadd(year, 40, current_date)"
     )
  }}

), calculated as (

    SELECT
      date_day,
      DAYNAME(date_day) as day_name,
      DATE_PART('month', date_day) as month,
      DATE_PART('year', date_day) as year
      from date_spine )

select * from calculated

