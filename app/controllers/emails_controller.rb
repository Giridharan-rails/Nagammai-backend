class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :update, :destroy]


# the below method is used to diosplay all the emails
  # GET /emails
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in EmailsController index method"
    begin
      @emails = Email.where(:supplier_id=>nil)
      if @emails.nil?
        Rails.logger.debug_log.debug { "#{"emails data not available"}"}
      end
      render json: @emails
    rescue =>e
      Rails.logger.custom_log.error { "#{e} EmailsController index  method" }
    end
  end


  def update_supplier_id
  
  end  
# it is used to show selected email
  # GET /emails/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in EmailsController show method"
    begin
      render json: @email
    rescue =>e
      Rails.logger.custom_log.error { "#{e} EmailsController index  method" }
    end
  end
# we are not using the below method
  # POST /emails
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in EmailsController create method"
    begin
    @email = Email.new(email_params)
      if @email.save
        render json: @email, status: :created, location: @email
      else
        render json: @email.errors, status: :unprocessable_entity
        Rails.logger.debug_log.debug { "#{"email creation failed"}"}
      end
    rescue =>e
      Rails.logger.custom_log.error { "#{e} EmailsController create  method" }  
    end

  end
# the below method is used to update the emails 
  # PATCH/PUT /emails/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in EmailsController update method"
    begin
      if @email.update(email_params)
        render json: @email
      else
        render json: @email.errors, status: :unprocessable_entity
        Rails.logger.debug_log.debug { "#{"email updation failed"}"}
      end
    rescue =>e
    Rails.logger.custom_log.error { "#{e} EmailsController update  method" }  
    end
  end
# the below method is to delete the email
  # DELETE /emails/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in EmailsController destroy method"
    begin
      @email.destroy
    rescue =>e
      Rails.logger.custom_log.error { "#{e} EmailsController destroy  method" }  
    end
  end
# the below method is used to display the email filter by supplier
  def suppliers_list
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in EmailsController suppliers_list method"
    begin
      @supplier=Email.where(supplier_id:params["id"])
      if @supplier.nil?
      Rails.logger.debug_log.debug { "#{"Data not available"}"}
      end
      render json: @supplier
    rescue =>e
      Rails.logger.custom_log.error { "#{e} EmailsController suppliers_list  method" }  
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def email_params
      params.require(:email).permit(:mailer_name, :subject, :attachment, :date, :supplier_id)
    end
end
