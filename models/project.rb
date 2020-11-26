require 'cloudinary/uploader'
require 'cloudinary/utils'

def run_sql(sql, params = [])
  conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'stitch_by_stitch'})
  records = conn.exec_params(sql, params)
  conn.close
  records
  end

def all_projects()
  run_sql("SELECT * FROM projects order by title")
end

def create_project(title, design, size, width, height, colors, threads, fabric_count, start, finish, details, image, user_id)
  run_sql("INSERT INTO projects (
    title, design, size, width, height, colors, threads, fabric_count, fabric_type, start, finish, details, main_image_url, user_id) 
    VALUES (
    $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14);", [title, design, size, width, height, colors, threads, fabric_count, fabric_type, start, finish, details, image, user_id])
end

def find_one_project_by_id(id)
  project = run_sql("SELECT * FROM projects WHERE id = $1;", [id])[0]
end

def update_project(id, title, design, size, width, height, colors, threads, fabric_count, fabric_type, start, finish, details, image)
  sql = "UPDATE projects SET title = $1, design = $2, size = $3, width = $4, height = $5, colors = $6, threads = $7, fabric_count = $8, fabric_type = $9, start = $10, finish = $11, details = $12, main_image_url = $13 WHERE id = $14;"
  run_sql(sql, [title, design, size, width, height, colors, threads, fabric_count, fabric_type, start, finish, details, image, id])
end

def delete_project(id)
  sql = "DELETE FROM projects WHERE id = $1;"
  run_sql(sql, [id])
end

def all_designs()
  sql = "SELECT * FROM projects;"
  run_sql(sql) 
end 

def find_projects_by_design(design)
  sql = "SELECT * FROM projects where design = $1;"
  run_sql(sql, [design])
end

def find_all_projects_by_user_id(user_id)
  sql = "SELECT * FROM projects WHERE user_id = $1;"
  run_sql(sql, [user_id])
end

def find_likes_count_by_project_id(project_id)
  sql = "SELECT * FROM likes WHERE project_id = $1;"
  run_sql(sql,[project_id]).count
end

def all_projects_by_query(search,sort_query)
  search_string = "%#{search}%"  
  projects = run_sql("select * from projects where design like $1 order by title #{sort_query};",[search_string])
  projects
end