json.extract! job_board, :id, :name, :rating, :root_domain, :logo_location, :description, :created_at, :updated_at
json.url job_board_url(job_board, format: :json)
