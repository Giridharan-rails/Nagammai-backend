class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :update, :destroy]

  # GET /claims

# this method is to check the sync process done properly or not

def data_report

 if params[:from_date].present?
     data=[]
     date =params[:from_date].to_date.beginning_of_day .. params[:to_date].to_date.end_of_day

    data << ["Purchase Order",PurchaseOrder.where(created_at:date).pluck(:order_no).uniq.count,PoLog.where(created_at:date).pluck(:po_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_order_reason).first : "",PoEmail.where(created_at:date).where(status:"2").count,PoEmail.where(created_at:date).where(status:"1").count,"purchase_order_count","purchase_order_reason","purchase_order_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_order_email_reason).first : "" ]
    data << ["Expiry Broken",ExpiryDamage.where(created_at:date).pluck(:claim_no).uniq.count,ExpiryDamageLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:expiry_broken_reason).first : "" ,ExpiryDamageEmail.where(created_at:date).where(status:"2").count,ExpiryDamageEmail.where(created_at:date).where(status:"1").count,"expiry_broken_count","expiry_broken_reason","expiry_broken_email_reason", ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:expiry_broken_email_reason).first : ""]
    data << ["Free Discount",FreeDiscount.where(created_at:date).pluck(:claim_no).uniq.count,FreeDiscountLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:free_discount_reason).first : "",FreeDiscountEmail.where(created_at:date).where(status:"2").count,FreeDiscountEmail.where(created_at:date).where(status:"1").count,"free_discount_count","free_discount_reason","free_discount_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:free_discount_email_reason).first : "" ]
    data << ["Purchase Return",PurchaseReturn.where(created_at:date).pluck(:claim_no).uniq.count,PurchaseReturnLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_return_reason).first : "",PurchaseReturnEmail.where(created_at:date).where(status:"2").count,PurchaseReturnEmail.where(created_at:date).where(status:"1").count,"purchase_return_count","purchase_return_reason","purchase_return_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_return_email_reason).first : ""]
    data << ["Rate Change",RateChange.where(created_at:date).pluck(:claim_number).uniq.count,RateChangeLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:rate_change_reason).first : "",RateChangeEmail.where(created_at:date).where(status:"2").count,RateChangeEmail.where(created_at:date).where(status:"1").count,"rate_change_count","rate_change_reason","rate_change_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:rate_change_email_reason).first : ""]
    data << ["Excess Stock",ExcessStock.where(created_at:date).count,ExcessStockLog.where(created_at:date).count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:excess_stock_reason).first : "",ExcessStockEmail.where(created_at:date).where(status:"2").count,ExcessStockEmail.where(created_at:date).where(status:"1").count,"excess_stock_count","excess_stock_reason","excess_stock_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:excess_stock_email_reason).first : ""]
    data << ["POGR",GoodsReceivedNote.where(created_at:date).pluck(:grn_number).uniq.count,GrnLog.where(created_at:date).pluck(:unique_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:pogr_reason).first : "",PogrEmail.where(created_at:date).where(status:"2").count,PogrEmail.where(created_at:date).where(status:"1").count,"pogr_count","pogr_reason","pogr_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:pogr_email_reason).first : ""]
    data << ["Appointment",Appointment.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:appointment_reason).first : "",0,0,"appointments_count","appointments_reason","appointments_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:appointment_email_reason).first : ""]
    data << ["ClaimIssue",ClaimIssue.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:claim_issue_reason).first : "",0,0,"claim_issue_count","claim_issue_reason","claim_issue_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:claim_issue_reason).first : ""]
    data << ["Inbox",Email.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:inbox_reason).first : "",0,0,"inbox_count","inbox_reason","inbox_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:inbox_email_reason).first : ""]
    data << ["NonFindableClaim",NonFindableClaim.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:non_findable_claim_reason).first : "",0,0,"non_findable_claim_count","non_findable_claim_reason","non_findable_claim_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:non_findable_claim_email_reason).first : ""]
    

    render json: data
 else
 
    data=[]
    date = Date.today.beginning_of_day .. Date.today.end_of_day
    data << ["Purchase Order",PurchaseOrder.where(created_at:date).pluck(:order_no).uniq.count,PoLog.where(created_at:date).pluck(:po_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_order_reason).first : "" ,PoEmail.where(created_at:date).where(status:"2").count,PoEmail.where(created_at:date).where(status:"1").count,"purchase_order_count","purchase_order_reason","purchase_order_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_order_reason).first : ""]
    data << ["Expiry Broken",ExpiryDamage.where(created_at:date).pluck(:claim_no).uniq.count,ExpiryDamageLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:expiry_broken_reason).first : "",ExpiryDamageEmail.where(created_at:date).where(status:"2").count,ExpiryDamageEmail.where(created_at:date).where(status:"1").count,"expiry_broken_count","expiry_broken_reason","expiry_broken_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:expiry_broken_email_reason).first : ""]
    data << ["Free Discount",FreeDiscount.where(created_at:date).pluck(:claim_no).uniq.count,FreeDiscountLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:free_discount_reason).first : "",FreeDiscountEmail.where(created_at:date).where(status:"2").count,FreeDiscountEmail.where(created_at:date).where(status:"1").count,"free_discount_count","free_discount_reason","free_discount_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:free_discount_email_reason).first : ""]
    data << ["Purchase Return",PurchaseReturn.where(created_at:date).pluck(:claim_no).uniq.count,PurchaseReturnLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_return_reason).first : "",PurchaseReturnEmail.where(created_at:date).where(status:"2").count,PurchaseReturnEmail.where(created_at:date).where(status:"1").count,"purchase_return_count","purchase_return_reason","purchase_return_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:purchase_return_email_reason).first : ""]
    data << ["Rate Change",RateChange.where(created_at:date).pluck(:claim_number).uniq.count,RateChangeLog.where(created_at:date).pluck(:claim_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:rate_change_reason).first : "",RateChangeEmail.where(created_at:date).where(status:"2").count,RateChangeEmail.where(created_at:date).where(status:"1").count,"rate_change_count","rate_change_reason","rate_change_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:rate_change_reason).first : ""]
    data << ["Excess Stock",ExcessStock.where(created_at:date).count,ExcessStockLog.where(created_at:date).count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:excess_stock_reason).first : "",ExcessStockEmail.where(created_at:date).where(status:"2").count,ExcessStockEmail.where(created_at:date).where(status:"1").count,"excess_stock_count","excess_stock_reason","excess_stock_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:excess_stock_email_reason).first : ""]
    data << ["POGR",GoodsReceivedNote.where(created_at:date).pluck(:grn_number).uniq.count,GrnLog.where(created_at:date).pluck(:unique_no).uniq.count,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:pogr_reason).first : "",PogrEmail.where(created_at:date).where(status:"2").count,PogrEmail.where(created_at:date).where(status:"1").count,"pogr_count","pogr_reason","pogr_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:pogr_email_reason).first : ""]
    data << ["Appointment",Appointment.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:appointment_reason).first : "",0,0,"appointments_count","appointments_reason","appointments_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:appointment_email_reason).first : ""]
    data << ["ClaimIssue",ClaimIssue.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:claim_issue_reason).first : "",0,0,"claim_issue_count","claim_issue_reason","claim_issue_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:claim_issue_email_reason).first : ""]
    data << ["Inbox",Email.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:inbox_reason).first : "",0,0,"inbox_count","inbox_reason","inbox_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:inbox_reason).first : ""]
    data << ["NonFindableClaim",NonFindableClaim.where(created_at:date).uniq.count,0,ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:non_findable_claim_reason).first : "",0,0,"non_findable_claim_count","non_findable_claim_reason","non_findable_claim_email_reason",ReportDetail.where(report_date:date).present? ? ReportDetail.where(report_date:date).pluck(:non_findable_claim_email_reason).first : ""]
    render json: data
 end


end

# We are not using below method

def index
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller index method"
  begin   
    @claims = Claim.all.as_json(include: :supplier)
    render json: @claims
    if @claims.nil? 
      Rails.logger.debug_log.debug { "#{"claims data not available"}"}
    end
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller index  method" }
  end  
end
# We are not using below method

def claim_index
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller claim_index method"
  begin   
    claim=Claim.where(:type_of_claim=>nil).as_json(include: {:supplier=> {only: :supplier_name}})
    render json: claim
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claim_index displayed Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller claim_index method" }
  end
end  

  # GET /claims/1
def show
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims show method"
  begin
    render json: @claim
    if @claim.nil? 
      Rails.logger.debug_log.debug { "#{"claims may be not available otherwise check backend"}"}
    end
    rescue =>e
      Rails.logger.custom_log.error { "#{e} claims_controller show method" }
    end 
end
# We are not using below method

  # POST /claims
def create
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the claims create button"
  begin
    @claim = Claim.new(claim_params)
    if @claim.save
      render json: @claim, status: :created, location: @claim
    else
      render json: @claim.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claims created successfully"
    rescue =>e
      Rails.logger.custom_log.error { "#{e} claims_controller create method" }
    end
end
# We are not using below method

  # PATCH/PUT /claims/1
def update
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the claims update button"
  begin
    if @claim.update(claim_params)
      render json: @claim
    else
      render json: @claim.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claims Updated successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller update method" }
  end 
end
# We are not using below method

def pending_claim
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller pending_claim method"
  begin 
    claim= NonFindableClaim.all
    render json: claim
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : pending_claim displayed Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller pending_claim method" }
  end
end  
# We are not using below method
def claim_date_report
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller claim_date_report method"
  begin 
    from_date=params["from_date"].split(",")[0].to_date.strftime("%Y-%m-%d")
    to_date=params["from_date"].split(",")[1].to_date.strftime("%Y-%m-%d")
    claim=Claim.where(claim_date: from_date..to_date).where.not("settled_amount = claim_amount",:status=>"closed").as_json(include: {supplier: {only: :supplier_name}})
    render json: claim
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claim_date_report displayed Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller claim_date_report method" }
  end
end  

# We are not using below method
def claim_update
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims claim_update Updated"
  begin
    if params["claim"]["type_of_claim"].present?
      key=params["claim"]["type_of_claim"].keys
      value=params["claim"]["type_of_claim"].values
      (0..key.count-1).map{|i| Claim.find(key[i]).update(:type_of_claim=>value[i]) } 
    end  
    if params["claim"]["status"].present?
      key1=params["claim"]["status"].keys
      value1=params["claim"]["status"].values
      (0..key1.count-1).map{|i| Claim.find(key1[i]).update(:status=>value1[i]) } 
    end  
    render json: true
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claim_update Updated Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller claim_update method" }
  end
end  

# We are not using below method
def settled_claims
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller settled_claims method"
  begin 
    settle=SettledClaim.where(settled_date: Date.today).as_json(include: {:supplier=> {only: :supplier_name}, :claim=>{only: :type_of_claim}})
    render json: settle
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : settled_claims displayed Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller settled_claims method" }
  end  
end

# We are not using below method
def datewise_settled_claims
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller datewise_settled_claims method"
  begin 
    settle=SettledClaim.where(settled_date: params["from_date"]..params["to_date"]).as_json(include: {:supplier=> {only: :supplier_name}, :claim=>{only: :type_of_claim}})
    render json: settle
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : datewise_settled_claims displayed Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller datewise_settled_claims method" }
  end  
end

# We are not using below method
def status_close
  begin
    claim=Claim.where(:status=>"Closed").as_json(include: {:supplier=> {only: :supplier_name}})
    render json: claim
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller status_close method" }
  end
end 

def datewise_close_claim
  begin
    claim=Claim.where(:status=>"Closed",:claim_date=>params["from_date"]..params["to_date"]).as_json(include: {:supplier=> {only: :supplier_name}})
    render json: claim
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller datewise_close_claims method" }
  end
end  


# We are not using below method
  # DELETE /claims/1
def destroy
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims Delete"
  begin
    @claim.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claims Deleted Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller destroy method" }
  end 
end
# We are not using below method
def date_report
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller date_report method"
  begin 
    data=Claim.where(:bill_date=>params["from_date"]..params["to_date"])
    render json: data
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : date_report displayed Successfully"
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller date_report method" }
  end 
end  
# the below method is used to display the free and discounts pending claims
def discounts
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claims_controller discounts method"
  begin

    @discounts=[]
    if params["supplier_id"].present? && params["from_date"].empty? && params["to_date"].empty?
    @discounts=FreeDiscount.where(status:"",supplier_id: params["supplier_id"], ack_date: Date.today).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].present? && params["from_date"].present? && params["to_date"].present?
     @discounts=FreeDiscount.where(status:"",supplier_id: params["supplier_id"],ack_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].empty? && params["from_date"] == params["to_date"]
    @discounts=FreeDiscount.where(status:"",ack_date: Date.today).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
   elsif params["supplier_id"].empty? && params["from_date"].present? && params["to_date"].present?
    @discounts=FreeDiscount.where(status:"",ack_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    end

    render json:  @discounts
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller discounts method" }
  end 
end
# the below method is used to display the ratechange pending claims
def rates
  begin
     @rates=[]
     if params["supplier_id"].present? && params["from_date"].empty? && params["to_date"].empty?
    @rates = RateChange.where(status:["",nil],supplier_id: params["supplier_id"]).select("DISTINCT(claim_number)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].present? && params["from_date"].present? && params["to_date"].present?
     @rates = RateChange.where(status:["",nil],supplier_id: params["supplier_id"],ack_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_number)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
     elsif params["supplier_id"].empty? && params["from_date"] == params["to_date"]
	@rates = RateChange.where(status:["",nil],ack_date: params["from_date"].to_date).select("DISTINCT(claim_number)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].empty? && params["from_date"].present? && params["to_date"].present?
   @rates = RateChange.where(status:["",nil],ack_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_number)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})

    end

    #claim_number=RateChange.where(:status=>nil).pluck(:claim_number).uniq
    #claim_number.map{|i| @rates<<{"claim_no":i,"ack_date": RateChange.where(:claim_number=>i).first.ack_date,"supplier_code":Supplier.find_by(supplier_code:RateChange.where(claim_number:i).first.supplier_code).supplier_name,"division_code":Division.find_by(:div_code=>(RateChange.where(:claim_number=>i).first.div_code)).div_name,"quantity":RateChange.where(:claim_number=>i).pluck("quantity").map{|j|j.to_i}.sum,"claim_amount":RateChange.where(:claim_number=>i).pluck(:claim_amount).map{|k| k.to_i}.sum,"settled_amount":RateChange.where(:claim_number=>i).pluck(:settled_amount).map{|k| k.to_i}.sum}}.uniq
    render json:  @rates
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller rates method" }
  end 
end
#the below method is used to display the expiry damage  pending claims
def expiry_damages
   begin


    @expiry_damages=[]

    if params["supplier_id"].present? && params["from_date"].empty? && params["to_date"].empty?
    @expiry_damages=ExpiryDamage.where(status:"",supplier_id: params["supplier_id"], ack_date: Date.today).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].present? && params["from_date"].present? && params["to_date"].present?
      @expiry_damages=ExpiryDamage.where(status:"",supplier_id: params["supplier_id"],ack_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].empty? && params["from_date"] == params["to_date"]
      @expiry_damages=ExpiryDamage.where(status:"",ack_date:params["from_date"].to_date).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].empty? && params["from_date"].present? && params["to_date"].present?
      @expiry_damages=ExpiryDamage.where(status:"",ack_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_no)",:ack_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    end
    #claim_number=ExpiryDamage.where(:status=>"").pluck(:claim_no).uniq
    #claim_number.map{|i| @expiry_damages<<{"claim_no":i,"ack_date":ExpiryDamage.where(:claim_no=>i).first.ack_date,"supplier_code":Supplier.find_by(supplier_code:ExpiryDamage.where(claim_no:i).first.supplier_code).supplier_name,"total_quantity":ExpiryDamage.where(:claim_no=>i).pluck("quantity").map{|j|j.to_i}.sum,"claim_amount":ExpiryDamage.where(:claim_no=>i).pluck(:claim_amount).map{|k| k.to_i}.sum,"settled_amount":ExpiryDamage.where(:claim_no=>i).pluck(:settled_amount).map{|k| k.to_i}.sum}}.uniq
    render json:  @expiry_damages
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller expiry_damages method" }
  end   
