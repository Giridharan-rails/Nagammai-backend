class DivisionsController < ApplicationController
  before_action :set_division, only: [:show, :update, :destroy]
# the below method is used to disply all divisions
  # GET /divisions
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController index method"
    begin   
      @divisions = Division.all.order('div_name ASC').as_json(include: :manufacturer)
      render json: @divisions
      if @divisions.nil?
        Rails.logger.debug_log.debug { "#{"Division data not available"}"}
      end
    rescue =>e
        Rails.logger.custom_log.error { "#{e} DivisionsController index  method" }
    end
  end
# this method is used to display the selected division in show page
  # GET /divisions/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController show method"
    begin
      render json: @division.as_json(include: :manufacturer)
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController show  method" }
    end
  end
# the below method is used to create new division but we are not using this 
  # POST /divisions
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController create method"
    begin
      @division = Division.new(division_params)
      if @division.save
        render json: @division, status: :created, location: @division
      else
        Rails.logger.debug_log.debug { "#{"some problem in division creation"}"}
        render json: @division.errors, status: :unprocessable_entity
      end
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController create  method" }
    end
  end
# the below method is used to update the division
  # PATCH/PUT /divisions/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController update method"
    begin
      if @division.update(division_params)
        render json: @division
      else
        Rails.logger.debug_log.debug { "#{"some problem in division updation"}"}
        render json: @division.errors, status: :unprocessable_entity
      end
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController update  method" }
    end
  end
# the below method is used to delete the division which are deleted from wondersoft. this operation is manual
  # DELETE /divisions/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController delete method"
    begin
      @division.destroy
    rescue => e
      Rails.logger.custom_log.error { "#{e} DivisionsController destroy  method" }
    end
  end
# the below method is used to display the contact of selected division
  def division_contact
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController division_contact method"
    begin
      division=Division.find(params[:division_id]).contacts.as_json(include: :jobs_name)
      render json: division
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController division_contact  method" }
    end
  end  
# the below method is used to display the selected divisions claims
  def division_claim
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController division_claim method"
    begin
      claim=Division.find(params[:division_id]).claims
      render json: claim
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController division_contact  method" }  
    end
  end  
# this method is used to display all contact type contacts
  def division_manufacturer_supplier_contact
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController division_manufacturer_supplier_contact method" 
    begin     
        division_contacts=Contact.where(sub_contact_type: "Division",sub_contact_id: params[:division_id]).as_json(include: :jobs_name) 
        manufacturer_contacts=Contact.where(sub_contact_type: "Manufacturer",sub_contact_id: params[:division_id]).as_json(include: :jobs_name)
        #byebug
        supplier_id = Product.where(division_id: params[:division_id]).first.supplier.id
        supplier_contacts = Contact.where(sub_contact_type: "Supplier",sub_contact_id: supplier_id).as_json(include: :jobs_name)
      # division_contacts=Division.find(params[:division_id]).contacts.as_json(include: :jobs_name)
      # manufacturer_contacts=Division.find(params[:division_id]).manufacturer.contacts.as_json(include: :jobs_name)
      # supplier_contacts=Product.where(division_id: params[:division_id]).first.supplier.contacts.as_json(include: :jobs_name) if Product.where(division_id: params[:division_id]).present?
      contacts=[division_contacts,manufacturer_contacts,supplier_contacts].compact.flatten
      render json: contacts
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController division_manufacturer_supplier_contact  method" }  
    end
  end  
# this method is used to display the selected divisions all type of pending claims
  def division_claims
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController division_claims method" 
     begin
    data1, data2, data3, data4 = [], [], [], []
    #claim_no1, claim_no2, claim_no3, claim_no4 = [], [], [], []
    #FreeDiscount.where(div_code: Division.find_by(id:params["division_id"]).div_code).pluck(:claim_no)
