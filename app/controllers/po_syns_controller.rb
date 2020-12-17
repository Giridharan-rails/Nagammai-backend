class PoSynsController < ApplicationController
  before_action :set_po_syn, only: [:show, :update, :destroy]
# we are not using this controller
  # GET /po_syns
  def index
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : po_syns Index"
   begin
    @po_syns = PoSyn.all

    render json: @po_syns
    rescue => e
      Rails.logger.custom_log.error { "#{e} po_syns_controller index method" }
     end
  end

  # GET /po_syns/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in po_syns show page"
  begin
    render json: @po_syn
    rescue =>e
   Rails.logger.custom_log.error { "#{e} po_syns_controller show method" }
  end
  end

  # POST /po_syns
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the po_syns create button"
    begin
    @po_syn = PoSyn.new(po_syn_params)

    if @po_syn.save
      render json: @po_syn, status: :created, location: @po_syn
    else
      render json: @po_syn.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : po_syns created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} po_syns_controller create method" }
   end
  end

  # PATCH/PUT /po_syns/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the po_syns update button"
    begin
    if @po_syn.update(po_syn_params)
      render json: @po_syn
    else
      render json: @po_syn.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : po_syns Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} po_syns_controller update method" }
    end
  end

  # DELETE /po_syns/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in po_syns Delete"
    begin
    @po_syn.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : po_syns Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} po_syns_controller delete method" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_po_syn
      @po_syn = PoSyn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def po_syn_params
      params.require(:po_syn).permit(:order_no, :order_date, :supplier_name, :total_item, :quantity, :net_amount)
    end
end
