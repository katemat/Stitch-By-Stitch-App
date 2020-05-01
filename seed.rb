require 'pg'

require_relative 'models/project'
require_relative 'models/user'


# create dummy user
# create_user('Kat','test@gmail.com', 'test')
user = find_one_user_by_email('test@gmail.com')

# create 10 dummy projects
(1..10).each do |n|
  create_project(
    "project title #{n}", 
    "design number #{n}",
    "300 x 200",
    180, 24, '12/12/2015', '11/10/2018',"great project number #{n}", "https://i.etsystatic.com/15987569/r/il/4fc296/1881554026/il_1588xN.1881554026_cp9l.jpg", ARRAY [
    "https://i.etsystatic.com/15987569/r/il/4fc296/1881554026/il_1588xN.1881554026_cp9l.jpg",
    "https://i.etsystatic.com/15987569/r/il/4fc296/1881554026/il_1588xN.1881554026_cp9l.jpg"], user["id"]
  )
end


show.erb
========================
<div class="w3-content w3-display-container">
    <% images_arr = images["image_arr"].gsub(/[{}]/, '').split(',') %>
    <% images_arr.each do |img|%>
    <img class="mySlides" src="<%= img %>" style="width:100%">
    <% end %>
    
<button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
  <button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
</div>
==========================     
  