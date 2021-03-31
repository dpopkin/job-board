class JobBoardsController < ApplicationController
  before_action :set_job_board, only: %i[ show edit update destroy ]

  # GET /job_boards or /job_boards.json
  def index
    @job_boards = JobBoard.all
  end

  # GET /job_boards/1 or /job_boards/1.json
  def show
    job_board = JobBoard.find(params[:id])
    # Relationship is needed, buts let's see if we can do it without one for now.
    @jobs = job_board.jobs
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_board
      @job_board = JobBoard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_board_params
      params.require(:job_board).permit(:name, :rating, :root_domain, :logo_location, :description)
    end
end
