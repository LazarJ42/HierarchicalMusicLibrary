USE hierarchical_music_library;


-- Query 1: Retrieve a category and all its descendants

WITH RECURSIVE CategoryTree AS (
    SELECT category_id, name, parent_id
    FROM Categories
    WHERE category_id = 1

    UNION ALL

    SELECT c.category_id, c.name, c.parent_id
    FROM Categories c
    JOIN CategoryTree ct
        ON c.parent_id = ct.category_id
)
SELECT *
FROM CategoryTree;


-- Query 2: Retrieve all songs in a category branch

WITH RECURSIVE CategoryTree AS (
    SELECT category_id
    FROM Categories
    WHERE category_id = 1

    UNION ALL

    SELECT c.category_id
    FROM Categories c
    JOIN CategoryTree ct
        ON c.parent_id = ct.category_id
)
SELECT DISTINCT
    s.song_id,
    s.title,
    a.name AS artist
FROM CategoryTree ct
JOIN SongCategories sc
    ON ct.category_id = sc.category_id
JOIN Songs s
    ON sc.song_id = s.song_id
JOIN Artists a
    ON s.artist_id = a.artist_id
ORDER BY s.song_id;

SELECT * FROM SavedViews;


-- Query 3: Find songs matching both branches of a saved view

WITH RECURSIVE CategoryBranches AS (
    -- Start with both categories in the saved view
    SELECT
        sv.category_a_id AS category_id,
        'A' AS branch
    FROM SavedViews sv
    WHERE sv.view_id = 3

    UNION ALL

    SELECT
        sv.category_b_id,
        'B'
    FROM SavedViews sv
    WHERE sv.view_id = 3

    UNION ALL

    -- Recursively find descendants of both branches
    SELECT
        c.category_id,
        cb.branch
    FROM Categories c
    JOIN CategoryBranches cb
        ON c.parent_id = cb.category_id
)
SELECT
    s.song_id,
    s.title,
    a.name AS artist
FROM Songs s
JOIN Artists a
    ON s.artist_id = a.artist_id
JOIN SongCategories sc
    ON s.song_id = sc.song_id
JOIN CategoryBranches cb
    ON sc.category_id = cb.category_id
GROUP BY s.song_id, s.title, a.name
HAVING COUNT(DISTINCT cb.branch) = 2
ORDER BY s.song_id;


INSERT INTO SavedViews (name, category_a_id, category_b_id)
VALUES
    ('Isolated Ambient', 6, 9);



-- Query 4: Count distinct songs in each hierarchy

SELECT
    h.name AS hierarchy,
    COUNT(DISTINCT sc.song_id) AS song_count
FROM Hierarchies h
LEFT JOIN Categories c
    ON h.hierarchy_id = c.hierarchy_id
LEFT JOIN SongCategories sc
    ON c.category_id = sc.category_id
GROUP BY h.hierarchy_id, h.name
ORDER BY h.name;


-- Query 5: Find songs without category assignments

SELECT
    s.song_id,
    s.title,
    a.name AS artist
FROM Songs s
JOIN Artists a
    ON s.artist_id = a.artist_id
WHERE NOT EXISTS (
    SELECT 1
    FROM SongCategories sc
    WHERE sc.song_id = s.song_id
);



