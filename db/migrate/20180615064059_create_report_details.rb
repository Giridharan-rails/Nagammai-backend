class CreateReportDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :report_details do |t|
		t.string :purchase_order_count 
		t.string :purchase_order_reason
		t.string :purchase_order_email_reason

		t.string :expiry_broken_count 
		t.string :expiry_broken_reason
		t.string :expiry_broken_email_reason

		t.string :free_discount_count 
		t.string :free_discount_reason
		t.string :free_discount_email_reason

		t.string :purchase_return_count 
		t.string :purchase_return_reason
		t.string :purchase_return_email_reason

		t.string :rate_change_count 
		t.string :rate_change_reason
		t.string :rate_change_email_reason

		t.string :excess_stock_count 
		t.string :excess_stock_reason
		t.string :excess_stock_email_reason

		t.string :pogr_count 
		t.string :pogr_reason
		t.string :pogr_email_reason

		t.string :appointment_count 
		t.string :appointment_reason
		t.string :appointment_email_reason

		t.string :claim_issue_count 
		t.string :claim_issue_reason
		t.string :claim_issue_email_reason

		t.string :inbox_count 
		t.string :inbox_reason
		t.string :inbox_email_reason

		t.string :non_findable_claim_count 
		t.string :non_findable_claim_reason
		t.string :non_findable_claim_email_reason

		t.date :report_date
      t.timestamps
    end
  end
end
