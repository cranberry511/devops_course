resource "yandex_mdb_mysql_database" "my_db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "my_user" {
  cluster_id = var.cluster_id
  name       = var.db_user
  password   = "v1ry_str0ng_paYswQrd"

  permission {
    database_name = var.db_name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

}
