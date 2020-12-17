class AddFieldsToMaster < ActiveRecord::Migration[5.1]
  def change

	add_column :suppliers, :old_id ,:string
	add_column :manufacturers, :old_id ,:string
	add_column :divisions, :old_id ,:string
        add_column :products, :old_id ,:string
end
end
