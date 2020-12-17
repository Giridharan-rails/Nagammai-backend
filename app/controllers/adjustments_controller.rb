class AdjustmentsController < ApplicationController
  before_action :set_adjustment, only: [:show, :update, :destroy]

  # GET /adjustments
  def index  # this to show all the adjusted claims
    @adjustments = Adjustment.all

    render json: @adjustments
  end

  # GET /adjustments/1
  def show # not used anywhere
    render json: @adjustment
  end

  # POST /adjustments
  def create # this is to create the adjusments
    @adjustment = Adjustment.new(adjustment_params)

    if @adjustment.save
      render json: @adjustment, status: :created, location: @adjustment
    else
      render json: @adjustment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /adjustments/1
  def update  # not using anywhere
    if @adjustment.update(adjustment_params)
      render json: @adjustment
    else
      render json: @adjustment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /adjustments/1
  def destroy  # not using anywhere
    @adjustment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adjustment
      @adjustment = Adjustment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def adjustment_params
      params.require(:adjustment).permit(:settled_amount, :balance_amount, :credit_note_num, :credit_date, :remark, :adjust_quantity, :claim_product_type, :claim_product_id)
    end
end
