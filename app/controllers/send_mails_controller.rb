class SendMailsController < ApplicationController
  before_action :set_send_mail, only: [:show, :update, :destroy]
# it display all the sendmail configurations
  # GET /send_mails
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sendmails Index"
   begin
    @send_mails = SendMail.all

    render json: @send_mails
    rescue => e
      Rails.logger.custom_log.error { "#{e} sendmails_controller index method" }
     end
  end
# not in use
  # GET /send_mails/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails show page"
  begin
    render json: @send_mail
  rescue =>e
   Rails.logger.custom_log.error { "#{e} sendmail_controller show method" }
  end
  end
# create the new sendmail configuration
  # POST /send_mails
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the sendmails create button"
    begin
    @send_mail = SendMail.new(send_mail_params)

    if @send_mail.save
      render json: @send_mail, status: :created, location: @send_mail
    else
      render json: @send_mail.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sendmails created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} sendmail_controller create method" }
   end
  end
# not in use
  # PATCH/PUT /send_mails/1
  def update
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the sendmails update button"
    begin
    if @send_mail.update(send_mail_params)
      render json: @send_mail
    else
      render json: @send_mail.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sendmails Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} sendmail_controller update method" }
    end
  end
# not in use
  # DELETE /send_mails/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails Delete"
    begin
    @send_mail.destroy
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sendmails Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller delete method" }
    end
  end

# which is used to update the send mail configuration
 def sendmails_update


  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails sendmails_update"
    begin
   params.permit!
   schedule_time = (params["sync_setting"]["schedule_time"] == nil)? [] : params["sync_setting"]["schedule_time"]
   if schedule_time.present?
    id=params["id"]
    send_items=params["send_items"]
    else
      id=params["sync_setting"]["id"]
      send_items=params["sync_setting"]["send_items"]
    end

   data=SendMail.find(id).update(job_name: params["sync_setting"]["job_name"], schedule: params["sync_setting"]["schedule"], schedule_period: params["sync_setting"]["schedule_period"],schedule_time: schedule_time, last_sync: params["sync_setting"]["last_sync"],send_items:send_items)
   render json: data
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sendmails sendmails_update Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller sendmails_update method" }
    end
 end

# this method is used to display the purchase order which is not yet sent
 def get_purchase_order
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails get_purchase_order"
    begin
  data=[]#PurchaseOrder.all#.as_json(include: :supplier)
  order_no=PurchaseOrder.where(:status=>"",order_date: (Date.today.at_beginning_of_month..Date.today)).order('order_date').pluck(:order_no).uniq
   order_no.map{|i| data<<{"order_no":i,"order_date":PurchaseOrder.where(:order_no=>i).first.order_date,"supplier_code":Supplier.where(:supplier_code=>PurchaseOrder.where(:order_no=>i).first.supplier_code)[0].supplier_name,"total_item":PurchaseOrder.where(:order_no=>i).count,"total_quantity":PurchaseOrder.where(:order_no=>i).pluck(:quantity).map{|j| j.to_i}.sum,"amount": PurchaseOrder.where(:order_no=>i).map{|k| (k.quantity.to_i * k.amount.to_f+k.gst.to_f).to_f}.sum
}}

  render json: data
  rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller get_purchase_order method" }
    end
 end
 
# it is used to display pogr which are not yet sent
def get_pogr
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails get_purchase_order"
    begin
  data=[]#PurchaseOrder.all#.as_json(include: :supplier)
  order_no=PogrMismatch.where(:status=>nil).pluck(:po_number).uniq
   order_no.map{|i| data<<{"supplier_code":PogrMismatch.where(:po_number=>i)[0].supplier_code,"po_number":i,"total_items":PogrMismatch.where(:po_number=>i).count,"total_po_qty":PogrMismatch.where(:po_number=>i).pluck(:po_quantity).map{|tpq| tpq.to_i}.sum,"total_grn_qty":PogrMismatch.where(:po_number=>i).pluck(:gr_quantity).map{|tgq| tgq.to_i}.sum,"total_excess_qty":PogrMismatch.where(:po_number=>i).pluck(:excess_quantity).map{|teq| teq.to_i}.sum}}

  render json: data
  rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller get_purchase_order method" }
    end

