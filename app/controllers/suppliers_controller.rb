class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :update, :destroy]
# display all the supplier in index page
  # GET /suppliers
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : supplier Index"
   begin
    @suppliers = Supplier.all.order('supplier_name ASC')

    render json: @suppliers

    unless @suppliers.present?
    Rails.logger.debug_log.debug { "#{"supplier data not available"}"}
    end

    rescue => e
      Rails.logger.custom_log.error { "#{e} supplier_controller index method" }
     end
  end
# display the selected supplier
  # GET /suppliers/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in supplier show page"
  begin
    render json: @supplier

    unless @supplier.present?
    Rails.logger.debug_log.debug { "#{"supplier data not available"}"}
    end
    rescue =>e
   Rails.logger.custom_log.error { "#{e} supplier_controller show method" }
  end
  end
# create the supplier.but we are not using this
  # POST /suppliers
  def create
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the supplier create button"
    begin
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      render json: @supplier, status: :created, location: @supplier
    else
      render json: @supplier.errors, status: :unprocessable_entity
    end

    unless @supplier.present?
   Rails.logger.debug_log.debug { "#{"supplier data not available"}"}
   end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : supplier created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} supplier_controller create method" }
   end
  end
# update the selected supplier view
  # PATCH/PUT /suppliers/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the supplier update button"
    begin
    if @supplier.update(supplier_params)
      render json: @supplier
    else
      render json: @supplier.errors, status: :unprocessable_entity
    end
    unless @supplier.present?
   Rails.logger.debug_log.debug { "#{"supplier data not available"}"}
   end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : supplier Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} supplier_controller update method" }
    end
  end
# delete the selected supplier which is deleted from wondersoft
  # DELETE /suppliers/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in supplier Delete"
    begin
    @supplier.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : supplier Deleted Successfully"
    rescue =>e
     Rails.logger.custom_log.error { "#{e} supplier_controller delete method" }
    end
  end
# display the manufactuer under the selected supplier
  def supplier_manufacturer
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in supplier_manufacturer"
   begin
   #division_id = Product.where(:supplier_id=>params[:supplier_id]).pluck(:division_id) if Product.where(:supplier_id=>params[:supplier_id]).present?
   #manu_id=Division.where(:id=>division_id).pluck(:manufacturer_id) if Division.where(:id=>division_id).present?
   #manufacturer=Supplier.find(params[:supplier_id]).manufacturers
   
   #manufacturer=Manufacturer.where(:supplier_id=>params[:supplier_id])


   division_id=[]
   division_id << Product.where(:supplier_id=>params[:supplier_id]).pluck(:division_id).uniq
   @divisions=Division.where(id:division_id)

   if @divisions.present?
      render json: @divisions
   else
      render json: [{"response"=>"no data"}]
   end 
   rescue =>e
      Rails.logger.custom_log.error { "#{e} supplier_controller supplier_manufacturer method" }
   end  
  
  end
# display the contactsn which is under selectd supplier
  def supplier_contact
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in supplier_contact"
    begin
    contact = Contact.where(sub_contact_id: params[:supplier_id]).as_json(include: :jobs_name)

   #contact=Supplier.find(params[:supplier_id]).contacts.as_json(include: :jobs_name)
   render json: contact
   rescue =>e
      Rails.logger.custom_log.error { "#{e} supplier_controller supplier_contact method" }
    end
  end  
