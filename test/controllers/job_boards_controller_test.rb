require "test_helper"

class JobBoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_board = job_boards(:lagged)
  end

  test "should get index" do
    get job_boards_url
    assert_response :success
  end

  test "should show job_board" do
    get job_board_url(@job_board)
    assert_response :success
  end
end
