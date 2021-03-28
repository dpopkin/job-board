class Job < ApplicationRecord
    belongs_to :JobBoard, optional: true
end
