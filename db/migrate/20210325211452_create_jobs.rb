class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :job_title
      t.string :company_name
      t.string :job_url
      t.belongs_to :job_board

      t.timestamps
    end
  end
end
