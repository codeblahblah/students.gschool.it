class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :resume, null: false
      t.string :cover_letter
      t.references :user
      t.references :job_opportunity

      t.timestamps
    end
  end
end
