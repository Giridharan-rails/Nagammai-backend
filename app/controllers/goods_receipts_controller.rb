class GoodsReceiptsController < ApplicationController
  before_action :set_goods_receipt, only: [:show, :update, :destroy]
# we are nto using the below method
  # GET /goods_receipts
  def index
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : GoodsReceipt Index"
    @goods_receipts = GoodsReceipt.all.as_json(include: :supplier)

    render json: @goods_receipts
    rescue => e
      Rails.logger.custom_log.error { "#{e} GoodsReceiptsController index method" }
     end
  end
# we are nto using the below method
  # GET /goods_receipts/1
  def show
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : GoodsReceipt SHOW"
    render json: @goods_receipt
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller show method" }
     end

  end
# we are nto using the below method
  # POST /goods_receipts
  def create
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : GoodsReceipt Create"
    @goods_receipt = GoodsReceipt.new(goods_receipt_params)

    if @goods_receipt.save
      render json: @goods_receipt, status: :created, location: @goods_receipt
    else
      render json: @goods_receipt.errors, status: :unprocessable_entity
    end

    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller create method" }
     end
  end
# we are nto using the below method
  # PATCH/PUT /goods_receipts/1
  def update
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : GoodsReceipt Update"
    if @goods_receipt.update(goods_receipt_params)
      render json: @goods_receipt
    else
      render json: @goods_receipt.errors, status: :unprocessable_entity
    end
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller update method" }
     end
    end
# we are nto using the below method
  # DELETE /goods_receipts/1
  def destroy
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : GoodsReceipt Destroy"
    @goods_receipt.destroy
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller destroy method" }
     end
  
  end
# the below meethod is used to display the invoice items with date filter option
  def date_filter
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : GoodsReceipt date_filter"
    good_date=GoodsReceipt.where(:gr_date=>params["from_date"]..params["to_date"]).as_json(include: :supplier)
    render json: good_date
    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller data_filter method" }
     end
  end  

# the below method is used to compare the purchase order with goods receive by po number and invoice number
  def compare_order_no
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : GoodsReceipt compare_order_no"
  #result=[]
  
   #data=GoodsReceipt.where(:purchase_order_code=>params["order_no"])
  #if data.present?
   #data.map do |i|
    #result << {"product_name"=>Product.find_by(:product_code=>i.product_code).product_name,"supplier_name"=>i.supplier.name,"product_code"=>i.product_code,"po_qty"=>ProductPurchaseMapping.find_by(:purchase_order_code=>params["order_no"],:product_code=>i.product_code).quantity,"gr_no"=>i.gr_no,"gr_qty"=>i.qty}   
   #end  
  # end
  result=GoodsReceipt.where(:purchase_order_code=>params["order_no"]).as_json(include: :supplier)
    render json: result

    rescue => e
      Rails.logger.custom_log.error { "#{e} manufacturersync_controller compare_order_no method" }
     end
    
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goods_receipt
      @goods_receipt = GoodsReceipt.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def goods_receipt_params
      params.require(:goods_receipt).permit(:gr_no,:gr_date,:invoice_no,:amount,:quantity,:purchase_order_code,:product_code,:supplier_code,:status,:product_id,:supplier_id)
    end
end
