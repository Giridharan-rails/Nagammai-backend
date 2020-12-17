class CreateCfaTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :cfa_titles do |t|
      t.string :job_name

      t.timestamps
    end
  end
end