end
# the below method is used to display the purchase return claims
def purchase_returns
  begin
    
    @purchase_returns=[]#ExpiryDamage.all.as_json(include: [:supplier,:product])
     
    if params["supplier_id"].present? && params["from_date"].empty? && params["to_date"].empty?
    @purchase_returns = PurchaseReturn.where(status:"",supplier_id: params["supplier_id"], claim_date: Date.today).select("DISTINCT(claim_no)",:claim_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
    elsif params["supplier_id"].present? && params["from_date"].present? && params["to_date"].present?
     @purchase_returns = PurchaseReturn.where(status:"",supplier_id: params["supplier_id"],claim_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_no)",:claim_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
   elsif params["supplier_id"].empty? && params["from_date"] == params["to_date"]
     @purchase_returns = PurchaseReturn.where(status:"",claim_date: params["from_date"].to_date).select("DISTINCT(claim_no)",:claim_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})
   elsif params["supplier_id"].empty? && params["from_date"].present? && params["to_date"].present?
     @purchase_returns = PurchaseReturn.where(status:"",claim_date: (params["from_date"].to_date..params["to_date"].to_date)).select("DISTINCT(claim_no)",:claim_date,:supplier_id).as_json(include: {:supplier=> {only: :supplier_name}})

    end

    #   claim_number=PurchaseReturn.where(:status=>"").pluck(:claim_no).uniq
    #claim_number.map{|i| @purchase_returns<<{"claim_no":i,"ack_date": PurchaseReturn.where(:claim_no=>i).first.claim_date,"supplier_code":Supplier.find_by(supplier_code:PurchaseReturn.where(claim_no:i).first.supplier_code).supplier_name,"total_quantity":PurchaseReturn.where(:claim_no=>i).pluck("quantity").map{|j|j.to_i}.sum,"claim_amount":PurchaseReturn.where(:claim_no=>i).pluck(:claim_amount).map{|k| k.to_i}.sum,"settled_amount":PurchaseReturn.where(:claim_no=>i).pluck(:settled_amount).map{|k| k.to_i}.sum}}.uniq
    render json:  @purchase_returns
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller purchase_returns method" }
  end 
