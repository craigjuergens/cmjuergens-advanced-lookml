view: users {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.users` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    group_label: "Demographics"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    group_label: "Location"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    group_label: "Location"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    description: "The date on which the User signed up on the Fashion.ly website."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    group_label: "Demographics"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: location {
    group_label: "Location"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: postal_code {
    group_label: "Location"
    type: string
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.postal_code ;;
  }

  dimension: state {
    group_label: "Location"
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: street_address {
    hidden: yes # PII risk
    type: string
    sql: ${TABLE}.street_address ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

### Measures ###

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, order_items.count]
  }

}
