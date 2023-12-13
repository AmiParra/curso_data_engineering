with users as (
    select * from {{ ref('dim_users') }}),

orders as (
    select * from {{ ref('fct_product_in_orders') }}),

promos as (
    select * from {{ref('dim_promos')}}),

info_orders as (
    select
        u.id_user,
        u.first_name,
        u.last_name,
        u.phone_number,
        u.email,
        u.address,
        u.zipcode,
        u.city,
        u.country,
        u.state,
        count(distinct o.id_order) as numb_of_total_orders,
        sum(o.quantity) as numb_of_total_products,
        round(sum(o.order_cost_USD),2) as total_order_cost,
        round(sum(o.shipping_cost_USD),2) as total_shipping_cost,
        sum(p.discount_USD) as total_discount
        

        from 
            users u left join orders o
                on u.id_user = o.id_user
                    left join promos p
                on o.id_promo = p.id_promo

           {{dbt_utils.group_by(10)}}
                order by id_user
        )

select * from info_orders