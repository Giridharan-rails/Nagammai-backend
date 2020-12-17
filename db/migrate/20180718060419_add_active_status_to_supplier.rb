class AddActiveStatusToSupplier < ActiveRecord::Migration[5.1]
  def change
   add_column :suppliers, :active_status, :integer	
  end
end
