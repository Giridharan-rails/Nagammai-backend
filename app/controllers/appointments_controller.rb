
class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :destroy]

  # GET /appointments
  def index   # to display all the appointents in appintment screen
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in appointments index method"
      
      @appointments =Appointment.all.as_json(include: :sub_contact)
  
      render json: @appointments
    
    
  
  end

  # GET /appointments/1
  def show # this methos is to show the specific
   Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in appointments show method"
   begin
        @appoint=@appointment.as_json(include: :claim_issues)
        if @appointment.app_contact_type == "Supplier"

         @appoint["supplier_id"]=@appointment.app_contact_id

      elsif @appointment.app_contact_type == "Manufacturer"
         @appoint["manufacturer_id"]=@appointment.app_contact_id
         @appoint["supplier_id"] = @appointment.app_contact.divisions.first.products.first.supplier.id
      else
         @appoint["division_id"]=@appointment.app_contact_id
         @appoint["supplier_id"]=@appointment.supplier_id
         #@appoint["manufacturer_id"]=Division.find(@appointment.app_contact_id).manufacturer.id
         #@appoint["supplier_id"] = Manufacturer.find_by(id:@appoint["manufacturer_id"]).supplier_id

       end  

       render json: @appoint
    rescue =>e
#       Rails.logger.custom_log.error { "#{e} #{appointment_controller show method}" }     
    end
  end

  # POST /appointments
  def create  # this method is to create appointments and also create issues for this appointments
    #Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in appointments create method"
    #begin
    
     params.permit!

      @appointment = Appointment.new(appointment_params)
      @appointment["app_contact_type"] = params[:additional][:app_contact_type] 
      @appointment["app_contact_id"] = params[:additional][:app_contact_id] 
       @appointment["supplier_id"] = params[:additional]["supplier_id"] 
       if @appointment.save
        if @appointment["appoint_date"].to_date.strftime('%m')==Date.today.to_date.strftime('%m')

          Appointment.create(appoint_date:@appointment["appoint_date"]+1.month, appoint_time:@appointment["appoint_time"], contacts_ids: @appointment["contacts_ids"], appoint_note: @appointment["appoint_note"], app_contact_id:@appointment["app_contact_id"],app_contact_type: @appointment["app_contact_type"], mail_status: @appointment["mail_status"], supplier_id:@appointment["supplier_id"])
        end
     
        unless  params[:claim_issue][:description] == [""] && params[:claim_issue][:contact_id] == [""]
         
          (0..params[:claim_issue][:description].count-1).map{|i|  ClaimIssue.create(description: params[:claim_issue][:description][i], contact_id: params[:claim_issue][:contact_id][i], cut_off_date: params[:claim_issue][:cut_off_date][i],status: params[:claim_issue][:status][i],notes: params[:claim_issue][:notes][i], appointment_id: @appointment.id)}
        
        end   
         
        render json: @appointment, status: :created, location: @appointment
      
      else
        p "=======================#{@appointment.errors.full_messages}"
        
        render json: @appointment.errors, status: :unprocessable_entity
      
      end
  #  rescue =>e
   #   Rails.logger.custom_log.error { "#{e} #{appointment_controller create method}" }     
   # end
     
  end

  # PATCH/PUT /appointments/1
  def update  # this method not used anywhere

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in appointments cfa_update method"
 
    begin
    
      if @appointment.update(appointment_params)
        
        render json: @appointment
    
      else
      
        render json: @appointment.errors, status: :unprocessable_entity
    
      end
      
      Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : appointment_updated successfully"

      rescue =>e
     
        Rails.logger.custom_log.error { "#{e} #{appointment_controller cfa_update method}" }
  
      end
  end

  # DELETE /appointments/1
  def destroy  # this method is used to delete the appointment maximum delete operation not used
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in appointments cfa_update method"
     begin
     @appointment.destroy
     rescue =>e
     Rails.logger.custom_log.error { "#{e} #{appointments_controller destroy method}" }
     end
  end

 def claim_issues   #this method is to display not appproved claims 

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in appointments claim_issues method"
    
    begin
  
    claim=ClaimIssue.where(approval: nil).order(created_at: :desc).as_json(include: [:contact,:appointment=>{include: :app_contact}])
 
    render json: claim

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : appointment_claim_issue"

    rescue =>e
    
     Rails.logger.custom_log.error { "#{e} #{appointments_controller appointment_update method}" }
  
    end

 end 

 def appointment_index #appointments display with today's date filters
    data=[]
       
    #  data=Appointment.all.as_json(include: :app_contact)#.map{|i| data << { "division"=>i.division.name,"manufacturer"=>i.division.manufacturer.name,"supplier"=>i.division.manufacturer.supplier.name,"date"=>i.appoint_date,"contact_name"=>Contact.where(:id=>i.contacts_ids).pluck(:name),:id=>i.id,"appointment_note"=>i.appoint_note,"appointment_time"=>i.appoint_time} }
 
    @appoint=Appointment.where(:appoint_date=>Date.today)

  if @appoint.present?

    @appoint.map do|i|
      if i.contacts_ids.present?
      contactsss=Contact.where(:id=>i.contacts_ids.split(",")).pluck(:name).join(",")
      end
     data1 = {"id"=>i.id,"appoint_note"=>i.appoint_note,"appoint_date"=>i.appoint_date, "appoint_time"=>i.appoint_time,"app_contact_type"=>i.app_contact_type,"contacter_table_name"=>contactsss}

     @supplier_contact=[]
     if i.app_contact_type=="Supplier"

       data1["contact_name"]=Supplier.find(i.app_contact_id).supplier_name

       User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?((i.app_contact_id).to_s) == true}

      elsif i.app_contact_type=="Manufacturer"

        data1["contact_name"]=Manufacturer.find(i.app_contact_id).manufacturer_name

        supplier_id=Manufacturer.find(i.app_contact_id).divisions.first.products.first.supplier_id

        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true}

      elsif i.app_contact_type=="Division"

        data1["contact_name"]=Division.find(i.app_contact_id).div_name

        supplier_id=Division.find(i.app_contact_id).products.first.supplier_id

        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true}

     end
      data1["supplier_contact"]=@supplier_contact.flatten.compact.uniq
      data << data1


    end
  end  

      render json: data  
 end 


