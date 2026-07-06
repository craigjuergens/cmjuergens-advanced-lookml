view: order_items {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.order_items` ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes # PK only
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    description: "The date on which the payment processing was completed. Can vary slightly (delay) from the inventory sold at date."
    type: time
    timeframes: [raw, time, date, week, month, month_name, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    #hidden: yes # FK only
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    label: "Order ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    hidden: yes # FK only
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    hidden: yes # FK only
    type: number
    sql: ${TABLE}.user_id ;;
  }

### Measures ###

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_return_items {
    type: count
    filters: [status: "Returned"]
  }

  measure: count_return_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [status: "Returned"]
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: avg_spend_per_customer {
    type: number
    value_format_name: usd
    sql: safe_divide(${total_sale_price}, ${count_users}) ;;
  }

  measure: user_w_returns {
    label: "Percent Users w Return"
    type: number
    value_format_name: percent_1
    sql: safe_divide(${count_return_users}, ${count_users}) ;;
  }

  measure: return_rate {
    type: number
    value_format_name: percent_1
    sql: safe_divide(${count_return_items}, ${count}) ;;
  }

  measure: total_sale_price {
    description: "Total sales from items sold."
    type: sum
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
  }

  measure: avg_sale_price {
    type: average
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
  }

  measure: gross_revenue {
    description: "Excludes cancels and returns."
    type: sum
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
    filters: [status: "-Cancelled, -Returned"]
  }

  measure: cumulative_sale_price {
    type: running_total
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_gross_margin {
    type: number
    value_format_name: usd
    sql: ${gross_revenue} - ${products.total_cost} ;;
  }

  measure: gross_margin_perc {
    type: number
    value_format_name: percent_1
    sql: safe_divide((${gross_revenue} - ${products.total_cost}), ${gross_revenue}) ;;
  }

#Still needed:

# Average Gross Margin
# Average difference between the total revenue from completed sales and the cost of the goods that were sold



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.last_name,
  users.id,
  users.first_name,
  inventory_items.id,
  inventory_items.product_name,
  products.name,
  products.id
  ]
  }

}
