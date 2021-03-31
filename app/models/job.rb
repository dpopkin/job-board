class Job < ApplicationRecord
    belongs_to :job_board, optional: true
end
