class ClaimIssuesController < ApplicationController
  before_action :set_claim_issue, only: [:show, :update, :destroy]

  # GET /claim_issues
  def index
    @claim_issues = ClaimIssue.limit(2)
    render json: @claim_issues
  end

  # GET /claim_issues/1
  def show
    render json: @claim_issue
  end

  # POST /claim_issues
  def create
    @claim_issue = ClaimIssue.new(claim_issue_params)

    if @claim_issue.save
      render json: @claim_issue, status: :created, location: @claim_issue
    else
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
      params.fetch(:claim_issue, {})
    end
end
