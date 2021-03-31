require "application_system_test_case"

class JobBoardsTest < ApplicationSystemTestCase
  setup do
    @job_board = job_boards(:lagged)
  end

  test "can view job board" do
    visit job_boards_url
    assert_selector "h1", text: "Job Boards"
  end

  test "can visit table of job board" do
    visit job_board_url(JobBoard.first)
    assert_selector "h1", text: "Job Board"
  end

  test "table of job board is populated" do
    # Relation with job board is established through minitest fixture.
    # See: https://guides.rubyonrails.org/testing.html#the-low-down-on-fixtures
    @job = jobs(:one)
    visit job_board_url(JobBoard.first)
    assert_text @job.job_title
  end

end
