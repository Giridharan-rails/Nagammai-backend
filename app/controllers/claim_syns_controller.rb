class ClaimSynsController < ApplicationController
  before_action :set_claim_syn, only: [:show, :update, :destroy]


# We are not using this controller



  # GET /claim_syns
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claim_syns index page"
  begin

    @claim_syns = ClaimSyn.all

    render json: @claim_syns

  if @claim_syns.nil?
Rails.logger.debug_log.debug { "#{"claim_syns data not available"}"}
end
rescue =>e
 Rails.logger.custom_log.error { "#{e.class} #{claim_syns_controller index  method}" }
end  
  end

  # GET /claim_syns/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claim_syns show method"
    render json: @claim_syn

if @claim_syns.nil?
Rails.logger.debug_log.debug { "#{"claim_syns may be not available otherwise check backend"}"}

end
    rescue =>e
    Rails.logger.custom_log.error { "#{e.class} #{claim_syns_controller show method}" }
    end 

  end

  # POST /claim_syns
  def create
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the claim_syns create button"
    begin

    @claim_syn = ClaimSyn.new(claim_syn_params)

    if @claim_syn.save
      render json: @claim_syn, status: :created, location: @claim_syn
    else
      render json: @claim_syn.errors, status: :unprocessable_entity
    end
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claim_syns created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e.class} #{claim_syns_controller create method}" }
   end 
  end

  # PATCH/PUT /claim_syns/1
  def update
    
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the claim_syns update button"
    begin

    if @claim_syn.update(claim_syn_params)
      render json: @claim_syn
    else
      render json: @claim_syn.errors, status: :unprocessable_entity
    end
    
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claim_syns Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e.class} #{claim_syns_controller update method}" }
    end

  end

  # DELETE /claim_syns/1
  def destroy
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in claim_syns Delete"
    begin
    @claim_syn.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : claim_syns Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e.class} #{claim_syns_controller destroy method}" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_syn
      @claim_syn = ClaimSyn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def claim_syn_params
      params.require(:claim_syn).permit(:p_code, :describtion, :packing, :batch_desc, :expiry_date, :quantity, :bill_date, :bill_number)
    end
end
