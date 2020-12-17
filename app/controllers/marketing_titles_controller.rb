class MarketingTitlesController < ApplicationController
  before_action :set_marketing_title, only: [:show, :update, :destroy]
  #which is used display the marketting title which is for differentiate the contacts
  # GET /marketing_titles
  def index
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : marketing_titles Index"
   begin
    @marketing_titles = MarketingTitle.all.order('job_name ASC')

    render json: @marketing_titles
    rescue => e
      Rails.logger.custom_log.error { "#{e} marketing_titles_controller index method" }
     end
  end
# the below method is to display selected markettting title in show page
  # GET /marketing_titles/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in marketing_titles show page"
  begin
    render json: @marketing_title
    rescue =>e
   Rails.logger.custom_log.error { "#{e} marketing_titles_controller show method" }
  end
  end
# the below method is used to create new marketting title
  # POST /marketing_titles
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the marketing_titles create button"
    begin
    @marketing_title = MarketingTitle.new(marketing_title_params)

    if @marketing_title.save
      render json: @marketing_title, status: :created, location: @marketing_title
    else
      render json: @marketing_title.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : marketing_titles created successfully"
     rescue =>e
    Rails.logger.custom_log.error { "#{e} marketing_titles_controller create method" }
   end
  end
# the below method is to update the selected marketting title
  # PATCH/PUT /marketing_titles/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : User click the marketing_titles update button"
    begin
    if @marketing_title.update(marketing_title_params)
      render json: @marketing_title
    else
      render json: @marketing_title.errors, status: :unprocessable_entity
    end
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : marketing_titles Updated successfully"
    rescue =>e
    Rails.logger.custom_log.error { "#{e} marketing_titles_controller update method" }
    end
  end
# this method is to delete the marketting titles
  # DELETE /marketing_titles/1
  def destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in marketing_titles Delete"
    begin
    @marketing_title.destroy
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : marketing_titles Deleted Successfully"
      rescue =>e
      Rails.logger.custom_log.error { "#{e} marketing_titles_controller delete method" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketing_title
      @marketing_title = MarketingTitle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketing_title_params
      params.require(:marketing_title).permit(:job_name)
    end
end