end


# is is used to send the purchase order manualy after verification.currenly not in working
 
  def purchase_assign
  
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails get_purchase_order"
    begin
   data=PurchaseOrder.where(:order_no=>params[:order_no]).update(:status=>1)
  PoEmail.where(:order_no=>params[:order_no]).update(:status=>1)
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller purchase_assign method" }
    end
 end
# is is used to send the pogr manualy after verification.currenly not in working

def pogr_assign
Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails get_purchase_order"
    begin
   data=PogrMismatch.where(:po_number=>params[:order_no]).update(:status=>1)
  PogrEmail.where(:order_no=>params[:order_no]).update(:status=>1)
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller purchase_assign method" }
    end

end

# is is used to send the excess stock  manualy after verification.currenly not in working


 def excess_stock_assign_update
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails excess_stock_assign"
    begin
      excess_no=ExcessStock.where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month).where(:product_code=>params["order_no"]).update(:status=>"1").pluck(:excess_no)
      ExcessStockEmail.where(product_code:excess_no)
      render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller excess_stock_assign method" }
    end
 end
# is is used to send the excess stock manualy after verification.currenly not in working

 def excess_stock_assign
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails excess_stock_assign"
    begin
      if params[:supplier_id].present?
            data=ExcessStock.where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month).where(status:nil,supplier_id:params["supplier_id"])
      else
          #  data=ExcessStock.where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month)
           data=[]
      end
      render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller excess_stock_assign method" }
    end
 end
  # is is used to send the free and discount manualy after verification.currenly not in working

 def freeanddiscount_assign
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails claim_assign"
    begin
     
   data=FreeDiscount.where(:claim_no=>params[:claim_no]).update(:status=>"1")
        FreeDiscountEmail.where(:claim_no=>params[:claim_no]).update(:status=>"1")
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller freeanddiscount_assign method" }
    end
 end
 # is is used to send the expiry damage manualy after verification.currenly not in working

  def expiryanddamage_assign
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails claim_assign"
    begin
   data=ExpiryDamage.where(:claim_no=>params[:claim_no]).update(:status=>1)
   ExpiryDamageEmail.where(:claim_no=>params[:claim_no]).update(:status=>1)
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller expiryanddamage_assign method" }
    end
 end
# is is used to send the purchase return  manualy after verification.currenly not in working

   def purchasereturn_assign
  # Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails claim_assign"
   
    begin
  
   data=PurchaseReturn.where(:claim_no=>params[:claim_no]).update(:status=>1)
   PurchaseReturnEmail.where(:claim_no=>params[:claim_no]).update(:status=>1)
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller purchasereturn_assign method" }
    end
 end

# is is used to send the ratechange assign manualy after verification.currenly not in working

  def ratechange_assign
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sendmails claim_assign"
    begin

   data=RateChange.where(:claim_number=>params[:claim_no]).update(:status=>1)
   RateChangeEmail.where(:claim_no=>params[:claim_no]).update(:status=>1)
   render json: data
   rescue =>e
      Rails.logger.custom_log.error { "#{e} sendmail_controller ratechange_assign method" }
    end
 end

#it is used to preview the selected purchase order 

def purchase_order
  begin

  @purchase_orders=PurchaseOrder.where(order_no:params[:order_no]).order('product_name').as_json(include: [:supplier,:product])
  render json: @purchase_orders
  rescue =>e
   Rails.logger.custom_log.error { "#{e} sendmail_controller purchase_orders method" }
  end

  end

# it is used to preview the selected pogr mismatch
def pogr_mismatch_items

 begin

  @pogrs=PogrMismatch.where(po_number:params[:order_no]).as_json(include: [:supplier,:product])

  render json: @pogrs
  rescue =>e
   Rails.logger.custom_log.error { "#{e} sendmail_controller purchase_orders method" }
  end

end
# it is used to all po email in preview page

def po_emails
  emails=PoEmail.where(order_no:params[:order_no])
  render json: emails
end
  # it is used to all pogr email in preview page
