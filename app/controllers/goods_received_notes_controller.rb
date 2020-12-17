class GoodsReceivedNotesController < ApplicationController
  before_action :set_goods_received_note, only: [:show, :update, :destroy]
# we are not using this controller anywhere
  # GET /goods_received_notes
  def index
    @goods_received_notes = GoodsReceivedNote.all

    render json: @goods_received_notes
  end

  # GET /goods_received_notes/1
  def show
    render json: @goods_received_note
  end

  # POST /goods_received_notes
  def create
    @goods_received_note = GoodsReceivedNote.new(goods_received_note_params)

    if @goods_received_note.save
      render json: @goods_received_note, status: :created, location: @goods_received_note
    else
      render json: @goods_received_note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /goods_received_notes/1
  def update
    if @goods_received_note.update(goods_received_note_params)
      render json: @goods_received_note
    else
      render json: @goods_received_note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /goods_received_notes/1
  def destroy
    @goods_received_note.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goods_received_note
      @goods_received_note = GoodsReceivedNote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def goods_received_note_params
      params.require(:goods_received_note).permit(:grn_number, :grn_date, :invoice_number, :invoice_date, :quantity, :free_qunatity, :gross, :tax, :amount, :product_code, :product_name, :supplier_code, :supplier_name, :batch_description, :purchase_price, :mrp, :purchase_taxcode, :remarks, :supplier_gstnumber, :product_id, :supplier_id)
    end
end
