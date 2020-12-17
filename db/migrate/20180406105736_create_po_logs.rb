class CreatePoLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :po_logs do |t|
      t.string :po_no
      t.string :desc
      t.string :reason

      t.timestamps
    end
  end
end