def pogr_emails
  emails=PogrEmail.where(order_no:params[:order_no])
  render json: emails
end
  

# it is used to all purchase return email in preview page

def purchase_return_emails
 emails=PurchaseReturnEmail.where(claim_no:params[:claim_no], claim_date: params[:claim_date])
  render json: emails
end
# it is used to all expiry damage email in preview page
def expiry_damage_emails
   emails=ExpiryDamageEmail.where(claim_no:params[:claim_no], claim_date: params[:claim_date])
   
  render json: emails
end
# it is used to all rate change email in preview page
def rate_change_emails
   emails=RateChangeEmail.where(claim_no:params[:claim_no], claim_date: params[:claim_date])
  render json: emails
end
# it is used to all free and discount email in preview page
def free_discount_emails
 emails=FreeDiscountEmail.where(claim_no:params[:claim_no], claim_date: params[:claim_date])
  render json: emails
end



# the below method is used to display the pending email notification
 def email_notification
    result, count = [], []
    a={}
    po = PoEmail.where(status: 1)
    expiry = ExpiryDamageEmail.where(status:1)
    free = FreeDiscountEmail.where(status: 1)
    po_return = PurchaseReturnEmail.where(status: 1)
    rate = RateChangeEmail.where(status: 1)
    pogr = PogrEmail.where(status: 1)
    a["poemail"]= po
    a ["expiry"]= expiry
    a ["free"]= free
    a ["purchase"]= po_return
    a ["ratechange"]= rate
    a["PogrMismatch"]= pogr
    count << [po.count,expiry.count,free.count,po_return.count,rate.count,pogr.count]

    result << [a,{"count" => count.flatten.sum}]
    
    render json: result.flatten
  end

# which is used to delete seledted date

 def datadelete


case params["table_name"]
when "RateChange"
  
  @data=RateChange.where("ack_date < ?",params["date"]).delete_all
when "ExpiryDamage"
  @data=ExpiryDamage.where("ack_date < ?",params["date"]).delete_all
when "FreeDiscount"
  @data=FreeDiscount.where("ack_date < ?",params["date"]).delete_all
when "PurchaseReturn"
  @data=PurchaseReturn.where("ack_date < ?",params["date"]).delete_all
when "ExcessStock"
  @data=ExcessStock.where("ack_date < ?",params["date"]).delete_all
when "PogrMismatch"
  @data=PogrMismatch.where("ack_date < ?",params["date"]).delete_all
when "PurchaseOrder"
  @data=PurchaseOrder.where("ack_date < ?",params["date"]).delete_all
end

render json: @data
    
  end

# display the purchase order by date filter
  def datewisefilter 

    data=[]

   if params["from_date"].present?
   order_no=PurchaseOrder.where(order_date:(params["from_date"]..params["to_date"])).pluck(:order_no).uniq
 elsif params["supplier_id"].present?
  order_no=PurchaseOrder.where(supplier_id:params["supplier_id"]).pluck(:order_no).uniq
 else 
  order_no=PurchaseOrder.all.pluck(:order_no).uniq
  end
   order_no.map{|i| data<< {"order_no":i,"order_date":PurchaseOrder.where(:order_no=>i).first.order_date,"supplier_code":Supplier.where(:supplier_code=>PurchaseOrder.where(:order_no=>i).first.supplier_code)[0].supplier_name,"total_quantity":PurchaseOrder.where(:order_no=>i).pluck(:quantity),"amount": PurchaseOrder.where(:order_no=>i).pluck(:quantity,:amount,:gst)}
}

  render json: data

  end
  # display the purchase order report by date and supplier filters
def purchase_order_report


data=[]
if params["from_date"].present? and params["to_date"].present? and params["supplier_id"].nil?
  order_no=PurchaseOrder.where(order_date:(params["from_date"]..params["to_date"])).pluck(:order_no).uniq
  order_no.map{|i| data<< {"order_no":i,"order_date":PurchaseOrder.where(:order_no=>i).first.order_date,"supplier_code":Supplier.where(:supplier_code=>PurchaseOrder.where(:order_no=>i).first.supplier_code)[0].supplier_name,"total_quantity":PurchaseOrder.where(:order_no=>i).pluck(:quantity),"amount": PurchaseOrder.where(:order_no=>i).pluck(:quantity,:amount,:gst)}}
