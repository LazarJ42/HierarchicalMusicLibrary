# Hierarchical Music Library

A database-backed music library application that organizes songs using multiple category hierarchies instead of traditional playlists.

## Project Overview

Users will be able to organize songs under nested categories, browse songs within a category and its descendants, and create saved views combining two category branches.

## Technology Stack

- MySQL
- Node.js / Express (planned backend)
- React (planned frontend)

## Current Progress

- Six-table MySQL schema implemented
- Sample artists, songs, and category hierarchies inserted
- Five SQL queries implemented and tested
- Recursive category traversal and saved-view filtering verified

## Database Setup

1. Open MySQL Workbench
2. Run `database/schema.sql` to create the database and tables.
3. Run `database/seed.sql` to insert sample records.
4. Run `database/demo_queries.sql` to execute the demo queries.

Run the schema and seed scripts only once on an empty database.

## Next Steps

- Implement the Express backend and database connection.
- Add API endpoints for songs and categories.
- Implement server-side validation and category-tree business rules.
- Develop a basic React interface.
- Test the complete database backed workflow.