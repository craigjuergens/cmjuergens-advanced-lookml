view: inventory_items {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.inventory_items` ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# this is a comment

  dimension: cost {
    group_label: "Product"
    type: number
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    description: "The date on which the item entered the Fashion.ly warehouse."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    group_label: "Product"
    group_item_label: "Brand"
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    group_label: "Product"
    group_item_label: "Category"
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    group_label: "Product"
    group_item_label: "Department"
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    hidden: yes # FK only
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    hidden: yes # FK only
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    group_label: "Product"
    group_item_label: "Name"
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    group_label: "Product"
    group_item_label: "Retail Price"
    type: number
    value_format_name: usd
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    group_label: "Product"
    label: "SKU"
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension_group: sold {
    description: "The date on which the item was sold on the Fashion.ly website."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.sold_at ;;
  }

### Measures ###

  measure: count {
    type: count
    drill_fields: [id, product_name, products.name, products.id, order_items.count]
  }

  measure: total_cost {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

  measure: avg_cost {
    type: average
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

# measure for average gross margin ... how to calculate this one?

}
