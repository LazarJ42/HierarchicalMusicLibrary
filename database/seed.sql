USE hierarchical_music_library;

INSERT INTO Artists (name)
VALUES
    ('Belong'),
    ('Burial'),
    ('Yakui The Maid'),
    ('How to Disappear Completely'),
    ('Sewerslvt');
    
    SELECT * FROM Artists;


INSERT INTO Songs (artist_id, title, duration_sec)
VALUES
    (1, 'I Never Lose. Never Really', 283),
    (1, 'Remove the Inside', 359),
    (1, 'Who Told You This Room Exists?', 305),
    (2, 'Forgive', 188),
    (2, 'In McDonalds', 126),
    (2, 'State Forest', 483),
    (3, 'Side Effects of Mushroom Tea', 263),
    (3, 'Radiostalking', 227),
    (4, 'Half', 496),
    (4, 'The Wretched', 204),
    (5, 'die alone', 432),
    (5, 'MAKE-ME-SAD', 375);
    

INSERT INTO Hierarchies (name)
VALUES
    ('Genres'),
    ('Emotions');


INSERT INTO Categories (hierarchy_id, parent_id, name)
VALUES
    (1, NULL, 'Electronic'),
    (1, NULL, 'Rock'),
    (2, NULL, 'Melancholy'),
    (2, NULL, 'Nostalgia');


INSERT INTO Categories (hierarchy_id, parent_id, name)
VALUES
    (1, 1, 'Techno'),
    (1, 1, 'Ambient'),
    (1, 1, 'UK Garage'),
    (1, 2, 'Shoegaze'),
    (2, 3, 'Isolation');
    

SELECT
    c.name AS category,
    p.name AS parent_category,
    h.name AS hierarchy
FROM Categories c
LEFT JOIN Categories p
    ON c.parent_id = p.category_id
JOIN Hierarchies h
    ON c.hierarchy_id = h.hierarchy_id
ORDER BY c.hierarchy_id, c.category_id;

SELECT category_id, name FROM Categories
ORDER BY category_id;


INSERT INTO SongCategories (song_id, category_id)
VALUES
    -- Belong
    (1, 6), (1, 3),
    (2, 6), (2, 9),
    (3, 6), (3, 3),

    -- Burial
    (4, 7), (4, 3),
    (5, 7), (5, 9),
    (6, 7), (6, 4),

    -- Yakui The Maid
    (7, 5), (7, 3),
    (8, 5), (8, 4),

    -- How to Disappear Completely
    (9, 6), (9, 9),
    (10, 6), (10, 3),

    -- Sewerslvt
    (11, 5), (11, 3),
    (12, 5), (12, 9);
    
    
SELECT
    s.title AS song,
    a.name AS artist,
    c.name AS category,
    h.name AS hierarchy
FROM SongCategories sc
JOIN Songs s ON sc.song_id = s.song_id
JOIN Artists a ON s.artist_id = a.artist_id
JOIN Categories c ON sc.category_id = c.category_id
JOIN Hierarchies h ON c.hierarchy_id = h.hierarchy_id
ORDER BY s.song_id, h.name;


INSERT INTO SavedViews (name, category_a_id, category_b_id)
VALUES
    ('Melancholic Electronic', 1, 3);
    

INSERT INTO SavedViews (name, category_a_id, category_b_id)
VALUES
    ('Melancholic Techno', 5, 3);

    
SELECT * FROM SavedViews;


SELECT * FROM Categories;


SELECT * FROM Hierarchies;

SELECT * FROM SavedViews;


SELECT
    Songs.song_id,
    Songs.title,
    Artists.name AS artist,
    Songs.duration_sec
FROM Songs
JOIN Artists
    ON Songs.artist_id = Artists.artist_id
ORDER BY Songs.song_id;

