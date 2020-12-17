class SyncSettingsController < ApplicationController
  before_action :set_sync_setting, only: [:show, :update, :destroy]
# display all the syncs in index page
  # GET /sync_settings
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sync_setting index method"
   begin
    @sync_settings = SyncSetting.all

    render json: @sync_settings

    unless @sync_settings.present?
   Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
   end
    rescue => e
      Rails.logger.custom_log.error { "#{e} sync_setting_controller index method" }
     end
  end
# not in use
  # GET /sync_settings/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sync_setting show page"
  begin
    render json: @sync_setting
    unless @sync_setting.present?
   Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
   end


    rescue =>e

 Rails.logger.custom_log.error { "#{e} sync_setting_controller show method" }
  end
  end
# not in use
  # POST /sync_settings
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the sync_setting create button"
    begin
    @sync_setting = SyncSetting.new(sync_setting_params)

    if @sync_setting.save
      render json: @sync_setting, status: :created, location: @sync_setting
    else
      render json: @sync_setting.errors, status: :unprocessable_entity
    end
    unless @sync_setting.present?
   Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
   end

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sync_setting created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} sync_setting_controller create method" }
   end
  end
# not in use
  # PATCH/PUT /sync_settings/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the sync_setting update button"
    begin
    if @sync_setting.update(sync_setting_params)
      render json: @sync_setting
    else
      render json: @sync_setting.errors, status: :unprocessable_entity
    end

    unless @sync_setting.present?
    Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
    end

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sync_setting Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} sync_setting_controller update method" }
    end
  end
# not in use
  # DELETE /sync_settings/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sync_setting Delete"
    begin
    @sync_setting.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sync_setting Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} sync_setting_controller delete method" }
    end
  end
# which is used to create wondersoft database connection details
  def wondersoft_connection
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in wondersoft_connection"
  begin
  wonder=WonderSoft.create(wonder_soft_params)
  render json: wonder
  unless wonder.present?
   Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
   end

  rescue =>e
      Rails.logger.custom_log.error { "#{e} sync_setting_controller wondersoft_connection method" }
    end
  end  

# which is used to update the wondersoft database connection details
  def wondersoft_connection_update

  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in wondersoft_connection"
  begin
    
  wonder=WonderSoft.find(params[:idd]).update(wonder_soft_params)
  render json: wonder
  unless wonder.present?
   Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
   end

  rescue =>e
      Rails.logger.custom_log.error { "#{e} sync_setting_controller wondersoft_connection method" }
    end
  end 
# not in use
  def wondersoft_connection_data
  
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in wondersoft_connection_data"
  begin
  wonder_soft_data=WonderSoft.first
  render json: wonder_soft_data
  unless wonder_soft_data.present?
   Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
   end
  rescue =>e
      Rails.logger.custom_log.error { "#{e} sync_setting_controller wondersoft_connection_data method" }
    end
  end 
 # display the connection details
  def nagammai_connection_data
  
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in wondersoft_connection_data"
  begin
  wonder_soft_data=WonderSoft.first
  render json: wonder_soft_data
  unless wonder_soft_data.present?
   Rails.logger.debug_log.debug { "#{"sync_setting data not available"}"}
   end
  rescue =>e
      Rails.logger.custom_log.error { "#{e} sync_setting_controller wondersoft_connection_data method" }
    end
  end 
 
# update the selected sync setting date
  def sync_setting_update
      
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sync_setting_update"
  begin
   params.permit!

   schedule_time = (params["sync_setting"]["schedule_time"] == nil)? [] : params["sync_setting"]["schedule_time"]
   if schedule_time.present?
   id=params[:id]
   else
   id=params["sync_setting"]["id"]
   end


   data= SyncSetting.find(id).update(job_name: params["sync_setting"]["job_name"], schedule: params["sync_setting"]["schedule"], schedule_period: params["sync_setting"]["schedule_period"],schedule_time: schedule_time, last_sync:params["last_sync"])
   
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sync_setting_controller sync_setting_update method" }
    end
  end  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sync_setting
      @sync_setting = SyncSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sync_setting_params
      params.require(:sync_setting).permit(:job_name, :schedule, :schedule_period, :schedule_time, :last_sync)
    end

    def wonder_soft_params
       params.require(:wonder_soft).permit(:user_name, :password, :database_name, :server_name, :manual_sync_time)
    end
      
end
