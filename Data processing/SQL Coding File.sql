select*
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;


---Dates

select
      transaction_date as purchase_date,
      Dayname(transaction_date) as day_name,
      Monthname(transaction_date) as month_name,
      Dayofmonth(transaction_date) as day_of_month,
    case
          when Dayname(transaction_date) in ('Sun' , 'Sat') then 'Weekend'
          else 'Weekday'
          end as date_type,
      ---date_format(transaction_time, 'HH:mm:ss') as purchase_time,
      case
          when date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:59:59' then '0.1 Morning'
          when date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '0.2 Afternoon'
          when date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' then '0.3 Evening'
          end as time_buckets,
---Counts of IDs
      count(*) as number_of_sales,
      count(distinct product_id) as number_of_products,
      count(distinct store_id) as number_stores,
---Revenue
      sum(transaction_qty*unit_price) as revenue_per_day,
---Categorical Columns
      store_location,
      product_category,
      product_detail
      
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by purchase_date,
      Dayname(transaction_date), 
      Monthname(transaction_date), 
      Dayofmonth(transaction_date),
        case
            when Dayname(transaction_date) in ('Sun' , 'Sat') then 'Weekend'
            else 'Weekday'
            end,
        case
            when date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:59:59' then '0.1 Morning'
            when date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '0.2 Afternoon'
            when date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' then '0.3 Evening'
            end,
        store_location, 
        product_category,
        product_detail;
