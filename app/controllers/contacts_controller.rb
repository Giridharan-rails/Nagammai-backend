class ContactsController < ApplicationController
  require 'csv'
  before_action :set_contact, only: [:show, :update, :destroy]
#the below method is used to display the contacts  in contact index page
  # GET /contacts
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in contacts_controller index method"
    begin   
      @contacts = Contact.includes(:sub_contact, :jobs_name).order('name ASC').as_json(include: [:sub_contact,:jobs_name])
      render json: @contacts
      if @contacts.nil?
        Rails.logger.debug_log.debug { "#{"contact data not available"}"}
      end
    rescue =>e
      Rails.logger.custom_log.error { "#{e} contacts_controller index  method" }
    end  
  end
# the below method is used to display the selected contact in show page
  # GET /contacts/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims show method"
    begin
      render json: @contact
      if @contact.nil?
        Rails.logger.debug_log.debug { "#{"claims may be not available otherwise check backend"}"}
      end
    rescue =>e
      Rails.logger.custom_log.error { "#{e} claims_controller show method" }
    end 
  end
#the below method is used to create new contact
  # POST /contacts
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the contacts create button"
    begin
      @contact = Contact.new(contact_params)
      if @contact.save
        render json: @contact, status: :created, location: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
      Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : contact created successfully"
    rescue =>e
      Rails.logger.custom_log.error { "#{e} contacts_controller create method" }
    end 
  end
# the below method is used to update the contacts
  # PATCH/PUT /contacts/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the claims update button"
    begin
      if @contact.update(contact_params)
        render json: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
      Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claims Updated successfully"
    rescue =>e
      Rails.logger.custom_log.error { "#{e} claims_controller update method" }
    end
  end
# the below method to delete the contact
  # DELETE /contacts/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in contact Delete"
    begin
      @contact.destroy
      Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : contact Deleted Successfully"
    rescue =>e
      Rails.logger.custom_log.error { "#{e} contacts_controller destroy method" }
    end
  end
# the below method is used to upload the bulk contacts through csv file
  def file_upload
    data=[]
      file_data=CSV.read(params["file"].tempfile)
        file_data.shift
            file_data.each do |a|
          if a[4]=="CFATITLE"
          a[4]= "CfaTitle"
          a[5]=CfaTitle.find_or_create_by(job_name:a[5]).id
          elsif  a[4]=="MARKETINGTITLE"
          a[4]= "MarketingTitle"
          a[5]=MarketingTitle.find_or_create_by(job_name:a[5]).id
          end
          if a[6]=="DIVISION"
          a[6]="Division"
          a[7]=Division.find_by(div_code:a[7]).id
          elsif a[6]=="MANUFACTURER"
          a[6]="Manufacturer"
          a[7]=Manufcaturer.find_by(manufacturer_code:a[7]).id
          elsif  a[6]=="SUPPLIER"
          a[6]="Supplier"
          a[7]=Supplier.find_by(supplier_code:a[7]).id
          end
          mail_allocations = []
          mail_allocations << "purchase_order" if a[8]=="1"
          mail_allocations << "non_moving_stock" if a[9]=="1"
          mail_allocations << "rate_change" if a[10]=="1"
          mail_allocations << "free_and_discounts" if a[11]=="1"
          mail_allocations << "expiry" if a[12]=="1"
          mail_allocations << "purchase_return" if a[13]=="1"
          mail_allocations << "other_claim" if a[14]=="1"
          @contact=Contact.new(name:a[0],email:a[1],phone_number:a[2],address:a[3],jobs_name_type:a[4],jobs_name_id:a[5],sub_contact_type:a[6],sub_contact_id:a[7],
            mail_allocation: mail_allocations.join(','))
          if @contact.save
             data << @contact.id
          else
            data << @contact.errors
          end

  end
  return data
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone_number, :address, :jobs_name_type, :jobs_name_id, :sub_contact_type, :sub_contact_id, :mail_allocation)
    end
end