=begin
    Product.where(division_id:params["division_id"]).map{|j|  claim_no1 << j.free_discounts.where(amount_status:nil).pluck(:claim_no).uniq if j.free_discounts.present?}
    if claim_no1.compact.flatten.present?
     claim_no1.flatten.uniq.map{|i| data1 << {"claim_no":i,"settled_amount": FreeDiscount.where(claim_no:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":FreeDiscount.where(claim_no:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":FreeDiscount.find_by(claim_no:i).ack_date}}    
    end
    
    Product.where(division_id:params["division_id"]).map{|j|  claim_no2 << j.expiry_damages.where(amount_status:nil).pluck(:claim_no).uniq if j.expiry_damages.present?}
    if claim_no2.compact.flatten.present?
      
    claim_no2.flatten.uniq.map{|i| data2 << {"claim_no":i,"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":ExpiryDamage.find_by(claim_no:i).ack_date}}  
    end
    Product.where(division_id:params["division_id"]).map{|j|  claim_no3 << j.purchase_returns.where(amount_status:nil).pluck(:claim_no).uniq if j.purchase_returns.present?}
    if claim_no3.compact.flatten.present?
    claim_no3.flatten.uniq.map{|i| data3 << {"claim_no":i,"settled_amount": PurchaseReturn.where(claim_no:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":PurchaseReturn.where(claim_no:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":PurchaseReturn.find_by(claim_no:i).claim_date}}
    end
    
    Product.where(division_id:params["division_id"]).map{|j|  claim_no4 << j.rate_changes.where(amount_status:nil).pluck(:claim_number).uniq if j.rate_changes.present?}
    if claim_no4.compact.flatten.present?
     claim_no4.flatten.uniq.map{|i| data4 << {"claim_no":i,"settled_amount": RateChange.where(claim_number:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":RateChange.where(claim_number:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":RateChange.find_by(claim_number:i).ack_date}} 
    end

=end

  claim_no=FreeDiscount.where(amount_status:nil,product_id:Division.find_by(id:params[:division_id]).products.pluck(:id)).pluck(:claim_no).uniq
 # claim_no=FreeDiscount.where(amount_status:nil,div_code: Division.find_by(id:params["division_id"]).div_code).pluck(:claim_no).uniq
  claim_no.map{|i| data1 << {"claim_no":i,"settled_amount": FreeDiscount.where(claim_no:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":FreeDiscount.where(claim_no:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":FreeDiscount.find_by(claim_no:i).ack_date}}
  
  
  claim_no=ExpiryDamage.where(amount_status:nil,product_id:Division.find_by(id:params[:division_id]).products.pluck(:id)).pluck(:claim_no).uniq
  #claim_no=ExpiryDamage.where(amount_status:nil,div_code: Division.find_by(id:params["division_id"]).div_code).pluck(:claim_no).uniq
  claim_no.map{|i| data2 << {"claim_no":i,"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":ExpiryDamage.find_by(claim_no:i).ack_date}}

  claim_no=PurchaseReturn.where(amount_status:nil,product_id:Division.find_by(id:params[:division_id]).products.pluck(:id)).pluck(:claim_no).uniq
  #claim_no=PurchaseReturn.where(amount_status:nil,div_code: Division.find_by(id:params["division_id"]).div_code).pluck(:claim_no).uniq
  claim_no.map{|i| data3 << {"claim_no":i,"settled_amount": PurchaseReturn.where(claim_no:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":PurchaseReturn.where(claim_no:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":PurchaseReturn.find_by(claim_no:i).claim_date}}
    
  claim_no=RateChange.where(amount_status:nil,div_code: Division.find_by(id:params["division_id"]).div_code).pluck(:claim_number).uniq
  claim_no.map{|i| data4 << {"claim_no":i,"settled_amount": RateChange.where(claim_number:i).pluck(:settled_amount).map(&:to_i).sum,"claim_amount":RateChange.where(claim_number:i).pluck(:claim_amount).map(&:to_i).sum,"claim_date":RateChange.find_by(claim_number:i).ack_date}}


    claim={:free=> data1,:expiry=>data2,:purchase=> data3,:rate => data4}
    if claim.present?
       render json: claim
    else
       render json: []
    end 


    rescue =>e
    Rails.logger.custom_log.error { "#{e} DivisionsController division_claims  method" }  
    end

  end
# the below method not used anywhere
  def division_manufacturer_supplier
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController division_manufacturer_supplier method" 
    begin 
     # manu_name=Division.find(params[:division_id]).manufacturer
     supplier_name=Supplier.find(params[:supplier_id])
     #render json: {supplier: supplier_name ,manufacturer: manu_name }
     render json: {supplier: supplier_name}
     #supplier=Product.where(division_id:params[:division_id]).pluck(:supplier_id).uniq
     #supplier_name=Supplier.where(id:supplier)
     #if supplier_name.present?
     #render json: {supplier: supplier_name}
     #else
     #  render json: {supplier: "No Data"}
     #end
     
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController division_manufacturer_supplier  method" }  
    end
  
  end  
# the below method is used to filter the claim issues by divisions
  def division_claim_issue 
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in DivisionsController division_claim_issue method" 
    begin
      claim=Appointment.where(:app_contact_type=>"Division",:app_contact_id=>params[:division_id])
      if claim.present?
        render json: claim.last.claim_issues.as_json(include: :contact)
      else
        render json: []
      end 
    rescue =>e
      Rails.logger.custom_log.error { "#{e} DivisionsController division_claim_issue  method" }  
    end
  end  
# this method is used to display the manufacturer filter using division
  def division_manufacturer
     manufacturer=Division.find(params[:division_id]).manufacturer
     render json: manufacturer     
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_division
      @division = Division.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def division_params
      params.require(:division).permit(:div_name,:div_code,:mfr_code,:div_abb,:address_one,:address_two,:address_three,:city,:state,:country,:manufacturer_id)
    end
end
