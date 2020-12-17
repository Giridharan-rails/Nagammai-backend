class DivisionSynsController < ApplicationController
  before_action :set_division_syn, only: [:show, :update, :destroy]


# this controller not used anywhere

  # GET /division_syns
  def index
    @division_syns = DivisionSyn.all

    render json: @division_syns
  end

  # GET /division_syns/1
  def show
    render json: @division_syn
  end

  # POST /division_syns
  def create
    @division_syn = DivisionSyn.new(division_syn_params)

    if @division_syn.save
      render json: @division_syn, status: :created, location: @division_syn
    else
      render json: @division_syn.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /division_syns/1
  def update
    if @division_syn.update(division_syn_params)
      render json: @division_syn
    else
      render json: @division_syn.errors, status: :unprocessable_entity
    end
  end

  # DELETE /division_syns/1
  def destroy
    @division_syn.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_division_syn
      @division_syn = DivisionSyn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def division_syn_params
      params.require(:division_syn).permit(:name, :email, :phone_number, :address)
    end
end
