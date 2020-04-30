def run_sql(sql, params = [])
    conn = PG.connect(dbname: 'stitch_by_stitch')
    records = conn.exec_params(sql, params)
    conn.close
    records
  end

def all_projects()
    run_sql("SELECT * FROM projects order by title")
end

  def create_project(title, design, size, colors, fabric_count, start, finish, details, main_image_url, user_id)
    run_sql("INSERT INTO projects (
        title, design, size, colors, fabric_count, start, finish, details, main_image_url, user_id) 
        VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10);", [
        title, design, size, colors, fabric_count, start, finish, details, main_image_url, user_id])
  end

  def find_one_project_by_id(id)
    project = run_sql("SELECT * FROM projects WHERE id = $1;", [id])[0]
  end

  def update_project(id, title, design, size, colors, fabric_count, start, finish, details, main_image_url)
    sql = "UPDATE projects SET title = $1, design = $2, size = $3, colors = $4, fabric_count = $5, start = $6, finish = $7, details = $8, main_image_url = $9 WHERE id = $10;"
    run_sql(sql, [title, design, size, colors, fabric_count, start, finish, details, main_image_url, id])
  end
  
  def delete_project(id)
    sql = "DELETE FROM projects WHERE id = $1;"
    run_sql(sql, [id])
  end

  