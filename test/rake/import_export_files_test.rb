require "test_helper"
require "csv"
require "rake"
require "minitest/autorun"

class JobBoardTest < ActiveSupport::TestCase
  setup do
      # Load rake tasks so they can be tested.
      TakeHome::Application.load_tasks if Rake::Task.tasks.empty?
  end
  
  test "CSV can be parsed" do
    # Preestablished fixtures have this set at two
    count = Job.count
    csv = CSV.read("test/rake/files/jobs.csv", headers: true)
    # Second argument is needed to yield the CSV data to the rake task.
    # See: https://stackoverflow.com/a/28376995
    CSV.stub :foreach, "something", csv do
        Rake::Task["import_files:import_jobs"].invoke
    end
    assert Job.count == count + 1 
  end

  test "JSON can be parsed" do
    count = JobBoard.count
    file_data = JSON.load_file('test/rake/files/jobBoards.json')
    JSON.stub :load_file, file_data do
        Rake::Task["import_files:import_job_boards"].invoke 
    end
    assert JobBoard.count == count + 1 
  end

  test "Merged CSV can be created" do
    CSV.stub :open, "something", CSV.open('test/rake/files/merged_job_opportunities.csv', 'wb') do
        Rake::Task["import_files:generate_merged_csv"].invoke
    end
  end
end