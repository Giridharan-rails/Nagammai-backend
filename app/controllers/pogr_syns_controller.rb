
class PogrSynsController < ApplicationController
  before_action :set_pogr_syn, only: [:show, :update, :destroy]
# we are not using this method
  # GET /pogr_syns
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : pogr_syns Index"
   begin
    @pogr_syns = PogrSyn.all

    render json: @pogr_syns
    rescue => e
      Rails.logger.custom_log.error { "#{e} pogr_syns_controller index method" }
     end
  end
# we are not using this method
  # GET /pogr_syns/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in pogr_syn show page"
  begin
    render json: @pogr_syn
   rescue =>e
   Rails.logger.custom_log.error { "#{e} pogr_syns_controller show method" }
  end
  end
# we are not using this method
  # POST /pogr_syns
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the pogr_syn create button"
    begin
    @pogr_syn = PogrSyn.new(pogr_syn_params)

    if @pogr_syn.save
      render json: @pogr_syn, status: :created, location: @pogr_syn
    else
      render json: @pogr_syn.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : pogr_syns created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} pogr_syns_controller create method" }
   end
  end
# we are not using this method
  # PATCH/PUT /pogr_syns/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the pogr_syns update button"
    begin
    if @pogr_syn.update(pogr_syn_params)
      render json: @pogr_syn
    else
      render json: @pogr_syn.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : pogr_syns Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} pogr_syns_controller update method" }
    end
  end
# we are not using this method
  # DELETE /pogr_syns/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in pogr_syns Delete"
    begin
    @pogr_syn.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : pogr_syns Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} pogr_syns_controller delete method" }
    end
  end
# the below method is to perform comparision operation between purchase order and goods received
def pogr_mismatch

 contacts=[]
 send_item=SendMail.find_by(job_name:"PO-GR Mismatch").send_items.split(",")
 product_code=params["data"].map{|i| i["product_code"]}
 supplier_code=params["data"][0]["supplier_code"]

send_item.map do |item|

if item == "Supplier"

    supplier_contact=Contact.where(sub_contact_type:"Supplier",sub_contact_id:Supplier.find_by(supplier_code:supplier_code).id)
    supplier_contact.map{|i| contacts<< i if i.mail_allocation.include?"po_gr"}
Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- :supplier contact error"
elsif item == "Manufacturer"
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- :manufacturer contact error"
    product_code.map do |product|
    manufacturer_contact=Contact.where(sub_contact_type:"Manufacturer",sub_contact_id:Product.find_by(product_code:product).division.manufacturer.id)
    manufacturer_contact.map{|i| contacts<< i if i.mail_allocation.include?"po_gr"}  
   end
else
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- :division contact error"
    product_code.map do |product|
    division_contact=Contact.where(sub_contact_type:"Division",sub_contact_id:Product.find_by(product_code:product).division.id)
    division_contact.map{|i| contacts<< i if i.mail_allocation.include?"po_gr"}  
end
end
end

if contacts.present?

contacts.map{|j| PogrEmail.create(order_no:params["data"][0]["po_number"].present? ? params["data"][0]["po_number"].map{|l| l["order_no"]}.join(",") : params["data"][0]["gr_number"].map{|l| l["grn_number"]}.join(","),email:j.email,status: 1)}

else
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : contacts not found"
end  

if params["data"].present?

 params["data"].map{|i| PogrMismatch.create(po_no_dummy:i["po_number"].present? ? i["po_number"].map{|k| k["order_no"]}.join(",") : nil,po_number:i["po_number"].present? ? i["po_number"][0]["order_no"] : nil, grn_no_dummy:i["gr_number"].map{|l| l["grn_number"]}.join(","),gr_number:i["gr_number"][0]["grn_number"],product_code:i["product_code"],product_name:i["product_name"],supplier_code:i["supplier_code"],supplier_name:i["supplier_name"],po_quantity:i["po_quantity"],gr_quantity:i["gr_quantity"],excess_quantity:i["excess_quantity"],supplier_id:Supplier.find_by(supplier_code:i["supplier_code"]).id,product_id:Product.find_by(product_code:i["product_code"]).id )}
end



end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pogr_syn
      @pogr_syn = PogrSyn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pogr_syn_params
      params.require(:pogr_syn).permit(:gr_no, :date, :invoice_no, :supplier_name, :gross_amount)
    end
end
