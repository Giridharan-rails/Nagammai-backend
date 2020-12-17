class AddReferenceToPogrMismatch < ActiveRecord::Migration[5.1]
  def change
add_reference :pogr_mismatches, :supplier, foreign_key: true, index: true
add_reference :pogr_mismatches, :product, foreign_key: true, index: true
add_column :pogr_mismatches, :grn_no_dummy ,:string
add_column :pogr_mismatches, :po_no_dummy ,:string
  end
end
