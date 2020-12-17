class CreateWonderSofts < ActiveRecord::Migration[5.1]
  def change
    create_table :wonder_softs do |t|
      t.string :user_name
      t.string :password
      t.string :database_name
      t.string :server_name

      t.timestamps
    end
  end
end