# display the claims which is under selected supplier
  def supplier_claims

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in supplier_claims"
    begin
      data1, data2, data3, data4, data5 = [], [], [], [], []
    #data1 = FreeDiscount.where(amount_status:nil,supplier_id:params[:supplier_id]).select("DISTINCT(claim_no)",:claim_amount,:settled_amount,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    #data2 = ExpiryDamage.where(amount_status:nil,supplier_id:params[:supplier_id]).select("DISTINCT(claim_no)",:claim_amount,:settled_amount,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    #data3 = PurchaseReturn.where(amount_status:nil,supplier_id:params[:supplier_id]).select("DISTINCT(claim_no)",:claim_amount,:settled_amount,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    #data4 = RateChange.where(amount_status:nil,supplier_id:params[:supplier_id]).select("DISTINCT(claim_number)",:claim_amount,:settled_amount,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    #claim=Supplier.find(params[:supplier_id]).claims1
    #claim={:free=> data1,:expiry=>data2,:purchase=> data3,:rate => data4}

  free_dis_pending_claims = FreeDiscount.where(supplier_id:params[:supplier_id]).pending_claims(nil, nil, true).fetch(:datas)
  p free_dis_pending_claims
  claim_no                = free_dis_pending_claims.pluck(:claim_no).uniq
  claim_no.map{|i| data1 << {"claim_no":i,"settled_amount": free_dis_pending_claims.where(claim_no:i).pluck(:ws_settle_amount).map(&:to_f).sum,"claim_amount": free_dis_pending_claims.where(claim_no:i).pluck(:claim_amount).map(&:to_f).sum,"claim_date": free_dis_pending_claims.find_by(claim_no:i).ack_date}}

  exp_dam_pending_claims = ExpiryDamage.where(supplier_id:params[:supplier_id]).pending_claims(nil, nil, true).fetch(:datas)
  claim_no                = exp_dam_pending_claims.pluck(:claim_no).uniq
  claim_no.map{|i| data2 << {"claim_no":i,"settled_amount": exp_dam_pending_claims.where(claim_no:i).pluck(:ws_settle_amount).map(&:to_f).sum,"claim_amount":exp_dam_pending_claims.where(claim_no:i).pluck(:claim_amount).map(&:to_f).sum,"claim_date":exp_dam_pending_claims.find_by(claim_no:i).ack_date}}

  pur_retr_pending_claims = PurchaseReturn.where(supplier_id:params[:supplier_id]).pending_claims(nil, nil, true).fetch(:datas)
  claim_no                = pur_retr_pending_claims.pluck(:claim_no).uniq
  claim_no.map{|i| data3 << {"claim_no":i,"settled_amount": pur_retr_pending_claims.where(claim_no:i).pluck(:ws_settle_amount).map(&:to_f).sum,"claim_amount": pur_retr_pending_claims.where(claim_no:i).pluck(:claim_amount).map(&:to_f).sum,"claim_date": pur_retr_pending_claims.find_by(claim_no:i).claim_date}}
    
  rate_chg_pending_claims = RateChange.where(supplier_id:params[:supplier_id]).pending_claims(nil, nil, true).fetch(:datas)
  claim_no                = rate_chg_pending_claims.pluck(:claim_number).uniq
  claim_no.map{|i| data4 << {"claim_no":i,"settled_amount": rate_chg_pending_claims.where(claim_number:i).pluck(:ws_settle_amount).map(&:to_f).sum,"claim_amount": rate_chg_pending_claims.where(claim_number:i).pluck(:claim_amount).map(&:to_f).sum,"claim_date": rate_chg_pending_claims.find_by(claim_number:i).ack_date}}

  non_find_pending_claims = NonFindableClaim.where(supplier_id:params[:supplier_id]).pending_claims(nil, nil, true).fetch(:datas)
  claim_no                = non_find_pending_claims.pluck(:claim_no).uniq
  claim_no.map{|i| data5 << {"claim_no":i,"settled_amount": non_find_pending_claims.where(claim_no:i).pluck(:ws_settle_amount).map(&:to_f).sum,"claim_amount": non_find_pending_claims.where(claim_no:i).pluck(:claim_amount).map(&:to_f).sum,"claim_date": non_find_pending_claims.find_by(claim_no:i).ack_date}}

  claim={:free=> data1,:expiry=>data2,:purchase=> data3,:rate => data4, :non_findable => data5}  
   if claim.present?
    render json: claim
   else
    render json: []
   end 
   rescue =>e
      Rails.logger.custom_log.error { "#{e} supplier_controller supplier_claims method" }
    end
  end 
# fileter the claim issue by selected supplier
  def supplier_claim_issue 
    begin
      claim=Appointment.where(:app_contact_type=>"Supplier",:app_contact_id=>params[:supplier_id])
          if claim.present?
             render json: claim.last.claim_issues.as_json(include: :contact)
          else
             render json: []

          end 

    rescue =>e
      Rails.logger.custom_log.error { "#{e} supplier_controller supplier_claim_issue method" }
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def supplier_params
      params.require(:supplier).permit(:supplier_name, :supplier_code, :supplier_abb, :address_one, :addrsss_two, :addrsss_three, :gst_no, :order_copy_format, :phone_number, :city, :state, :country, :batch,:active_status)
    end
end
