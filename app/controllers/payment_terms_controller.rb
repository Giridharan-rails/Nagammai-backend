class PaymentTermsController < ApplicationController
  before_action :set_payment_term, only: [:show, :update, :destroy]
# we are not using this
  # GET /payment_terms
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : payment_terms Index"
   begin
    @payment_terms = PaymentTerm.all.order('job_name ASC')

    render json: @payment_terms
    rescue => e
      Rails.logger.custom_log.error { "#{e} payment_terms_controller index method" }
     end
  end

  # GET /payment_terms/1
  def show
       Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in payment_terms show page"
  begin
    render json: @payment_term
    rescue =>e
   Rails.logger.custom_log.error { "#{e} payment_terms_controller show method" }
  end
  end

  # POST /payment_terms
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the payment_terms create button"
    begin
    @payment_term = PaymentTerm.new(payment_term_params)

    if @payment_term.save
      render json: @payment_term, status: :created, location: @payment_term
    else
      render json: @payment_term.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : payment_terms created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} payment_controller create method" }
   end
  end

  # PATCH/PUT /payment_terms/1
  def update
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the payment_terms update button"
    begin
    if @payment_term.update(payment_term_params)
      render json: @payment_term
    else
      render json: @payment_term.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : payment_terms Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} payment_terms_controller update method" }
    end
  end

  # DELETE /payment_terms/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : payment_terms in supplier Delete"
    begin
    @payment_term.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : payment_terms Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} payment_terms_controller delete method" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_term
      @payment_term = PaymentTerm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def payment_term_params
      params.require(:payment_term).permit(:job_name)
    end
end