def appointment_update # in this method is to update appointments and issues

  appoint_data=params["appointment"]
  Appointment.find(appoint_data["appointment_id"]).update("appoint_date"=>appoint_data["appoint_date"], "appoint_time"=>appoint_data["appoint_time"], "contacts_ids"=>appoint_data["contacts_ids"], "appoint_note"=>appoint_data["appoint_note"],"app_contact_type"=>params["additional"]["app_contact_type"],"app_contact_id"=>params["additional"]["app_contact_id"],supplier_id:params["additional"]["supplier_id"])
  if params["claim_issue"]["issue_ids"] != nil
   issue_count=params["claim_issue"]["issue_ids"].count
    if issue_count != 0
      new_ids=params["claim_issue"]["issue_ids"].map(&:to_i)
      old_ids=ClaimIssue.where(appointment_id: appoint_data["appointment_id"]).ids
      ClaimIssue.where(:id=>(old_ids-new_ids)).delete_all
     (0..issue_count-1).map{|i| ClaimIssue.find(params["claim_issue"]["issue_ids"][i]).update(description: params[:claim_issue][:description][i], contact_id: params[:claim_issue][:contact_id][i],:notes=>params[:claim_issue][:notes][i], cut_off_date: params[:claim_issue][:cut_off_date][i],status: params[:claim_issue][:status][i], appointment_id: appoint_data["appointment_id"])}
     desc=params["claim_issue"]["description"]
     contact_id=params["claim_issue"]["contact_id"]
     cutt_off=params["claim_issue"]["cut_off_date"]
     notes=params["claim_issue"]["notes"]
     status=params["claim_issue"]["status"]
     desc.shift(issue_count)
     contact_id.shift(issue_count)
     cutt_off.shift(issue_count)
     status.shift(issue_count)
      if desc.count != 0
         (0..desc.count-1).map{|i| ClaimIssue.create(description: desc[i], contact_id: contact_id[i], cut_off_date: cutt_off[i],notes: notes[i],status: status[i], appointment_id: appoint_data["appointment_id"])}
      end
    end   
  elsif params["claim_issue"]["description"].count != 0
       (0..params["claim_issue"]["description"].count-1).map{|i| ClaimIssue.create(description: params["claim_issue"]["description"][i], contact_id: params["claim_issue"]["contact_id"][i], cut_off_date: params["claim_issue"]["cut_off_date"][i], appointment_id: appoint_data["appointment_id"],:notes=>params["claim_issue"]["notes"][i],status: params["claim_issue"]["status"][i])}
  end

