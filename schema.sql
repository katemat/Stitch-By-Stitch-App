CREATE DATABASE stitch_by_stitch;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    password_digest TEXT
);

CREATE TABLE projects(
    id SERIAL PRIMARY KEY,
    title TEXT,
    design TEXT,
    size TEXT,
    colors INTEGER,
    fabric_count INTEGER,
    start DATE,
    finish DATE, 
    details TEXT,
    main_image_url TEXT
    -- slide_images_url TEXT []
);

ALTER TABLE projects ADD COLUMN user_id INTEGER;

CREATE TABLE images(
    image_arr TEXT [],
    project_id INTEGER
);

INSERT INTO images (image_arr, project_id) VALUES ('{  "https://i.etsystatic.com/15987569/r/il/153773/1881554276/il_794xN.1881554276_3wv5.jpg", "https://i.etsystatic.com/15987569/r/il/3f159a/1881553312/il_794xN.1881553312_t2k8.jpg", "https://i.etsystatic.com/15987569/r/il/3f159a/1881553312/il_794xN.1881553312_t2k8.jpg", "https://i.etsystatic.com/15987569/r/il/6c46e2/1929089953/il_794xN.1929089953_9w0o.jpg",  "https://i.etsystatic.com/15987569/r/il/96f96d/1881553598/il_794xN.1881553598_fyay.jpg"}', 1);