end
# the below method is used to view the specific selected free and discount claim
def discount_claim
  begin
   @discount_claim=FreeDiscount.where(claim_no:params[:claim_no], ack_date: params[:claim_date]).as_json(include: :product)
   # @discount_claim=FreeDiscount.where(claim_no:params[:claim_no]).as_json(include: :product)
    render json: @discount_claim
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller discount_claim method" }
  end 
end
# the below method is used to view the specific selected rate change claim
def rate_claim
  begin
    @rate_claim=RateChange.where(claim_number:params[:claim_no], ack_date: params[:claim_date]).as_json(include: :product)
    #@rate_claim=RateChange.where(claim_number:params[:claim_no]).as_json(include: :product)
    render json: @rate_claim
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller rate_claim method" }
  end 
end
# the below method is used to view the specific selected expiry and damage claim
def expiry_claim
  begin
    @expiry_claim = ExpiryDamage.where(claim_no: params[:claim_no], ack_date: params[:claim_date]).as_json(include: [:product, :supplier])
    # @expiry_claim = ExpiryDamage.where(claim_no: params[:claim_no]).as_json(include: [:product, :supplier])
    render json: @expiry_claim
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller expiry_claim method" }
  end 
end
# the below method is used to view the specific selected purchase return claim
def purchasereturn_claim
  begin
    ##@purchasereturn_claim=PurchaseReturn.where(claim_no:params[:claim_no],supplier_id: params[:supplier_id]).as_json(include: [:product,:adjustments])
    @purchasereturn_claim=PurchaseReturn.where(claim_no:params[:claim_no], claim_date: params[:claim_date]).as_json(include: [:product,:adjustments])
    #@purchasereturn_claim=PurchaseReturn.where(claim_no:params[:claim_no]).as_json(include: [:product,:adjustments])
    render json: @purchasereturn_claim
  rescue =>e
    Rails.logger.custom_log.error { "#{e} claims_controller expiry_claim method" }
  end 
