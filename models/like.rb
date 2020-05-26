def create_like(project_id, user_id)
    sql = "INSERT INTO likes (project_id, user_id) VALUES ($1, $2);"
    run_sql(sql, [project_id, user_id])
end