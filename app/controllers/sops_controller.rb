class SopsController < ApplicationController
  before_action :set_sop, only: [:show, :update, :destroy]
# display all divisions sop rules. it is an standard rule for division
  # GET /sops
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sops Index"
   begin
     if params["division_id"].present?
      #@sops =Sop.where(division_id:params["division_id"]).as_json(include: [:division=>{include: [:manufacturer=>{include: [:supplier=>{only: :supplier_name}]}]}])
      @sops =Sop.where(division_id:params["division_id"]).as_json(include: [:division,:supplier])
    else
     #@sops =Sop.all.as_json(include: [:division=>{include: [:manufacturer=>{include: [:supplier=>{only: :supplier_name}]}]}])
     @sops =Sop.all.as_json(include: [:division,:supplier])
    end

    render json: @sops
    rescue => e
      Rails.logger.custom_log.error { "#{e} sops_controller index method" }
     end
  end
# show the selected sop
  # GET /sops/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sops show page"
  begin
    render json: @sop.as_json(include: :division)
    rescue =>e
   Rails.logger.custom_log.error { "#{e} sops_controller show method" }
  end
  end
# its is used to create new rule for new division
  # POST /sops
  def create
    
    
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the sops create button"
    begin
      @sop = Sop.new(sop_params)
    if @sop.save
      
      @app1=Appointment.create(app_contact_id: @sop["division_id"],:app_contact_type=>"Division",:appoint_date=>@sop["monthly_appoinment1"],appoint_time: @sop["appoint_time1"],supplier_id:@sop["supplier_id"])
      Appointment.create(app_contact_id:@app1["app_contact_id"],app_contact_type:@app1['app_contact_type'],appoint_date:@app1["appoint_date"]+1.month,appoint_time: @app1["appoint_time"],supplier_id:@app1["supplier_id"])                       
      @app2=ppointment.create(app_contact_id: @sop["division_id"],:app_contact_type=>"Division",:appoint_date=>@sop["monthly_appoinment2"],appoint_time: @sop["appoint_time2"],supplier_id:@sop["supplier_id"])
      Appointment.create(app_contact_id:@app2["app_contact_id"],app_contact_type:@app2['app_contact_type'],appoint_date:@app2["appoint_date"]+1.month,appoint_time: @app2["appoint_time"],supplier_id:@app2["supplier_id"])                       
    unless @sop.monthly_appoinment3 == nil
       @app3=Appointment.create(app_contact_id: @sop["division_id"],:app_contact_type=>"Division",:appoint_date=>@sop["monthly_appoinment3"],appoint_time: @sop["appoint_time3"],supplier_id:@sop["supplier_id"])
       Appointment.create(app_contact_id:@app3["app_contact_id"],app_contact_type:@app3['app_contact_type'],appoint_date:@app3["appoint_date"]+1.month,appoint_time: @app3["appoint_time"],supplier_id:@app3["supplier_id"])                       
     end  
      render json: @sop, status: :created, location: @sop
    else
      render json: @sop.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sops created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} sops_controller create method" }
   end
  end
# update the selected sop values
  # PATCH/PUT /sops/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the sops update button"
    begin
    if @sop.update(sop_params)
      render json: @sop
    else
      render json: @sop.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sops Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} sops_controller update method" }
    end
  end
# update the issue status in claim issues
  def issues_update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the sops issues_update"
    begin
   params.permit!
   ids=params["ids"]
   approval=params["approval"]
   status=params["status"]
   remarks=params["remarks"]
   (0..ids.count-1).map{|i| ClaimIssue.find(ids[i]).update(:status=>status[i],:remarks=>remarks[i])}
   approval.map{|i| ClaimIssue.find(i).update(:approval=>true)}

   render json: true
   rescue =>e
    Rails.logger.custom_log.error { "#{e} sops_controller issues_update method" }
    end
  end  
# display the sop by selecting division

  def dynamic_sop
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sops dynamic_sop"
    begin
   data=Sop.where(:division_id=>params["division_id"])
   render json: data
   rescue =>e
    Rails.logger.custom_log.error { "#{e} sops_controller dynamic_sop method" }
    end
  end  
# delete the sop
  # DELETE /sops/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in sops Delete"
    begin
    @sop.destroy
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : sops Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} #sops_controller delete method" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sop
      @sop = Sop.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sop_params
      params.require(:sop).permit(:order_type,:payment_term,:special_offer,:claims_offer,:expiry_broken_settlement,:delivery_order_schedule,:monthly_appoinment1,:monthly_appoinment2,:monthly_appoinment3,:dispatch_mode,:current_ns,:current_ms,:division_id,:supplier_id,:appoint_time1,:appoint_time2,:appoint_time3)
    end
end