end

# this methos is used for Issues report to display datewise filtered issues
def datewise_filter_claim
=begin
  if params["from_date"].present?&&params["to_date"].present?&&params["status"].present?
    @datewise_filter=ClaimIssue.where(cut_off_date:(params["from_date"]..params["to_date"]),status:params["status"]).as_json(include: :contact)
  elsif params["from_date"].present?&&params["to_date"].present?
    @datewise_filter=ClaimIssue.where(cut_off_date:(params["from_date"]..params["to_date"])).as_json(include: :contact)
  else
    @datewise_filter=ClaimIssue.where(status:params["status"]).as_json(include: :contact)
  end
render json: @datewise_filter
=end
  if params["from_date"].present?&&params["to_date"].present?&&params["status"] != "Approved" and params["status"].present?
    @datewise_filter=ClaimIssue.where(cut_off_date:(params["from_date"]..params["to_date"]),status:params["status"],approval:nil).order(created_at: :desc).as_json(include: [:contact,:appointment=>{include: :app_contact}])
  elsif params["from_date"].present?&&params["to_date"].present?&& params["status"] == "Approved"
    @datewise_filter=ClaimIssue.where(cut_off_date:(params["from_date"]..params["to_date"]),approval: true).order(created_at: :desc).as_json(include: [:contact,:appointment=>{include: :app_contact}])
  elsif  params["from_date"].present?&&params["to_date"].present?&&params["status"].empty?
    @datewise_filter=ClaimIssue.where(cut_off_date:(params["from_date"]..params["to_date"]),approval: true).order(created_at: :desc).as_json(include: [:contact,:appointment=>{include: :app_contact}])
  else
    @datewise_filter=ClaimIssue.where(status:params["status"],approval:nil).order(created_at: :desc).as_json(include: [:contact,:appointment=>{include: :app_contact}])
  end
  render json: @datewise_filter