end  


 def issue_for_alert  # it display the issues which have cut off date today as notification in header
  data=ClaimIssue.where(:cut_off_date=>Date.today)
  render json:data
 end

 def appointment_for_alert # It display the todays appointments as notification in header
  
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in appointments appointment_for_alert method"
    
    begin
  
    data=[]
    Appointment.where(appoint_date:Date.today).map do |i|
    hash={}
    hash["appoint"]=i
    hash["contact"]=Contact.where(id:i["contacts_ids"])
    hash["type"]=i.app_contact
    data << hash
    end
    render json: data
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : appointment_appointment_for_alert"

    rescue =>e
    
     Rails.logger.custom_log.error { "#{e} #{appointments_controller appointment_for_alert method}" }
  
    end
 
 end
# we have three different contact peoples they are supplier,manufacture and divisions.so this method is to filter the contact wise appointments
 def supplier_histroy   
  @histroy=[]
  if params["supplier_id"].present?
     @histroy = Appointment.where(app_contact_type:"Supplier",app_contact_id:params["supplier_id"])
  elsif params["manufacturer_id"].present?
     @histroy = Appointment.where(app_contact_type:"Manufacturer",app_contact_id:params["manufacturer_id"])
  elsif params["division_id"].present?
     @histroy = Appointment.where(app_contact_type:"Division",app_contact_id:params["division_id"])
   end
   @output=[]
   if @histroy.present? 

   @histroy.map {|i| @output<< { "appointment"=>i.as_json(include: :app_contact),"contacts"=>Contact.where(:id=>(i.contacts_ids != nil) ? i.contacts_ids.split(",") : nil)}} if @histroy.present?
  end 
  
   render json: @output

 end

# the below method is used in appointment create,edit and show page to display the pending claims of selected supplier,manufacture and divisions
 def appointment_pending_claims
   @result=[]
  if params["manufacturer_id"].present?  
   if Manufacturer.find(params["manufacturer_id"]).divisions.present?
      Manufacturer.find(params["manufacturer_id"]).divisions.map do |division|
       if division.products.present?
         division.products.map do |product|
             if product.expiry_damages.present?
                 product.expiry_damages.map do |j|
                   @result << {"claim_no"=>j.claim_no,"claim_type"=>"Expiry Damage","claim_amount"=>j.claim_amount,"settled_amount"=>j.settled_amount}
                 end
             end
             
             if product.free_discounts.present?
                product.free_discounts.map do |j| 
                  @result << {"claim_no"=>j.claim_no,"claim_type"=>"Free Discounts","claim_amount"=>j.claim_amount,"settled_amount"=>j.settled_amount}
                end
             end
             if product.rate_changes.present?
                product.rate_changes.map do |j|
                  @result << {"claim_no"=>j.claim_number,"claim_type"=>"Rate Changes","claim_amount"=>j.claim_amount,"settled_amount"=>j.settled_amount}
                end
             end
             if product.purchase_returns.present?
                product.purchase_returns.map do |j| 
                 @result << {"claim_no"=>j.claim_no,"claim_type"=>"Purchase Return","claim_amount"=>j.claim_amount,"settled_amount"=>j.settled_amount}
               end
             end

         end    
       end
      end 
   end
  else
    if Division.find(params[:division_id]).products.present?
       Division.find(params[:division_id]).products.map do |product|
             if product.expiry_damages.present?
                 product.expiry_damages.map do |j|
                   @result << {"claim_no"=>j.claim_no,"claim_type"=>"Expiry Damage","claim_amount"=>j.claim_amount,"settled_amount"=>j.settled_amount}
                 end
             end
       end
    end       
  end

                     
   render json: @result
 end 
# the below mwthod is used to display only the manufacturer pending claims in create and edit page while selecting those items in dropdown
 def manufacturer_appointment_issue
   appoint_ids=Appointment.where(app_contact_id: params["manufacturer_id"], app_contact_type: "Manufacturer").ids
   claims=ClaimIssue.where(:appointment_id=>appoint_ids).as_json(include: :contact)
   render json: claims
 end
