def create_or_delete_like(project_id, user_id)
  sql1 = "SELECT * FROM likes WHERE project_id = $1 AND user_id = $2;"
  if (run_sql(sql1, [project_id, user_id]).count != 0)
    sql2 = "DELETE FROM likes WHERE project_id = $1 AND user_id = $2;"
    run_sql(sql2, [project_id, user_id])
  else 
    sql3 = "INSERT INTO likes (project_id, user_id) VALUES ($1, $2);"
    run_sql(sql3, [project_id, user_id])
  end
end