end
# it is used to filter the approved claims in approved claim
def approved_claims
  @claims=ClaimIssue.where(approval:true).as_json(include: :contact)
  render json: @claims
end
# its is used to display approved claim  with date filter
def approved_claims_filter
  if params["date"].present?
    @claims=ClaimIssue.where(approval:true,cut_off_date:params[:date]).as_json(include: :contact)
  else
    @claims=ClaimIssue.where(approval:true).as_json(include: :contact)
  end
  render json: @claims
end
# the below method is used to display the selected expiry damage claim
def expiry_damage_claim_no
  data=ExpiryDamage.where(:claim_no=>params[:claim_no],:supplier_id=>params[:supplier_id]).as_json(:include=> [:product,:adjustments,:supplier=>{:only=>[:supplier_name, :expiry_broken]}])
  render json: data
end  
# the below method is used to display the selected free and discount claim
def free_discount_claim_no
  data=FreeDiscount.where(:claim_no=>params[:claim_no],:supplier_id=>params[:supplier_id]).as_json(include: [:product,:supplier,:adjustments])
  render json: data
end  
# the below method is used to display the selected ratechange claim
def purchase_return_claim_no
 data=PurchaseReturn.where(:claim_no=>params[:claim_no],:supplier_id=>params[:supplier_id]).as_json(:include=> [:product,:adjustments,:supplier=>{:only=>[:supplier_name, :expiry_broken]}])
 render json: data
end  

def rate_change_claim_no
 data=RateChange.where(:claim_number=>params[:claim_no],:supplier_id=>params[:supplier_id]).as_json(:include=> [:product,:adjustments,:supplier=>{:only=>[:supplier_name, :expiry_broken]}])
 render json: data
end  

def non_findable_claim_no
 data=NonFindableClaim.where(:claim_no=>params[:claim_no],:supplier_id=>params[:supplier_id]).as_json(:include=> [:product,:adjustments,:supplier=>{:only=>[:supplier_name, :expiry_broken]}])
 render json: data
end  
# the below method is used to display 
def purchase_return_update
  params.permit!
  ids=params["ids"]
  credit_amount=params["credit_amount"]
  credit_number=params["credit_num"]
  credit_date=params["credit_date"]
  remark=params["remarks"]
  adjust_quantity=params["adjust_quantity"]
  actual_amount=params["actual_amount"]
  (0..(ids.count-1)).map{|i| Adjustment.create(credit_amount: credit_amount[i], credit_note_num: credit_number[i], credit_date: credit_date[i], remark: remark[i], claim_product_type: "PurchaseReturn", claim_product_id: ids[i],actual_amount:actual_amount[i],adjust_quantity:adjust_quantity[i]); settle_amount=PurchaseReturn.find(ids[i]).settled_amount.to_f + credit_amount[i].to_f;purchase=PurchaseReturn.find(ids[i]); purchase.update(settled_amount: settle_amount);(purchase.claim_amount.to_f <= purchase.settled_amount.to_f) ? purchase.update(:amount_status=>1) : "" }
