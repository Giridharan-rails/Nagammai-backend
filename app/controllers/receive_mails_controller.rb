class ReceiveMailsController < ApplicationController
  before_action :set_receive_mail, only: [:show, :update, :destroy]
#we are not using this method
  # GET /receive_mails
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : receivemails Index"
   begin
    @receive_mails = ReceiveMail.all.first

    render json: @receive_mails
    rescue => e
      Rails.logger.custom_log.error { "#{e} receivemails_controller index method" }
     end
  end
# we are not using this method
  # GET /receive_mails/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in receivemails show page"
  begin
    render json: @receive_mail
    rescue =>e
   Rails.logger.custom_log.error { "#{e} receivemails_controller show method" }
  end
  end
# this method to create from and receive mail.this table contains only one record not more than that 
  # POST /receive_mails
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the receivemails create button"
    begin
    @receive_mail = ReceiveMail.new(receive_mail_params)

    if @receive_mail.save
      render json: @receive_mail, status: :created, location: @receive_mail
    else
      render json: @receive_mail.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : receivemails created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} receivemails_controller create method" }
   end
  end
# update the receive mail items
  # PATCH/PUT /receive_mails/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the receivemails update button"
    begin
    if @receive_mail.update(receive_mail_params)
      render json: @receive_mail
    else
      render json: @receive_mail.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : receivemails Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} receivemails_controller update method" }
    end
  end

  # DELETE /receive_mails/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in receivemails Delete"
    begin
    @receive_mail.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : receivemails Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} receivemails_controller delete method" }
    end  
  end
# which is used to create and update the mails.above methods are not in use
  def receivemails_update
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in receivemails receivemails_update"
    begin
   params.permit!
    if params["sync_setting"]["schedule"]=="Manual"
      params["email1"]=params["sync_setting"]["email1"]
      params["password1"]=params["sync_setting"]["password1"]
      params["email2"]=params["sync_setting"]["email2"]
      params["password2"]=params["sync_setting"]["password2"]
      
      params["path_setting"]=params["sync_setting"]["path_setting"]
    end
   schedule_time = (params["sync_setting"]["schedule_time"] == nil)? [] : params["sync_setting"]["schedule_time"]
   data= ReceiveMail.first.update(job_name: params["sync_setting"]["job_name"], schedule: params["sync_setting"]["schedule"], schedule_period: params["sync_setting"]["schedule_period"],schedule_time: schedule_time, last_sync: params["sync_setting"]["last_sync"],email1:params["email1"],password1: params["password1"],email2:params["email2"],password2:params["password2"])
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} receivemails_controller receivemails_update method" }
    end 
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receive_mail
      @receive_mail = ReceiveMail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def receive_mail_params
      params.require(:receive_mail).permit(:job_name, :schedule, :schedule_period, :schedule_time, :last_sync)
    end
end