# the below method is used to display only the divisions pending claims in create and edit page while selecting those items in dropdown
 def division_appointment_issue
  appoint_ids=Appointment.where(app_contact_id: params["division_id"], app_contact_type: "Division").ids
  claims=ClaimIssue.where(:appointment_id=>appoint_ids).as_json(include: :contact)
  render json: claims
end

# the below method is used for appointment index page to display the appointment by different filters(date,contact types supplier,manufacturer and division)
def appoint_filter
  if params["data"].present?

  if params["type_base"] == "" && params["from_date"] != ""
    @claims=Appointment.where(appoint_date: params["from_date"]..params["to_date"]).pluck(:id)
    @data=ClaimIssue.where(appointment_id:@claims,notes: "").as_json(include: :appointment)
  elsif params["from_date"] != "" && params["type_base"] != ""
   @claims=Appointment.where(appoint_date: params["from_date"]..params["to_date"]).where(:app_contact_type=>params["type_base"]).pluck(:id)
   @data=ClaimIssue.where(appointment_id:@claims,notes:"").as_json(include: :appointment)
  elsif params["type_base"] != "" && params["from_date"] == ""
    @claims=Appointment.where(:app_contact_type=>params["type_base"]).pluck(:id)
    @data=ClaimIssue.where(appointment_id:@claims,notes: "").as_json(include: :appointment)
  else
     @data=Appointment.where(:appoint_date=>Date.today)  
  end
        data=[]
       
    @data.map do|i|
      if i["appointment"]["contacts_ids"].present?
      contactsss=Contact.where(:id=>i["appointment"]["contacts_ids"].split(",")).pluck(:name).join(",")
      end
     data1 = {"id"=>i["appointment"]["id"],"appoint_note"=>i["appointment"]["appoint_note"],"appoint_date"=>i["appointment"]["appoint_date"], "appoint_time"=>i["appointment"]["appoint_time"],"app_contact_type"=>i["appointment"]["app_contact_type"],"appoint_note"=>i["appointment"]["appoint_note"],"contacter_table_name"=>contactsss}

     @supplier_contact=[]
     if i["appointment"]["app_contact_type"]=="Supplier"

       data1["contact_name"]=Supplier.find(i["appointment"]["app_contact_id"]).supplier_name

       User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?((i.app_contact_id).to_s) == true} 

      elsif i["appointment"]["app_contact_type"]=="Manufacturer"

        data1["contact_name"]=Manufacturer.find(i["appointment"]["app_contact_id"]).manufacturer_name

        supplier_id=Manufacturer.find(i["appointment"]["app_contact_id"]).divisions.first.products.first.supplier_id

        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true} 

      elsif i["appointment"]["app_contact_type"]=="Division"

        data1["contact_name"]=Division.find(i["appointment"]["app_contact_id"]).div_name

        #supplier_id=Division.find(i["appointment"]["app_contact_id"]).products.first.supplier_id
          supplier_id=Appointment.find(i["id"]).supplier_id
        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true} 

     end
      data << data1
    end

else
  if params["type_base"] == "" && params["from_date"] != ""
    @data=Appointment.where(appoint_date: params["from_date"]..params["to_date"])
  elsif params["from_date"] != "" && params["type_base"] != ""
   @data=Appointment.where(appoint_date: params["from_date"]..params["to_date"]).where(:app_contact_type=>params["type_base"])
  elsif params["type_base"] != "" && params["from_date"] == ""
    @data=Appointment.where(:app_contact_type=>params["type_base"])
  else
     @data=Appointment.where(:appoint_date=>Date.today)  
  end


      data=[]
       
    @data.map do|i|

      
      if i.contacts_ids.present?
      contactsss=Contact.where(:id=>i.contacts_ids.split(",")).pluck(:name).join(",")
      end
     data1 = {"id"=>i.id,"appoint_note"=>i.appoint_note,"appoint_date"=>i.appoint_date, "appoint_time"=>i.appoint_time,"app_contact_type"=>i.app_contact_type,"appoint_note"=>i.appoint_note,"contacter_table_name"=>contactsss}

     @supplier_contact=[]
     if i.app_contact_type=="Supplier"

       data1["contact_name"]=Supplier.find(i.app_contact_id).supplier_name

       User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?((i.app_contact_id).to_s) == true} 

      elsif i.app_contact_type=="Manufacturer"

        data1["contact_name"]=Manufacturer.find(i.app_contact_id).manufacturer_name

        supplier_id=Manufacturer.find(i.app_contact_id).divisions.first.products.first.supplier_id

        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true} 

      elsif i.app_contact_type=="Division"

        data1["contact_name"]=Division.find(i.app_contact_id).div_name

        #supplier_id=Division.find(i.app_contact_id).products.first.supplier_id
        supplier_id=Appointment.find(i.id).supplier_id

        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true} 

     end
      data1["supplier_contact"]=@supplier_contact.flatten.compact.uniq
      data << data1
    end
    end
      