end
# the below method is used to adjust the expiry damage claim
def expiry_damage_update
  params.permit!
  ids=params["ids"]
  credit_amount=params["credit_amount"]
  credit_number=params["credit_num"]
  credit_date=params["credit_date"]
  remark=params["remarks"]
  adjust_quantity=params["adjust_quantity"]
  actual_amount=params["actual_amount"]
  (0..(ids.count-1)).map{|i| Adjustment.create(credit_amount: credit_amount[i], credit_note_num: credit_number[i], credit_date: credit_date[i], remark: remark[i], claim_product_type: "ExpiryDamage", claim_product_id: ids[i],adjust_quantity:adjust_quantity[i],actual_amount:actual_amount[i]); settle_amount=ExpiryDamage.find(ids[i]).settled_amount.to_f + credit_amount[i].to_f;expiry=ExpiryDamage.find(ids[i]);expiry.update(settled_amount: settle_amount); (expiry.claim_amount.to_f <= expiry.settled_amount.to_f) ? expiry.update(:amount_status=>1) : "" }
end
# the below method is used to adjust the free and discount claim
def free_discount_update
  params.permit!
  ids=params["ids"]
  credit_amount=params["credit_amount"]
  credit_number=params["credit_num"]
  credit_date=params["credit_date"]
  remark=params["remarks"]
  adjust_quantity=params["adjust_quantity"]
  actual_amount=params["actual_amount"]
  (0..(ids.count-1)).map{|i| Adjustment.create(credit_amount: credit_amount[i], credit_note_num: credit_number[i], credit_date: credit_date[i], remark: remark[i], claim_product_type: "FreeDiscount", claim_product_id: ids[i],adjust_quantity:adjust_quantity[i],actual_amount:actual_amount[i]); settle_amount=FreeDiscount.find(ids[i]).settled_amount.to_f + credit_amount[i].to_f; free_discount=FreeDiscount.find(ids[i]); free_discount.update(settled_amount: settle_amount); (free_discount.claim_amount.to_f <= free_discount.settled_amount.to_f) ? free_discount.update(:amount_status=>1) : "" }
end
# the below method is used to adjust the ratechange claim
def rate_change_update
  params.permit!
  ids=params["ids"]
  credit_amount=params["credit_amount"]
  credit_number=params["credit_num"]
  credit_date=params["credit_date"]
  remark=params["remarks"]
  #adjust_quantity=params["adjust_quantity"]
  actual_amount=params["actual_amount"]
  (0..(ids.count-1)).map{|i| Adjustment.create(credit_amount: credit_amount[i], credit_note_num: credit_number[i], credit_date: credit_date[i], remark: remark[i], claim_product_type: "RateChange", claim_product_id: ids[i],actual_amount:actual_amount[i]); settle_amount=RateChange.find(ids[i]).settled_amount.to_f + credit_amount[i].to_f; rate_change=RateChange.find(ids[i]); rate_change.update(settled_amount: settle_amount); (rate_change.claim_amount.to_f <= rate_change.settled_amount.to_f) ? rate_change.update(:amount_status=>1) : "" }
end
# it used to filter the claim issues by status in issue report
def status_filter
  @status=ClaimIssue.where(status:params["status"]).as_json(include: :contact)
  render json: @status
