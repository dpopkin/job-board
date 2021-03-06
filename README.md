# README

## How it works:
- This program gets two files located in the job data directory, a `job_opportunities` CSV file and a job_board JSON file and uses Rake tasks to populate the database for both the CSV and JSON files. It can then either generate a CSV that parses the data with the rake command `import_files:generate_merged_csv` or display the job data from a front-end.
- To see front-end, navigate to `http://localhost:3000/job_boards` to see all the job boards.

## Installation
- Clone repo.
- Run `bundle install`.
- Run `rails db:migrate`.
- Run `rails import_files:import_jobs`. To initialize the job listings.
- Run `rails import_files:import_job_boards`. To initialize the job boards. It must be done in this order or it will fail, as job boards establishes the relations!
- Run `rails serve`.

## Third Party Libraries Used:
- [Bootstrap](https://getbootstrap.com/) : Used for the cards in the front-end.
- [Addressable](https://github.com/sporkmonger/addressable) : Used to parse the URLs in the rake tasks, significantly better than the standard URI library.
- [ActiveRecord Import](https://github.com/zdennis/activerecord-import) : A library that allows for bulk inserting of database entries. Meaning all the job entries are inserted into the database as one large query, saving both time and resources when running the import commands.
