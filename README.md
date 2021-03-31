# README

## How it works:
- This program works by using Rake tasks to populate the database for both the CSV and JSON files. Using a Rake task allows for easy use under a cron-esque task scheduler.
- The front end uses the job_board route entirely `http://localhost:3000/job_boards` and uses a show for all the jobs `http://localhost:3000/job_boards/{id}`. The front-end lets you click on the card to display all jobs on the item.

## Files and folders to look at:
- `lib/tasks/import_csv_into_db.rake` : The main tasks that allow importing into both databases and creating the CSV with the jobs.
- `job_data` : Folder where the CSV and JSON files are stored and where the new CSV is. The new CSV is located there and will be created in that folder under the name: `merged_job_opportunities.csv`.
- `app/controllers/job_boards_controller.rb`: The back-end logic to get the job boards and what jobs are open from which boards. This follows a typical resource route.
- `app/models/job_board.rb` : The job board model.
- `app/models/job.rb` : The job model. Can optionally belong to the job board.
- `tests/controllers/job_boards_controller_test.rb`: Basic unit test to ensure the front end responses are working.
- `tests/rake/import_expor_files_test.rb`: Unit tests for the rake tasks (importing CSV, importing JSON and exporting CSV).
- `tests/system/job_boards_test`: Tests to make sure the front end renders as expected and will also display matching jobs with the board.

## Third Party Libraries:
- [Bootstrap](https://getbootstrap.com/) : Used for the cards in the front-end.
- [Addressable](https://github.com/sporkmonger/addressable) : Used to parse the URLs in the rake tasks, significantly better than the standard URI library.
- [ActiveRecord Import](https://github.com/zdennis/activerecord-import) : A library that allows for bulk inserting of database entries. Meaning the 20K entries for jobs are inserted into the database as one large query, saving both time and resources when running the import commands.

## Total Job Board Count:
- Obtained using the following code:
<code> JobBoard.find_each do |board|
<br/> puts board.name + ": " + board.jobs.count.to_s
 end </code>
- LinkedIn: 6612
- Glassdoor: 298
- Angel: 120
- Google: 160
- Dribble: 0
- Indeed: 903
- Triplebyte: 13
- Hired: 0
- Wayup: 0
- Ycombinator: 0
- Work at a startup: 4
- jopwell: 0
- Tech Ladies: 2
- Intern Supply: 0
- Underdog: 0
- Stealla: 0
- Ziprecuriter: 66
- Simplyhired: 27
- Gamasutra: 0
- Huntr Jobs: 0
- Lever: 2673
- Greenhouse: 3040
- Monster: 4
- Github: 0
- Stackoverflow Jobs: 2
- Employbl: 0
- Who Is Hiring: 0
- Jobvite: 382
- Smartrecruiters: 69
- Government Jobs: 1