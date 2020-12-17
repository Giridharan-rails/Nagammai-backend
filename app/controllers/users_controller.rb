class UsersController < ApplicationController
before_action :set_user, only: [:show, :update, :destroy]
# display all users in index page
  # GET /users
def index
 Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in users_controller index method"
begin   
@users = User.all.order('user_name ASC')
 render json: @users
unless @users.present?
Rails.logger.debug_log.debug { "#{"user data not available"}"}
end
rescue =>e
 Rails.logger.custom_log.error { "#{e} users_controller index  method" }
end
  end
# display selected user details
  # GET /users/1
 def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in users_controller Show method"
        
    render json: @user
    unless @users.present?
   Rails.logger.debug_log.debug { "#{"user data not available"}"}
   end

  end
# create new user with two roler
  # POST /users
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the user create button"
    begin
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
    unless @users.present?
    Rails.logger.debug_log.debug { "#{"user data not available"}"}
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : user created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} user_controller create method" }
   end
  end
# update the selected users
  # PATCH/PUT /users/1
  def update
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the user update button"
    begin
     if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
    unless @users.present?
   Rails.logger.debug_log.debug { "#{"user data not available"}"}
   end
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : user Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} user_controller update method" }
    end
  end
# dash board we are display pending claims and todays po and chart details for last twelve  month pending claim amount
def dashboard
@claim_count=ExpiryDamage.where(amount_status:nil).count+FreeDiscount.where(amount_status:nil).count+RateChange.where(amount_status:nil).count+PurchaseReturn.where(amount_status:nil).count
@claim_amount=(ExpiryDamage.where(amount_status:nil).pluck(:claim_amount).map{|i| i.to_f}.sum -ExpiryDamage.where(amount_status:nil).pluck(:settled_amount).map{|i| i.to_f}.sum)+(FreeDiscount.where(amount_status:nil).pluck(:claim_amount).map{|i| i.to_f}.sum  - FreeDiscount.where(amount_status:nil).pluck(:settled_amount).map{|i| i.to_f}.sum )+(RateChange.where(amount_status:nil).pluck(:claim_amount).map{|i| i.to_f}.sum - RateChange.where(amount_status:nil).pluck(:settled_amount).map{|i| i.to_f}.sum)+ (PurchaseReturn.where(amount_status:nil).pluck(:claim_amount).map{|i| i.to_f}.sum - PurchaseReturn.where(amount_status:nil).pluck(:settled_amount).map{|i| i.to_f}.sum)
@adjustment_count=Adjustment.where("credit_date>=?",Date.today.beginning_of_month).count
@adjustment_amount=Adjustment.where("credit_date>=?",Date.today.beginning_of_month).pluck(:credit_amount).map{|i| i.to_f}.sum
@month=(0..11).map{|i| Date.today.end_of_month - i.month}
@amount=@month.map{|i| (RateChange.where("ack_date <= ?",i).pluck(:claim_amount).map{|j| j.to_f}.sum +PurchaseReturn.where("claim_date <= ?",i).pluck(:claim_amount).map{|j| j.to_f}.sum+FreeDiscount.where("ack_date <= ?",i).pluck(:claim_amount).map{|j| j.to_f}.sum+ExpiryDamage.where("ack_date <= ?",i).pluck(:claim_amount).map{|j| j.to_f}.sum)-  Adjustment.where(:credit_date=>i.beginning_of_month .. i).pluck(:credit_amount).map{|j| j.to_f}.sum}.reverse
data= {"claim_count":@claim_count,"claim_amount":@claim_amount,"adjustment_count":@adjustment_count,"adjustment_amount":@adjustment_amount,"POs":PurchaseOrder.where(:order_date=>Date.today).pluck(:order_no).uniq.count,"total_products":PurchaseOrder.where(:order_date=>Date.today).count,"total_quantity":PurchaseOrder.where(:order_date=>Date.today).pluck(:order_no).uniq.count,"total_products":(PurchaseOrder.where(:order_date=>Date.today).pluck(:free_qty).map{|i| i.to_i}.sum+PurchaseOrder.where(:order_date=>Date.today).pluck(:quantity).map{|i| i.to_i}.sum),"amount":@amount}
render json: data

end
# delete selected user
  # DELETE /users/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in user Delete"
    begin
    @user.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : user Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} user_controller user_delete method" }
    end
  end
# assign user to supplier
  def supplier_update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in user supplier Delete"
    begin
   user=User.find(params[:user][:id]).update(:supplier_id=>params[:user][:supplier_id])
  render json: user
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : user_supplier Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} user_controller supplier_delete method" }
    end
  end  
# used to login the users
def login
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in user login"
    begin
 @user=User.find_by(email:params[:user][:email],password:params[:user][:password])

  if @user.present?
     render json: @user
  else
    render json: nil
 end
  rescue =>e
      Rails.logger.custom_log.error { "#{e} user_controller login method" }
    end
end
# used for change the password
def change_password
   @user=User.where(:id=>params[:id],:password=>params["old_password"])
   if @user.present?
     User.find(params[:id]).update(:password=>params[:new_password])
    render json: {"message"=>"Successfully Updated"}
  else
    render json: {"message"=>"Current Password Incorrect"}
  end  
end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:user_name, :password, :email, :role, :supplier)
    end
end