render json: data
end  
# the below method is used to display the appointments which are not made at schedule time.which are founded using appoint_note filed nil

def pending_appointment  
        data=[]
       
    #  data=Appointment.all.as_json(include: :app_contact)#.map{|i| data << { "division"=>i.division.name,"manufacturer"=>i.division.manufacturer.name,"supplier"=>i.division.manufacturer.supplier.name,"date"=>i.appoint_date,"contact_name"=>Contact.where(:id=>i.contacts_ids).pluck(:name),:id=>i.id,"appointment_note"=>i.appoint_note,"appointment_time"=>i.appoint_time} }
 
    @appoint=ClaimIssue.where(:notes=>"").as_json(include: :appointment)

  if @appoint.present?

    @appoint.map do|i|
      if i["appointment"]["contacts_ids"].present?
      contactsss=Contact.where(:id=>i["appointment"]["contacts_ids"].split(",")).pluck(:name).join(",")
      end
     data1 = {"id"=>i["appointment"]["id"],"appoint_note"=>i["appointment"]["appoint_note"],"appoint_date"=>i["appointment"]["appoint_date"], "appoint_time"=>i["appointment"]["appoint_time"],"app_contact_type"=>i["appointment"]["app_contact_type"],"appoint_note"=>i["appointment"]["appoint_note"],"contacter_table_name"=>contactsss}

     @supplier_contact=[]
     if i["appointment"]["app_contact_type"]=="Supplier"

       data1["contact_name"]=Supplier.find(i["appointment"]["app_contact_id"]).supplier_name

       User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?((i.app_contact_id).to_s) == true}

      elsif i["appointment"]["app_contact_type"]=="Manufacturer"

        data1["contact_name"]=Manufacturer.find(i["appointment"]["app_contact_id"]).manufacturer_name

        supplier_id=Manufacturer.find(i["appointment"]["app_contact_id"]).divisions.first.products.first.supplier_id

        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true}

      elsif i["appointment"]["app_contact_type"]=="Division"

        data1["contact_name"]=Division.find(i["appointment"]["app_contact_id"]).div_name

        supplier_id=Division.find(i["appointment"]["app_contact_id"]).products.first.supplier_id

        User.where.not(supplier_id: nil).map{|j| @supplier_contact << j.user_name if j.supplier_id.split(",").include?(supplier_id.to_s) == true}

     end
      data1["supplier_contact"]=@supplier_contact.flatten.compact.uniq
      data << data1


    end
  end  

      render json: data  

end

# the below method not used anywhere
def shedular_job
  
 @from_date=Date.current.beginning_of_month+1.month
 @to_date=Date.current.end_of_month+1.month
 Appointment.where(:appoint_date=>(@from_date..@to_date)).map {|i| Appointment.create(:appoint_date=>i.appoint_date+1.month,appoint_time:i.appoint_time, contacts_ids: i.contacts_ids, appoint_note: i.appoint_note, app_contact_id: i.app_contact_id, app_contact_type: i.app_contact_type, mail_status: i.mail_status)}

end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def appointment_params
      params.require(:appointment).permit(:appoint_date,:appoint_time,:contacts_ids,:appoint_note,:contact_type,:contact_id,:supplier_id)
    end

    #def claim_issue_params
    # params.require(:claim_issue).permit(:description, :cut_off_date, :status, :notes, :contact_id, :appointment_id)
    #end  
end

