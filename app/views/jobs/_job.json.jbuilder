json.extract! job, :id, :job_title, :company_name, :job_url, :created_at, :updated_at
json.url job_url(job, format: :json)
