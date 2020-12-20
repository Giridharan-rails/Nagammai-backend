Rails.application.routes.draw do


  resources :tasks
  post 'claims/edit_reports'
  get 'appointments/shedular_job'
  get 'send_mails/selectall_claims'  
  post 'contacts/file_upload'
  get 'send_mails/supplier_man_div_filter'
  get 'send_mails/excess_stock_date_filter'
  get 'send_mails/excess_stock_report'
  get 'send_mails/today_adjustment_date_filter'
  get 'send_mails/settled_claims_datewise_filter'
   get 'send_mails/pending_claims_datewise_filter'
   get 'claims/status_filter'
   get 'send_mails/adjusment_preview'
   get 'send_mails/today_adjustment_claims'
   get 'claims/rate_change_claims'
   get 'claims/non_findable_claims'
   get 'claims/purchase_return_claims'
   get 'claims/free_discount_claims'
   get 'claims/expiry_damage_claims'
   post 'claims/rate_change_update'
   get 'send_mails/pending_claims_report'
   get 'send_mails/settled_claims_report'
   post 'claims/free_discount_update'

  get 'claims/rate_change_claim_no'
  get 'claims/free_discount_claim_no'
  post 'claims/expiry_damage_update'
  get 'claims/purchase_return_adjusments'
  get 'claims/status_filter'
  post 'claims/purchase_return_update'

 get 'users/change_password'
 get 'users/dashboard'
 get 'claims/expiry_damage_claim_no'
  resources :adjustments
  resources :goods_received_notes
  get 'send_mails/purchase_order_report'
  get 'send_mails/datewisefilter'
  get 'send_mails/datadelete'
  get 'appointments/pending_appointment'
  get 'manufacturers/manufacturer_base_manufacturers'
  get 'claims/approved_claims_filter'
  get'claims/approved_claims'  
  get 'appointments/appoint_filter'
  get 'divisions/division_manufacturer'
  get 'manufacturers/manufacturer_supplier'
  get 'claims/datewise_filter_claim'
  get 'appointments/division_appointment_issue'
  get 'appointments/manufacturer_appointment_issue'
  get 'appointments/appointment_pending_claims'
  get 'appointments/supplier_histroy'
  get 'manufacturers/supplier_manufacturer'
  get 'send_mails/po_emails'
  get 'send_mails/pogr_emails'
 get 'send_mails/purchase_return_emails'
 get 'send_mails/expiry_damage_emails'
 get 'send_mails/rate_change_emails'
 get 'send_mails/free_discount_emails'

  get 'send_mails/email_notification'
  post 'products/purchase_goods_receipt'
  get 'products/purchase_order_all'
  get 'claims/datewise_close_claim'
  get 'claims/status_close'
  get 'suppliers/supplier_claim_issue'
  get 'manufacturers/manufacturer_claim_issue'
  get 'divisions/division_claim_issue'
  get 'claims/datewise_settled_claims'
  get 'claims/settled_claims'
  get 'divisions/division_manufacturer_supplier'
  get 'divisions/division_claims'
  get 'manufacturers/manufacturer_claims'
  get 'suppliers/supplier_claims'
  get 'claims/claim_date_report'
  get 'claims/pending_claim'
  get 'divisions/division_manufacturer_supplier_contact'
  get 'manufacturers/manufacturer_supplier_contact'
  get 'sops/dynamic_sop'
  post 'sops/issues_update'
  post 'claims/date_report'
  get 'goods_receipts/compare_order_no'  
  get 'manufacturers/manufacturer_division'
  get 'suppliers/supplier_manufacturer'
  get 'suppliers/supplier_contact'
  get 'manufacturers/manufacturer_contact'
  get 'divisions/division_contact'
  post 'users/supplier_update'
  post 'users/login'
  get 'divisions/division_claim'
  get 'type_of_claims/claim_all'
  get 'appointments/claim_issues'
  post 'sync_settings/wondersoft_connection'
  put 'sync_settings/wondersoft_connection_update'
   get 'sync_settings/wondersoft_connection_data'

post 'sync_settings/nagammai_connection'
  put 'sync_settings/nagammai_connection_update'
   get 'sync_settings/nagammai_connection_data'

  get 'appointments/appointment_index'
  post 'sync_settings/sync_setting_update'
  post 'appointments/appointment_update'
  post 'send_mails/sendmails_update'
  post 'receive_mails/receivemails_update'
  post 'claims/claim_update'
  get 'claims/claim_index'
  post 'goods_receipts/date_filter'
   post 'goods_receipt_notes/date_filter'
  get 'send_mails/get_purchase_order'
    get 'send_mails/get_pogr'
  
  get 'emails/unassigned_data'
  post 'send_mails/purchase_assign'
  post 'send_mails/pogr_assign'
    get 'send_mails/excess_stock_assign'
  post 'send_mails/excess_stock_assign_update'
  post 'send_mails/freeanddiscount_assign'
post 'send_mails/expiryanddamage_assign'
post 'send_mails/ratechange_assign'
post 'send_mails/purchasereturn_assign'

  get 'emails/suppliers_list'
  get 'products/division_product_view'
  get 'appointments/issue_for_alert'
  get 'appointments/appointment_for_alert'
  get 'appointments/contacts_for_alert'
  get 'claims/discounts'
  get 'claims/data_report'
  get 'claims/rates'
  get 'claims/expiry_damages'
   get 'claims/purchase_returns'
  get 'purchase_order'=> 'send_mails#purchase_order'
   get 'pogr_mismatch_items'=> 'send_mails#pogr_mismatch_items'
  get 'discount_claim'=>'claims#discount_claim'
  get 'rate_claim'=>'claims#rate_claim'
  get 'expiry_claim' =>'claims#expiry_claim'
  get 'purchasereturn_claim' =>'claims#purchasereturn_claim'
post 'pogr_syns/pogr_mismatch'
  resources :pogr_syns
  resources :claim_syns
  resources :po_syns
  resources :division_syns
  resources :manufacturer_syns
  resources :supplier_syns
  resources :emails
  resources :goods_receipts
  resources :claims
  resources :receive_mails
  resources :send_mails
  resources :sync_settings
  resources :appointments
  resources :cfa_titles
  resources :marketing_titles
  resources :payment_terms
  resources :products
  resources :sops
  resources :contacts
  resources :divisions
  resources :manufacturers
  resources :users
  resources :suppliers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
