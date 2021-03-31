namespace :import_files do
  require 'csv'
  require 'addressable/uri'

  desc 'This imports the job opportunites into the SQLite database'
  task import_jobs: :environment do
    jobs = []
    CSV.foreach('job_data/job_opportunities.csv', headers: true) do |row|
      jobs << Job.new(job_title: row['Job Title'], company_name: row['Company Name'], job_url: row['Job URL'])
    end
    Job.import jobs
  end

  desc 'This imports the job boards that will be used by both the CSV and application into the SQLite database. Also establishes relationships'
  task import_job_boards: :environment do
    boards = []
    file_data = JSON.load_file('job_data/jobBoards.json')
    file_data['job_boards'].each do |board|
      boards << JobBoard.new(
        name: board['name'],
        rating: board['rating'],
        root_domain: board['root_domain'],
        logo_location: board['logo_file'],
        description: board['description']
      )
    end
    JobBoard.import boards

    # Establish relation with jobs.
    JobBoard.all.each do |board|
      Job.where('job_url like ?', '%' + board.root_domain + '%').each do |job|
        job.update(job_board_id: board.id)
      end
    end

  end

  desc 'This generates the CSV that combines the job and job boards with the other edge cases in the instructions'
  task generate_merged_csv: :environment do
    # Const array for easy reuse.
    COLUMNS = ['ID (primary key)', 'Job Title', 'Company Name', 'Job URL', 'Job Source'].freeze
    # This is a potential problem if the amount of boards gets too large. But it should work for this use case.
    job_board = JobBoard.all
    CSV.open('job_data/merged_job_opportunities.csv', 'wb') do |csv|
      csv << [COLUMNS[0], COLUMNS[1], COLUMNS[2], COLUMNS[4], COLUMNS[3]]
      # At least 20K jobs? Yeah, we should be chunking queries.
      Job.find_each do |job|
        # Check if valid URI. The Adressable Gem covers significanly more of the edge cases in the CSV
        # as long as we catch them.
        begin
          parse_link = Addressable::URI.parse(job.job_url)
        rescue Addressable::URI::InvalidURIError
          # As of this writing, Visual Studio Code appears to have a bug where it doesn't correctly parse
          # that the Job Source comes after the URL. Hence why it's before the URL in the CSV.
          csv << [job.id, job.job_title, job.company_name, 'Unknown', job.job_url]
          next
        end
        # Last two edge cases.
        if parse_link.nil? || parse_link.domain.nil?
          csv << [job.id, job.job_title, job.company_name, 'Unknown', job.job_url]
          next
        end
        main_domain = parse_link.domain.split('.')[0]

        if !job.job_board_id.nil?
          csv << [job.id, job.job_title, job.company_name, job.job_board.name, job.job_url]
          # TODO: Find something better. This has more than a few edge cases.
        elsif main_domain.include?(job.company_name.downcase.delete(' ')) || job.company_name.downcase.include?(main_domain)
          csv << [job.id, job.job_title, job.company_name, 'Company Website', job.job_url]
        else
          csv << [job.id, job.job_title, job.company_name, 'Unknown', job.job_url]
        end
      end
    end
  end
end
