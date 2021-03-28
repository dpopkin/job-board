require "application_system_test_case"

class JobBoardsTest < ApplicationSystemTestCase
  setup do
    @job_board = job_boards(:one)
  end

  test "visiting the index" do
    visit job_boards_url
    assert_selector "h1", text: "Job Boards"
  end

  test "creating a Job board" do
    visit job_boards_url
    click_on "New Job Board"

    fill_in "Description", with: @job_board.description
    fill_in "Logo location", with: @job_board.logo_location
    fill_in "Name", with: @job_board.name
    fill_in "Rating", with: @job_board.rating
    fill_in "Root domain", with: @job_board.root_domain
    click_on "Create Job board"

    assert_text "Job board was successfully created"
    click_on "Back"
  end

  test "updating a Job board" do
    visit job_boards_url
    click_on "Edit", match: :first

    fill_in "Description", with: @job_board.description
    fill_in "Logo location", with: @job_board.logo_location
    fill_in "Name", with: @job_board.name
    fill_in "Rating", with: @job_board.rating
    fill_in "Root domain", with: @job_board.root_domain
    click_on "Update Job board"

    assert_text "Job board was successfully updated"
    click_on "Back"
  end

  test "destroying a Job board" do
    visit job_boards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job board was successfully destroyed"
  end
end
