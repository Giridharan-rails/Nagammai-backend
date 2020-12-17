class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
# display all the contacts
  # GET /products
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : products Index"
   begin

    @products = Product.limit(500).order('product_name ASC')#.as_json(include: [:division ,:supplier])
    
    render json: @products
    rescue => e
      Rails.logger.custom_log.error { "#{e} Products_controller index method" }
     end
  end
# display the selected product
  # GET /products/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in products show page"
  begin
    render json: @product
  rescue =>e
   Rails.logger.custom_log.error { "#{e} products_controller show method" }
  end
  end
# create new product but we are not using this
  # POST /products
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the products create button"
    begin
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : products created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} products_controller create method" }
   end
  end
# update the selected product
  # PATCH/PUT /products/1
  def update
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the products update button"
    begin
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : products Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} products_controller update method" }
    end
  end
# assign thesupplier to user for appointment handling
  def supplier_update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the products supplier_update button"
    begin
  user=User.find(params[:id]).update(:supplier_id=>params[:user[:supplier_id]])
  render json: user
  rescue =>e
    Rails.logger.custom_log.error { "#{e} products_controller supplier_update method" }
    end
  end 

# display the product by selected division
  def division_product_view 
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the products division_product_view"
    begin
   data=Product.where(:division_id=> params["division_id"])
   render json: data
  rescue =>e
    Rails.logger.custom_log.error { "#{e} products_controller division_product_view method" }
    end
  end
# delete the products 
  # DELETE /products/1
  def destroy
    begin
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the products delete"
    @product.destroy
    rescue =>e
    Rails.logger.custom_log.error { "#{e} products_controller destroy method" }
    end

  end
# to display all purchase order but we are not using

  def purchase_order_all
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the PurchaseOrder"
    begin
   purchase=PurchaseOrder.all
    render json: purchase
    rescue =>e
    Rails.logger.custom_log.error { "#{e} products_controller purchase_order_all method" }
    end
  end  
# which is used to display the compared pogr 
  def purchase_goods_receipt

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the purchase_goods_receipt"
    begin

    purchase_order=PurchaseOrder.where(order_no: params["po"].split(","))




    output=[]

    if purchase_order.present?
      order_no=purchase_order.pluck(:supplier_code).uniq
    if order_no.count == 1

    grn_data=GoodsReceivedNote.where(:grn_number=>params["grn"].split(",")).where(:supplier_code=>order_no)
    grn_product=grn_data.pluck(:product_code).uniq

  if grn_product.present?
       grn_product.map{|i| output << {"purchase_order"=>purchase_order.where(product_code:i),"product_name"=>grn_data.where(product_code:i)[0].product_name,"product_code"=>i,"supplier_name"=>grn_data.where(product_code:i)[0].supplier,"gr_qty"=>GoodsReceivedNote.where(product_code: i)}}
  end 
    end
    end
  
    render json: output
    rescue =>e
      
    Rails.logger.custom_log.error { "#{e} products_controller purchase_goods_receipt method" }
    end
  
  end  




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:product_name,:product_code,:division_code,:supplier_code,:packing,:hsn_code,:gst_tax,:purchase_price,:sales_price,:mrp,:last_sale_date,:last_receive_date,:total_stock,:division_id,:supplier_id)
    end
end