end
# the below method is used to display the expiry damage report
def expiry_damage_claims
  data=[]
  expiry_filter_query = {amount_status: nil}
  expiry_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  expiry_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = ExpiryDamage.includes(:supplier).where(expiry_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "settled_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}
  render json: data
end

def free_discount_claims
  data=[]
  free_disc_filter_query = {amount_status: nil}
  free_disc_filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  free_disc_filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = FreeDiscount.includes(:supplier).where(free_disc_filter_query).group_by{|i| [i.claim_no, i.ack_date]}
  claims.map{|k, v| data << {"claim_no": k[0], "total_quantity": v.pluck(:quantity), "settled_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}
  render json: data
end
# the below method is used to display the purchase return claim report
def purchase_return_claims
  data=[]
  if params["supplier_id"].present? # &&params["from_date"]&&params["to_date"].present?
    claim_no=PurchaseReturn.where(supplier_id:params[:supplier_id],claim_date: params[:from_date].to_date..params[:to_date].to_date).pluck(:claim_no).uniq
  else
    claim_no=PurchaseReturn.where(claim_date: params[:from_date].to_date..params[:to_date].to_date).pluck(:claim_no).uniq
  end
  supplier_id = params[:supplier_id].present? ? params[:supplier_id] : PurchaseReturn.all.pluck(:supplier_id).uniq
  claim_no.map{|i| data << {"claim_no":i,"total_quantity":PurchaseReturn.where(claim_no: i).pluck(:quantity),"settled_amount": PurchaseReturn.where(claim_no:i,supplier_id: supplier_id).pluck(:ws_settle_amount),"claim_amount":PurchaseReturn.where(claim_no:i,supplier_id: supplier_id).pluck(:claim_amount),"data":PurchaseReturn.where(claim_no:i,supplier_id: supplier_id).as_json(include: {:supplier=>{only: :supplier_name}})}}
  render json: data
end
# the below method is used to display the ratechange claim report
def rate_change_claims
  data=[]
  filter_query = {amount_status: nil}
  filter_query.to_h.merge!({ack_date: (params[:from_date]..params[:to_date])}) if params[:from_date].present? && params[:to_date].present?
  filter_query.to_h.merge!({supplier_id: params[:supplier_id]}) if params[:supplier_id].present?
  claims = RateChange.includes(:supplier).where(filter_query).group_by{|i| [i.claim_number, i.ack_date]}
  claims.map{|k, v| data << {"claim_number": k[0], "total_quantity": v.pluck(:quantity), "settled_amount": v.pluck(:ws_settle_amount), "claim_amount": v.pluck(:claim_amount), "data": v.as_json(include: {:supplier=>{only: :supplier_name}})}}
  render json: data
end

def non_findable_claims
  data=[]
  if params["supplier_id"].present?    # && params["from_date"]&&params["to_date"].present?
    claim_no=NonFindableClaim.where(supplier_id:params[:supplier_id],ack_date: params[:from_date]..params[:to_date]).pluck(:claim_no).uniq
  else
    claim_no=NonFindableClaim.where(ack_date: params[:from_date]..params[:to_date]).pluck(:claim_no).uniq
  end
  supplier_id = params[:supplier_id].present? ? params[:supplier_id] : NonFindableClaim.all.pluck(:supplier_id).uniq
  claim_no.map{|i| data << {"claim_no":i,"total_quantity":NonFindableClaim.where(claim_no: i).pluck(:quantity),"settled_amount": NonFindableClaim.where(claim_no:i,supplier_id: supplier_id).pluck(:ws_settle_amount),"claim_amount":NonFindableClaim.where(claim_no:i,supplier_id: supplier_id).pluck(:claim_amount),"data":NonFindableClaim.where(claim_no:i,supplier_id: supplier_id).as_json(include: {:supplier=>{only: :supplier_name}})}}
  render json: data
end
# def expiry_damage_claims
#   data=[]
#   if params["supplier_id"].present?
#   claim_no=ExpiryDamage.where(supplier_id:params[:supplier_id]).pluck(:claim_no).uniq
#   else
#   claim_no=ExpiryDamage.all.pluck(:claim_no).uniq
#   end
#   claim_no.map{|i| data << {"claim_no":i,"total_quantity":ExpiryDamage.where(claim_no: i).pluck(:quantity),"settled_amount": ExpiryDamage.where(claim_no:i).pluck(:settled_amount),"claim_amount":ExpiryDamage.where(claim_no:i).pluck(:claim_amount),"data":ExpiryDamage.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
#   render json: data
# end
#the below method is used to display the free and discount report 
# def free_discount_claims
#   data=[]
#   if params["supplier_id"].present?
#     claim_no=FreeDiscount.where(supplier_id:params[:supplier_id]).pluck(:claim_no).uniq
#   else
#     claim_no=FreeDiscount.all.pluck(:claim_no).uniq
#   end
#   claim_no.map{|i| data << {"claim_no":i,"total_quantity":FreeDiscount.where(claim_no: i).pluck(:total_quantity),"settled_amount": FreeDiscount.where(claim_no:i).pluck(:settled_amount),"claim_amount":FreeDiscount.where(claim_no:i).pluck(:claim_amount),"data":FreeDiscount.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
#   render json: data
# end
# # the below method is used to display the purchase return claim report
# def purchase_return_claims
#   data=[]
#   if params["supplier_id"].present?
#     claim_no=PurchaseReturn.where(supplier_id:params[:supplier_id]).pluck(:claim_no).uniq
#   else
#     claim_no=PurchaseReturn.all.pluck(:claim_no).uniq
#   end
#   claim_no.map{|i| data << {"claim_no":i,"total_quantity":PurchaseReturn.where(claim_no: i).pluck(:quantity),"settled_amount": PurchaseReturn.where(claim_no:i).pluck(:settled_amount),"claim_amount":PurchaseReturn.where(claim_no:i).pluck(:claim_amount),"data":PurchaseReturn.where(claim_no:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
#   render json: data
# end
# # the below method is used to display the ratechange claim report
# def rate_change_claims
#   data=[]
#   if params["supplier_id"].present?
#     claim_no=RateChange.where(supplier_id:params[:supplier_id]).pluck(:claim_number).uniq
#   else
#     claim_no=RateChange.all.pluck(:claim_number).uniq
#   end
#   claim_no.map{|i| data << {"claim_no":i,"total_quantity":RateChange.where(claim_number: i).pluck(:quantity),"settled_amount": RateChange.where(claim_number:i).pluck(:settled_amount),"claim_amount":RateChange.where(claim_number:i).pluck(:claim_amount),"data":RateChange.where(claim_number:i).as_json(include: {:supplier=>{only: :supplier_name}})}}
#   render json: data
#end
#the below method is used to filter the claim issues
def status_filter
  @status=ClaimIssue.where(status:params["status"]).as_json(include: :contact)
  render json: @status
end
# the below method is used to enter the wondersoft data count to verify the sync is completed or missed some items
def edit_reports 
  @report= ReportDetail.find_by(report_date:params[:report_date])
  if @report.present?
    @report.update(purchase_order_count: params[:purchase_order_count], purchase_order_reason: params[:purchase_order_reason], purchase_order_email_reason: params[:purchase_order_email_reason],
      expiry_broken_count: params[:expiry_broken_count], expiry_broken_reason: params[:expiry_broken_reason], expiry_broken_email_reason: params[:expiry_broken_email_reason],
       free_discount_count: params[:free_discount_count], free_discount_reason: params[:free_discount_reason], free_discount_email_reason: params[:free_discount_email_reason],
        purchase_return_count: params[:purchase_return_count], purchase_return_reason: params[:purchase_return_reason], purchase_return_email_reason: params[:purchase_return_email_reason], 
        rate_change_count: params[:rate_change_count], rate_change_reason: params[:rate_change_reason], rate_change_email_reason: params[:rate_change_email_reason], 
        excess_stock_count: params[:excess_stock_count], excess_stock_reason: params[:excess_stock_reason], excess_stock_email_reason: params[:excess_stock_email_reason], 
        pogr_count: params[:pogr_count], pogr_reason: params[:pogr_reason], pogr_email_reason: params[:pogr_email_reason], appointment_count: params[:appointment_count], 
        appointment_reason: params[:appointment_reason], appointment_email_reason: params[:appointment_email_reason], claim_issue_count: params[:claim_issue_count], 
        claim_issue_reason: params[:claim_issue_reason], claim_issue_email_reason: params[:claim_issue_email_reason], inbox_count: params[:inbox_count], 
        inbox_reason: params[:inbox_reason], inbox_email_reason: params[:inbox_email_reason], non_findable_claim_count: params[:non_findable_claim_count], 
        non_findable_claim_reason: params[:non_findable_claim_reason], non_findable_claim_email_reason: params[:non_findable_claim_email_reason], report_date: params[:report_date]
      )
   render json: true
  else
    report=ReportDetail.create(purchase_order_count: params[:purchase_order_count], purchase_order_reason: params[:purchase_order_reason], purchase_order_email_reason: params[:purchase_order_email_reason],
      expiry_broken_count: params[:expiry_broken_count], expiry_broken_reason: params[:expiry_broken_reason], expiry_broken_email_reason: params[:expiry_broken_email_reason],
       free_discount_count: params[:free_discount_count], free_discount_reason: params[:free_discount_reason], free_discount_email_reason: params[:free_discount_email_reason],
        purchase_return_count: params[:purchase_return_count], purchase_return_reason: params[:purchase_return_reason], purchase_return_email_reason: params[:purchase_return_email_reason], 
        rate_change_count: params[:rate_change_count], rate_change_reason: params[:rate_change_reason], rate_change_email_reason: params[:rate_change_email_reason], 
        excess_stock_count: params[:excess_stock_count], excess_stock_reason: params[:excess_stock_reason], excess_stock_email_reason: params[:excess_stock_email_reason], 
        pogr_count: params[:pogr_count], pogr_reason: params[:pogr_reason], pogr_email_reason: params[:pogr_email_reason], appointment_count: params[:appointment_count], 
        appointment_reason: params[:appointment_reason], appointment_email_reason: params[:appointment_email_reason], claim_issue_count: params[:claim_issue_count], 
        claim_issue_reason: params[:claim_issue_reason], claim_issue_email_reason: params[:claim_issue_email_reason], inbox_count: params[:inbox_count], 
        inbox_reason: params[:inbox_reason], inbox_email_reason: params[:inbox_email_reason], non_findable_claim_count: params[:non_findable_claim_count], 
        non_findable_claim_reason: params[:non_findable_claim_reason], non_findable_claim_email_reason: params[:non_findable_claim_email_reason], report_date: params[:report_date])
    render json: true
  end
 #result = params["data"].keys.zip params["data"].values
 #result.map { |k,v| ReportDetail.find_by(module: k).present? ? ReportDetail.update(module: k,wondersoft_count:v) : ReportDetail.create(module: k,wondersoft_count:v)}
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_claim
    @claim = Claim.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def claim_params
    params.require(:claim).permit(:claim_no,:type_of_claim,:claim_date,:product_code,:expiry_date,:quantity,:claim_amount,:settled_amount,:bill_date,:bill_number,:status,:supplier_code,:supplier_id)
  end
end
