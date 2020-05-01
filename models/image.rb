# def create_image_array_by_project_id(id)
#     run_sql("INSERT INTO images(image_url, project_id) VALUES ($1, $2)", [image_url, project_id])
# end


# # def update_image_array_by_project_id(image_arr, new_image_url, project_id)
# #     sql = "UPDATE images SET image_arr =  array_append($1, $2) WHERE project_id = $3;"
# #     run_sql(sql, [image_arr,new_image_url, project_id])
# # end

# def all_images_by_project_id(id)
#     sql = "SELECT * from images WHERE project_id = $1";
#     run_sql(sql, [id])[0]
#   end