elsif params["from_date"].present? and params["to_date"].present? and params["supplier_id"].present?
  order_no=PurchaseOrder.where(order_date:(params["from_date"]..params["to_date"]),supplier_id:params["supplier_id"]).pluck(:order_no).uniq
  order_no.map{|i| data<< {"order_no":i,"order_date":PurchaseOrder.where(:order_no=>i).first.order_date,"supplier_code":Supplier.where(:supplier_code=>PurchaseOrder.where(:order_no=>i).first.supplier_code)[0].supplier_name,"total_quantity":PurchaseOrder.where(:order_no=>i).pluck(:quantity),"amount": PurchaseOrder.where(:order_no=>i).pluck(:quantity,:amount,:gst)}}
elsif params["from_date"].present? and params["to_date"].present?
  order_no=PurchaseOrder.where(order_date:(params["from_date"]..params["to_date"])).pluck(:order_no).uniq
  order_no.map{|i| data<< {"order_no":i,"order_date":PurchaseOrder.where(:order_no=>i).first.order_date,"supplier_code":Supplier.where(:supplier_code=>PurchaseOrder.where(:order_no=>i).first.supplier_code)[0].supplier_name,"total_quantity":PurchaseOrder.where(:order_no=>i).pluck(:quantity),"amount": PurchaseOrder.where(:order_no=>i).pluck(:quantity,:amount,:gst)}}
else
  order_no=PurchaseOrder.where(order_date:Date.today).pluck(:order_no).uniq
   order_no.map{|i| data<< {"order_no":i,"order_date":PurchaseOrder.where(:order_no=>i).first.order_date,"supplier_code":Supplier.where(:supplier_code=>PurchaseOrder.where(:order_no=>i).first.supplier_code)[0].supplier_name,"total_quantity":PurchaseOrder.where(:order_no=>i).pluck(:quantity),"amount": PurchaseOrder.where(:order_no=>i).pluck(:quantity,:amount,:gst)}}
end

  render json: data
