view: products {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.products` ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: COALESCE(${TABLE}.brand, "NULL") ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    type: number
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    drill_fields: [category]
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    hidden: yes # FK only
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    value_format_name: usd
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    label: "SKU"
    description: "Unique identifier at Style/Color/Size level"
    type: string
    sql: ${TABLE}.sku ;;
  }

### Measures ###

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_cost {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  name,
  distribution_centers.name,
  distribution_centers.id,
  inventory_items.count,
  order_items.count
  ]
  }

}
