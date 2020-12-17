class SupplierSynsController < ApplicationController
  before_action :set_supplier_syn, only: [:show, :update, :destroy]
#we are not using this controller anywhere
  # GET /supplier_syns
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : SupplierSyns Index"
   begin
    @supplier_syns = SupplierSyn.all

    render json: @supplier_syns

     unless @supplier_syns.present?
    Rails.logger.debug_log.debug { "#{"supplier_syns data not available"}"}
    end
   
    rescue Exception => e
      Rails.logger.custom_log.error { "#{e} suppliersyns_controller index method" }
     end
  end

  # GET /supplier_syns/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in SupplierSyns show page"
  begin
    render json: @supplier_syn
    unless @supplier_syn.present?
    Rails.logger.debug_log.debug { "#{"supplier_syns data not available"}"}
    end
    rescue e
   Rails.logger.custom_log.error { "#{e} suppliersyns_controller show method" }
  end
  end

  # POST /supplier_syns
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the SupplierSyns create button"
    begin
    @supplier_syn = SupplierSyn.new(supplier_syn_params)

    if @supplier_syn.save
      render json: @supplier_syn, status: :created, location: @supplier_syn
    else
      render json: @supplier_syn.errors, status: :unprocessable_entity
    end
    unless @supplier_syn.present?
    Rails.logger.debug_log.debug { "#{"supplier_syns data not available"}"}
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : SupplierSyns created successfully"
     rescue e
    Rails.logger.custom_log.error { "#{e} suppliersyns_controller create method" }
   end
  end

  # PATCH/PUT /supplier_syns/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the SupplierSyns update button"
    begin
    if @supplier_syn.update(supplier_syn_params)
      render json: @supplier_syn
    else
      render json: @supplier_syn.errors, status: :unprocessable_entity
    end
    unless @supplier_syn.present?
    Rails.logger.debug_log.debug { "#{"supplier_syns data not available"}"}
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : SupplierSyns Updated successfully"
    rescue e
    Rails.logger.custom_log.error { "#{e} suppliersyns_controller update method" }
    end
  end

  # DELETE /supplier_syns/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in SupplierSyns Delete"
    begin
    @supplier_syn.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : SupplierSyns Deleted Successfully"
      rescue e
      Rails.logger.custom_log.error { "#{e}suppliersyns_controller delete method" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier_syn
      @supplier_syn = SupplierSyn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def supplier_syn_params
      params.require(:supplier_syn).permit(:name, :email, :phone_number, :address)
    end
end
