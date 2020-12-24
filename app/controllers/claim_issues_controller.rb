class ClaimIssuesController < ApplicationController
  before_action :set_claim_issue, only: [:show, :update, :destroy]

  # GET /claim_issues
  def index
    if params["from_date"].present? && params["to_date"].present?
      claim_issues = ClaimIssue.where(cut_off_date: params["from_date"]..params["to_date"])
    else
      claim_issues = ClaimIssue.all
    end
    claim_issues = claim_issues.where(status: params["status"]) if params["status"].present?
    claim_issues = claim_issues.where(user_id: params["user_id"]) if params["user_id"].present?
    claim_issues = claim_issues.where(devision_id: params["devision_id"]) if params["devision_id"].present?
    @claim_issues = claim_issues.order(created_at: :desc).as_json(include: [:contact, :division, :user])
    render json: @claim_issues
  end

  # GET /claim_issues/1
  def show
    render json: @claim_issue
  end

  # POST /claim_issues
  def create
    params.permit!
    @claim_issue = ClaimIssue.new(claim_issue_params)

    if @claim_issue.save
      render json: @claim_issue, status: :created, location: @claim_issue
    else
      puts "================#{@claim_issue.errors.full_messages}"
      render json: @claim_issue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /claim_issues/1
  def update
    if @claim_issue.update(claim_issue_params)
      render json: @claim_issue
    else
      render json: @claim_issue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /claim_issues/1
  def destroy
    @claim_issue.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_issue
      @claim_issue = ClaimIssue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def claim_issue_params
      params.require(:claim_issue).permit(:id, :description, :cut_off_date, :status, :notes, :contact_id, :appointment_id, :created_at, :updated_at, :approval, :mail_status, :remarks, :manual_status, :division_id, :user_id)
    end
end
