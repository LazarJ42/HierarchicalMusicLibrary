
CREATE DATABASE hierarchical_music_library;

USE hierarchical_music_library;


CREATE TABLE Artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE Songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    duration_sec INT,

    FOREIGN KEY (artist_id)
        REFERENCES Artists(artist_id),

    CHECK (duration_sec > 0)
);


CREATE TABLE Hierarchies (
    hierarchy_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    parent_id INT NULL,
    name VARCHAR(100) NOT NULL,

    FOREIGN KEY (hierarchy_id)
        REFERENCES Hierarchies(hierarchy_id),

    FOREIGN KEY (parent_id)
        REFERENCES Categories(category_id)
);


CREATE TABLE SongCategories (
    song_id INT NOT NULL,
    category_id INT NOT NULL,

    PRIMARY KEY (song_id, category_id),

    FOREIGN KEY (song_id)
        REFERENCES Songs(song_id),

    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
);


CREATE TABLE SavedViews (
    view_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_a_id INT NOT NULL,
    category_b_id INT NOT NULL,

    FOREIGN KEY (category_a_id)
        REFERENCES Categories(category_id),

    FOREIGN KEY (category_b_id)
        REFERENCES Categories(category_id)
);


SHOW TABLES;


SHOW CREATE TABLE SongCategories;
SHOW CREATE TABLE SavedViews;




