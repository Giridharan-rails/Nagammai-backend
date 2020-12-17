class CfaTitlesController < ApplicationController
  before_action :set_cfa_title, only: [:show, :update, :destroy]

  # GET /cfa_titles
  #to display the cfa titles in index page
  def index
    
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in cfa titles index page"
  
    begin

    @cfa_titles = CfaTitle.all.order('job_name ASC')

    render json: @cfa_titles
  
   if @cfa_titles.present?
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Cfa titles successfully displayed"
  else
    Rails.logger.debug_log.debug { "#{"cfas titles may be not available otherwise check backend"}"}
  end
  rescue =>e
   Rails.logger.custom_log.error { "#{e} cfa_titles_controller index method" }
  end

  end
 

 # the below method is used to display the specific cfa title in show page
  # GET /cfa_titles/1
  def show
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in cfa titles show method"
    
    begin

    render json: @cfa_title
    unless @cfa.present?
Rails.logger.debug_log.debug { "#{"cfas titles may be not available otherwise check backend"}"}

end
    rescue =>e
    Rails.logger.custom_log.error { "#{e} cfa_titles_controller show method" }
    end 

  end
# the below method is used to create cfatitle
  # POST /cfa_titles
  def create
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in cfa titles create method"
    begin

    @cfa_title = CfaTitle.new(cfa_title_params)

    if @cfa_title.save
      render json: @cfa_title, status: :created, location: @cfa_title
    else
      render json: @cfa_title.errors, status: :unprocessable_entity
    end
  Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : cfa titles created successfully"
    rescue => e
      Rails.logger.custom_log.error { "#{e} cfa_titles_controller create method" }
    end
    
  end
# the below method is used for update the cfa title
  # PATCH/PUT /cfa_titles/1
  def update
    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in cfa titles update method"
 
  begin

    if @cfa_title.update(cfa_title_params)
      render json: @cfa_title
    else
      render json: @cfa_title.errors, status: :unprocessable_entity
    end

    Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : updated successfully"

  rescue =>e
     Rails.logger.custom_log.error { "#{e} cfa_titles_controller update method" }
  end
    
  end
# which is used to delete the cfa title
  # DELETE /cfa_titles/1
  def destroy
     Rails.logger.info_log.info  " I,[#{Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")}]" "INFO -- : Entered in cfa titles destroy method"

  begin

    @cfa_title.destroy
    rescue =>e
  Rails.logger.custom_log.error { "#{e} cfa_titles_controller cfa_destory method" }
  end
   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cfa_title
      @cfa_title = CfaTitle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cfa_title_params
      params.require(:cfa_title).permit(:job_name)
    end
end
