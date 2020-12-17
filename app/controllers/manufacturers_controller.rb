class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show, :update, :destroy]
# the below method is used to display the all manufacturer in index pafe
  # GET /manufacturers
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturers Index"
   begin
     @manufacturers = Manufacturer.all.order('manufacturer_name ASC')

    render json: @manufacturers
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturers_controller index method" }
     end
  end
# this method is used to display the selected manufacturer details
  # GET /manufacturers/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in manufacturers show page"
  begin
    render json: @manufacturer
    rescue =>e
   Rails.logger.custom_log.error { "#{e} manufacturers_controller show method" }
  end
  end
#we are not using this method becz we are only sync
  # POST /manufacturers
  def create
   
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the manufacturers create button"
    begin

    @manufacturer = Manufacturer.new(manufacturer_params)

    if @manufacturer.save
      render json: @manufacturer, status: :created, location: @manufacturer
    else
      render json: @manufacturer.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturers created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} manufacturers_controller create method" }
   end
  end
# this method us used to update the manufacturer
  # PATCH/PUT /manufacturers/1
  def update

     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the manufacturers update button"
    begin
    if @manufacturer.update(manufacturer_params)
      render json: @manufacturer
    else
      render json: @manufacturer.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturers Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} manufacturers_controller update method" }
    end
  end
#the below method is used to delete the manufacturer which is deleted from wonder soft
  # DELETE /manufacturers/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in manufacturers Delete"
    begin
    @manufacturer.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturers Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} manufacturers_controller delete method" }
    end
  end
#the below method is used to display the division by selected manufacturer
  def manufacturer_division
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in manufacturers manufacturer_division"
    begin
   division=Division.where(:manufacturer_id=>params[:manufacturer_id])
   if division.present?
     render json: division
   else
    render json: [{"response"=>"no data"}]
   end  
  # Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : supplier Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} manufacturers_controller manufacturer_division method" }
    end
  end  
# the below method is used to display the contacts of selected manufacturer
  def manufacturer_contact
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in manufacturers manufacturer_contact"
    begin
   manufacturer=Manufacturer.find(params[:manufacturer_id]).contacts.as_json(include: :jobs_name) if Manufacturer.find(params[:manufacturer_id]).present?
   render json: manufacturer
   rescue =>e
      Rails.logger.custom_log.error { "#{e} manufacturers_controller manufacturer_contact method" }
    end
  end  
# the below method is used to display the products which under selected manufacturer
  def manufacturer_supplier_contact
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in manufacturers manufacturer_supplier_contact"
    begin
   id1=Manufacturer.find(params[:manufacturer_id]).divisions.first.products.first.supplier.contacts if Manufacturer.find(params[:manufacturer_id]).divisions.first.products.present?
   id2=Manufacturer.find(params[:manufacturer_id]).contacts
   if Manufacturer.find(params[:manufacturer_id]).divisions.present?
      div_id=Manufacturer.find(params[:manufacturer_id]).divisions.ids 
      id3=Contact.where(sub_contact_type: "Division", sub_contact_id: div_id)
   end
   contacts=[id1,id2,id3].compact.flatten
   render json: contacts
   rescue =>e
      Rails.logger.custom_log.error { "#{e} manufacturers_controller manufacturer_supplier_contact method" }
    end
  end  
#the below method is used to display the selected manufacturer pending claims
  def manufacturer_claims
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in manufacturers manufacturer_claims"
    begin
   claim = Manufacturer.find(params[:manufacturer_id]).divisions.first.products.first.supplier.claims
   if claim.present?
    render json: claim
   else
    render json: []
   end 
   rescue =>e
      Rails.logger.custom_log.error { "#{e} manufacturers_controller manufacturer_claims method" }
    end
  end  
# this method is used to display the selected manufacturers claims
  def manufacturer_claim_issue 
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in manufacturers manufacturer_claim_issue"
    
      claim=Appointment.where(:app_contact_type=>"Manufacturer",:app_contact_id=>params[:manufacturer_id])
          if claim.present?
             render json: claim.last.claim_issues.as_json(include: :contact)
          else
             render json: []
          end 
          rescue =>e
      Rails.logger.custom_log.error { "#{e} manufacturers_controller manufacturer_claims_issue method" }
    end
# display the selected suppliers manufacturer by products but we are not using it
 def supplier_manufacturer
    # divisions=Product.where(supplier_id:params["supplier_id"]).pluck(:division_id).uniq
    #manufacturer=Division.where(id:divisions).pluck(:manufacturer_id).uniq
    supplier_manufacturer=Manufacturer.where(supplier_id:params[:supplier_id]) 
    render json: supplier_manufacturer
  end
#display the supplir by selected manufacturer
def manufacturer_supplier
    supplier=Manufacturer.find(params[:manufacturer_id]).supplier
    
    render json: supplier
  end
# this method is to display the manufacturer by supplier
  def manufacturer_base_manufacturers
  manus=Manufacturer.where(:supplier_id=>Manufacturer.find(params[:manufacturer_id]).supplier_id)
  if manus.present?
     render json: manus
   else
    render json: [{"response"=>"no data"}]
   end  
end  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def manufacturer_params
      params.require(:manufacturer).permit(:manufacturer_name,:manufacturer_code,:manufacturer_abb,:address_one,:addrsss_two,:addrsss_three,:city,:state,:country,:supplier_id)
    end
end