end
#display all pending claims by date and division
def settled_claims_report
  
  data1 ,data2 ,data3 , data4 = [], [], [], []
  if params["from_date"].present? and params["to_date"].present?
  claim_no=FreeDiscount.where(amount_status:1,ack_date: (params["from_date"]..params["to_date"])).pluck(:claim_no).uniq
  claim_no.map{|i| data3 << {"claim_no":i,"total_quantity":FreeDiscount.where(claim_no: i).pluck(:total_quantity),"settled_amount": FreeDiscount.where(claim_no:i).pluck(:settled_amount),"claim_amount":FreeDiscount.where(claim_no:i).pluck(:claim_amount),"data":FreeDiscount.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  claim_no=PurchaseReturn.where(amount_status:1,claim_date: (params["from_date"]..params["to_date"])).pluck(:claim_no).uniq
  claim_no.map{|i| data1 << {"claim_no":i,"total_quantity":PurchaseReturn.where(claim_no: i).pluck(:quantity),"settled_amount": PurchaseReturn.where(claim_no:i).pluck(:settled_amount),"claim_amount":PurchaseReturn.where(claim_no:i).pluck(:claim_amount),"data":PurchaseReturn.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  
  claim_no=RateChange.where(amount_status: 1,ack_date: (params["from_date"]..params["to_date"])).pluck(:claim_number).uniq
  claim_no.map{|i| data4 << {"claim_no":i,"total_quantity":RateChange.where(claim_number: i).pluck(:quantity),"settled_amount": RateChange.where(claim_number:i).pluck(:settled_amount),"claim_amount":RateChange.where(claim_number:i).pluck(:claim_amount),"data":RateChange.where(claim_number:i).as_json(include: {:supplier=>{only: :supplier_name}})}}

  
  claim_no=ExpiryDamage.where(amount_status: 1,ack_date: (params["from_date"]..params["to_date"])).pluck(:claim_no).uniq
  claim_no.map{|i| data2 << {"claim_no":i,"total_quantity":ExpiryDamage.where(claim_no: i).pluck(:quantity),"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount),"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount),"data":ExpiryDamage.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  

  else
  claim_no=FreeDiscount.where(amount_status:1).pluck(:claim_no).uniq
  claim_no.map{|i| data3 << {"claim_no":i,"total_quantity":FreeDiscount.where(claim_no: i).pluck(:total_quantity),"settled_amount": FreeDiscount.where(claim_no:i).pluck(:settled_amount),"claim_amount":FreeDiscount.where(claim_no:i).pluck(:claim_amount),"data":FreeDiscount.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  claim_no=PurchaseReturn.where(amount_status:1).pluck(:claim_no).uniq
  claim_no.map{|i| data1 << {"claim_no":i,"total_quantity":PurchaseReturn.where(claim_no: i).pluck(:quantity),"settled_amount": PurchaseReturn.where(claim_no:i).pluck(:settled_amount),"claim_amount":PurchaseReturn.where(claim_no:i).pluck(:claim_amount),"data":PurchaseReturn.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  
  claim_no=RateChange.where(amount_status: 1).pluck(:claim_number).uniq
  claim_no.map{|i| data4 << {"claim_no":i,"total_quantity":RateChange.where(claim_number: i).pluck(:quantity),"settled_amount": RateChange.where(claim_number:i).pluck(:settled_amount),"claim_amount":RateChange.where(claim_number:i).pluck(:claim_amount),"data":RateChange.where(claim_number:i).as_json(include: {:supplier=>{only: :supplier_name}})}}

  
  claim_no=ExpiryDamage.where(amount_status: 1).pluck(:claim_no).uniq
  claim_no.map{|i| data2 << {"claim_no":i,"total_quantity":ExpiryDamage.where(claim_no: i).pluck(:quantity),"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount),"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount),"data":ExpiryDamage.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  end
  hash={:purchase_return=>data1,:expiry=> data2,:free_discount=> data3,:ratechange=> data4}
  render json: hash
end

# display all the pending claims without any filter

def overall_claims_report
  today = Date.today
  data1, data2, data3, data4, data5 = [], [], [], [], []
  
  free = FreeDiscount.select('id,claim_no,ack_date,supplier_id,total_quantity,claim_amount,ws_settle_amount,product_id').where(amount_status: nil, ack_date: today).limit(300).group_by(&:claim_no)
    
  free.map {|k,v| data3 << {"claim_no": k,"total_quantity": v.pluck(:total_quantity),"ws_settle_amount": v.pluck(:ws_settle_amount),"claim_amount": v.pluck(:claim_amount),"data": v, "supplier_name": Supplier.find(v.first.supplier_id).supplier_name}}    

   purchase = PurchaseReturn.select('id,claim_no,claim_date,supplier_id,quantity,claim_amount,ws_settle_amount,product_id').where(amount_status: nil, claim_date: today).limit(300).group_by(&:claim_no)

   purchase.map {|k,v| data1 << {"claim_no": k,"total_quantity": v.pluck(:quantity),"ws_settle_amount": v.pluck(:ws_settle_amount),"claim_amount": v.pluck(:claim_amount),"data": v, "supplier_name": Supplier.find(v.first.supplier_id).supplier_name}}

   rate = RateChange.select('id,claim_number,ack_date,supplier_id,quantity,claim_amount,ws_settle_amount,product_id').where(amount_status: nil, ack_date: today).limit(300).group_by(&:claim_number)

   rate.map {|k,v| data4 << {"claim_no": k,"total_quantity": v.pluck(:quantity),"ws_settle_amount": v.pluck(:ws_settle_amount),"claim_amount": v.pluck(:claim_amount),"data": v, "supplier_name": Supplier.find(v.first.supplier_id).supplier_name}}

    expiry = ExpiryDamage.select('id,claim_no,ack_date,supplier_id,quantity,claim_amount,ws_settle_amount,product_id').where(amount_status: nil, ack_date: today).limit(300).group_by(&:claim_no)
    expiry.map {|k,v| data2 << {"claim_no": k,"total_quantity": v.pluck(:quantity),"ws_settle_amount": v.pluck(:ws_settle_amount),"claim_amount": v.pluck(:claim_amount),"data": v ,"supplier_name": Supplier.find(v.first.supplier_id).supplier_name}}

    non_findable = NonFindableClaim.select('id,claim_no,ack_date,supplier_id,quantity,claim_amount,ws_settle_amount,product_id').where(amount_status: nil, ack_date: today).limit(300).group_by(&:claim_no)
    non_findable.map {|k,v| data5 << {"claim_no": k,"total_quantity": v.pluck(:quantity),"ws_settle_amount": v.pluck(:ws_settle_amount),"claim_amount": v.pluck(:claim_amount),"data": v ,"supplier_name": Supplier.find(v.first.supplier_id).supplier_name}}

  data = {:purchase_return=>data1,:expiry=> data2,:free_discount=> data3,:ratechange=> data4, non_findable: data5 }
  
  render json: data 
end
# display the today pending_claims
def pending_claims_report

  data3=[]
  discount_filter_query = {amount_status: nil}
  discount_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  discount_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = FreeDiscount.pending_claims.fetch(:datas).where(discount_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data3 << {"claim_no": k[0], "total_quantity": v.pluck(:total_quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}


  data1=[]
  returns_filter_query = {amount_status: nil}
  returns_filter_query.to_h.merge!({claim_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  returns_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = PurchaseReturn.pending_claims.fetch(:datas).where(returns_filter_query).group_by{|i| [i.claim_no, i.claim_date]}
  claims.map{|k, v| data1 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  data4=[]
  ratechange_filter_query = {amount_status: nil}
  ratechange_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  ratechange_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = RateChange.pending_claims.fetch(:datas).where(ratechange_filter_query).group_by{|i| [i.claim_number, i.ack_date]}
  claims.map{|k, v| data4 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}

  data2=[]
  expiry_filter_query = {amount_status: nil}
  expiry_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  expiry_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = ExpiryDamage.pending_claims.fetch(:datas).where(expiry_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data2 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}

  data5=[]
  expiry_filter_query = {amount_status: nil}
  expiry_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  expiry_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = NonFindableClaim.pending_claims.fetch(:datas).where(expiry_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data5 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  data = {:purchase_return=>data1, :expiry=> data2, :free_discount=> data3, :ratechange=> data4, non_findable: data5}
  render json: data 
end
# used to display the slected claim preview
def adjusment_preview
  adjusment=Adjustment.where(claim_product_id:params[:id]).as_json(include: [:claim_product=>{include: :supplier}])
  
  render json: adjusment
end
# display the pending claims by dartewise filter to display in claim -> pending claims
def pending_claims_datewise_filter

  data3=[]
  discount_filter_query = {amount_status: nil}
  discount_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  discount_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  ## claim_no=FreeDiscount.where(amount_status:nil,ack_date:(params[:from_date]..params[:to_date])).pluck(:claim_no).uniq
  #claim_no = FreeDiscount.where(discount_filter_query).pluck(:claim_no).uniq
  #claim_no.map{|i| data3 << {"claim_no":i,"total_quantity":FreeDiscount.where(claim_no: i).pluck(:total_quantity),"settled_amount": FreeDiscount.where(claim_no:i).pluck(:settled_amount),"claim_amount":FreeDiscount.where(claim_no:i).pluck(:claim_amount),"data":FreeDiscount.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  claims = FreeDiscount.where(discount_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data3 << {"claim_no": k[0], "total_quantity": v.pluck(:total_quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}


  data1=[]
  returns_filter_query = {amount_status: nil}
  returns_filter_query.to_h.merge!({claim_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  returns_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  ##claim_no=PurchaseReturn.where(amount_status:nil,claim_date:(params[:from_date].to_date..params[:to_date].to_date)).pluck(:claim_no).uniq
  #claim_no = PurchaseReturn.where(returns_filter_query).pluck(:claim_no).uniq
  #claim_no.map{|i| data1 << {"claim_no":i,"total_quantity":PurchaseReturn.where(claim_no: i).pluck(:quantity),"settled_amount": PurchaseReturn.where(claim_no:i).pluck(:settled_amount),"claim_amount":PurchaseReturn.where(claim_no:i).pluck(:claim_amount),"data":PurchaseReturn.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  claims = PurchaseReturn.where(returns_filter_query).group_by{|i| [i.claim_no, i.claim_date]}
  claims.map{|k, v| data1 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  data4=[]
  ratechange_filter_query = {amount_status: nil}
  ratechange_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  ratechange_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  ## claim_no=RateChange.where(amount_status:nil,ack_date:(params[:from_date]..params[:to_date])).pluck(:claim_number).uniq
  # claim_no = RateChange.where(ratechange_filter_query).pluck(:claim_number).uniq
  # claim_no.map{|i| data4 << {"claim_no":i,"total_quantity":RateChange.where(claim_number: i).pluck(:quantity),"settled_amount": RateChange.where(claim_number:i).pluck(:settled_amount),"claim_amount":RateChange.where(claim_number:i).pluck(:claim_amount),"data":RateChange.where(claim_number:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  claims = RateChange.where(ratechange_filter_query).group_by{|i| [i.claim_number, i.ack_date]}
  claims.map{|k, v| data4 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}

  data2=[]
  expiry_filter_query = {amount_status: nil}
  expiry_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  expiry_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  ## claim_no=ExpiryDamage.where(amount_status:nil,ack_date:(params[:from_date]..params[:to_date])).pluck(:claim_no).uniq
  # claim_no = ExpiryDamage.where(expiry_filter_query).pluck(:claim_no).uniq
  # claim_no.map{|i| data2 << {"claim_no":i,"total_quantity":ExpiryDamage.where(claim_no: i).pluck(:quantity),"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount),"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount),"data":ExpiryDamage.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  claims = ExpiryDamage.where(expiry_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data2 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}

  data5=[]
  expiry_filter_query = {amount_status: nil}
  expiry_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  expiry_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  ## claim_no=ExpiryDamage.where(amount_status:nil,ack_date:(params[:from_date]..params[:to_date])).pluck(:claim_no).uniq
  # claim_no = ExpiryDamage.where(expiry_filter_query).pluck(:claim_no).uniq
  # claim_no.map{|i| data2 << {"claim_no":i,"total_quantity":ExpiryDamage.where(claim_no: i).pluck(:quantity),"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount),"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount),"data":ExpiryDamage.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  claims = NonFindableClaim.where(expiry_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data5 << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "ws_settle_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  hash={:purchase_return=>data1,:expiry=> data2,:free_discount=> data3,:ratechange=> data4, non_findable: data5}
  render json: hash

end
# display he settled claims with date filter
def settled_claims_datewise_filter 

  data3=[]
  claim_no=FreeDiscount.where(amount_status:1,ack_date:(params[:from_date]..params[:to_date])).pluck(:claim_no).uniq
  claim_no.map{|i| data3 << {"claim_no":i,"total_quantity":FreeDiscount.where(claim_no: i).pluck(:total_quantity),"settled_amount": FreeDiscount.where(claim_no:i).pluck(:settled_amount),"claim_amount":FreeDiscount.where(claim_no:i).pluck(:claim_amount),"data":FreeDiscount.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  data1=[]
  claim_no=PurchaseReturn.where(amount_status:1,claim_date:(params[:from_date]..params[:to_date])).pluck(:claim_no).uniq
  claim_no.map{|i| data1 << {"claim_no":i,"total_quantity":PurchaseReturn.where(claim_no: i).pluck(:quantity),"settled_amount": PurchaseReturn.where(claim_no:i).pluck(:settled_amount),"claim_amount":PurchaseReturn.where(claim_no:i).pluck(:claim_amount),"data":PurchaseReturn.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  data4=[]
  claim_no=RateChange.where(amount_status:1,ack_date:(params[:from_date]..params[:to_date])).pluck(:claim_number).uniq
  claim_no.map{|i| data4 << {"claim_no":i,"total_quantity":RateChange.where(claim_number: i).pluck(:quantity),"settled_amount": RateChange.where(claim_number:i).pluck(:settled_amount),"claim_amount":RateChange.where(claim_number:i).pluck(:claim_amount),"data":RateChange.where(claim_number:i).as_json(include: {:supplier=>{only: :supplier_name}})}}

  data2=[]
  claim_no=ExpiryDamage.where(amount_status:1,ack_date:(params[:from_date]..params[:to_date])).pluck(:claim_no).uniq
  claim_no.map{|i| data2 << {"claim_no":i,"total_quantity":ExpiryDamage.where(claim_no: i).pluck(:quantity),"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount),"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount),"data":ExpiryDamage.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
  
  hash={:purchase_return=>data1,:expiry=> data2,:free_discount=> data3,:ratechange=> data4}
  render json: hash
 
  end

#display the todays adjustment by default todays date
def today_adjustment_date_filter
    today_report=Adjustment.where(:credit_date=>(params[:from_date]..params[:to_date])).as_json(include: [:claim_product=>{include: :supplier}])
   render json: today_report

end
# not in use
def excess_stock_report
    excess_report=[]
    #excess_report=ExcessStock.where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month)
    render json: excess_report
end
# display all excess stock by date filter
def excess_stock_date_filter


if  params["from_date"].present?&&params["to_date"].present? &&params["supplier_id"].empty? && params["division_id"].empty?
  result=ExcessStock.where('created_at BETWEEN ? AND ?', params["from_date"].to_date.beginning_of_day, params["to_date"].to_date.end_of_day)
  
elsif params["from_date"].empty?&&params["to_date"].empty? &&params["supplier_id"].present? 
        result=ExcessStock.where(supplier_id:params["supplier_id"]).uniq
elsif params["from_date"].empty?&&params["to_date"].empty? &&params["division_id"].present? 
       result=ExcessStock.where(division_id:params["division_id"]).uniq

elsif params["from_date"].present?&&params["to_date"].present? &&params["supplier_id"].present? && params["division_id"].present?
       result=ExcessStock.where('created_at BETWEEN ? AND ?', params["from_date"].to_date.beginning_of_day, params["to_date"].to_date.end_of_day).where(supplier_id:params["supplier_id"],division_id:params["division_id"])
=begin if result.present?        
        result=result.where(supplier_id:params["supplier_id"])
      if result.present?        
        result=result.where(division_id:params["division_id"])
      end
      else
        result=[]
  end
=end
end

   render json: result
=begin
    if params["from_date"]&&params["to_date"].present? || params["supplier_id"].present?
        result=ExcessStock.where('created_at BETWEEN ? AND ?', params["from_date"].to_date.beginning_of_day, params["to_date"].to_date.end_of_day)
         if  params["supplier_id"].present?                   
        result=result.where(supplier_id:params["supplier_id"])
        end
    end
    if params["supplier_id"].present?
        result=ExcessStock.where(supplier_id:params["supplier_id"])
    end
=end 
end
# not in use

def supplier_man_div_filter
  if params[:type]=="supplier_id"
    @manufacturer=Supplier.find(params[:id]).manufacturers
    render json: @manufacturer
  else
    @manufacturer=Manufacturer.find(params[:id]).divisions
    render json: @manufacturer
    
  end

end
#display all claims without filter
def selectall_claims

  if params["id"]=="Expiry"
    ExpiryDamage.where(status:"").update(status:1)
    ExpiryDamageEmail.where(status: 0).update(status:1)
    render json: true
  elsif params["id"]=="Discount"
    FreeDiscount.where(status:"").update(status:1)
    FreeDiscountEmail.where(status: 0).update(status:1)
    render json: true
  elsif params["id"]=="Return"
    PurchaseReturn.where(status:"").update(status:1)
    PurchaseReturnEmail.where(status: 0).update(status:1)
    render json: true
  elsif params["id"]=="RateChange"
    RateChange.where(status:"").update(status:1)
    RateChangeEmail.where(status: 0).update(status:1)
    render json: true

  end
end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_send_mail
      @send_mail = SendMail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def send_mail_params
      params.require(:send_mail).permit(:job_name, :schedule, :schedule_period, :schedule_time, :last_sync)
    end

