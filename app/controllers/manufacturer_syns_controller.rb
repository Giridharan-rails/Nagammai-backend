class ManufacturerSynsController < ApplicationController
  before_action :set_manufacturer_syn, only: [:show, :update, :destroy]
# we are not using this controller anywhere
  # GET /manufacturer_syns
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturer_syns Index"
    begin

    @manufacturer_syns = ManufacturerSyn.all

    render json: @manufacturer_syns
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller index method" }
     end
  end

  # GET /manufacturer_syns/1
  def show
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturer_syns show "

    render json: @manufacturer_syn
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller index method" }
     end
 
  end

  # POST /manufacturer_syns
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturer_syn create "

    begin

    @manufacturer_syn = ManufacturerSyn.new(manufacturer_syn_params)

    if @manufacturer_syn.save
      render json: @manufacturer_syn, status: :created, location: @manufacturer_syn
    else
      render json: @manufacturer_syn.errors, status: :unprocessable_entity
    end
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller create method" }
     end
 
  end

  # PATCH/PUT /manufacturer_syns/1
  def update
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturer_syn_update "

    if @manufacturer_syn.update(manufacturer_syn_params)
      render json: @manufacturer_syn
    else
      render json: @manufacturer_syn.errors, status: :unprocessable_entity
    end
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller update method" }
     end
 
  end

  # DELETE /manufacturer_syns/1
  def destroy
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : manufacturersync destroy "

    @manufacturer_syn.destroy
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller destroy method" }
     end
 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manufacturer_syn
      @manufacturer_syn = ManufacturerSyn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def manufacturer_syn_params
      params.require(:manufacturer_syn).permit(:name, :email, :phone_number, :address)
    end
end
