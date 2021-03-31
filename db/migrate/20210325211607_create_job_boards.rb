class CreateJobBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :job_boards do |t|
      t.string :name
      t.string :rating
      t.string :root_domain, uniqueness: true
      t.string :logo_location
      t.string :description

      t.timestamps
    end
  end
end
