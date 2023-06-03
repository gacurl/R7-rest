class Api::V1::FactsController < ApplicationController
  include AuthenticationCheck

  before_action :is_user_logged_in
  before_action :set_member, only: [:index, :show, :update, :destroy]
  before_action :set_fact, only: [:show, :update, :destroy]

  # GET /members/:member_id/facts
  def index
    render json: @member.facts # note that because the facts route is nested inside members
                             # we return only the facts belonging to that member
  end

  # GET /members/:member_id/facts/:id
  def show
    # your code goes here
    # @member.facts.find_by(id: params[:id])
    render json: @fact
  end

  # POST /members/:member_id/facts
  def create
    @member = Member.find(params[:member_id])
    @fact = @member.facts.new(fact_params)
    if @fact.save
      render json: @fact, status: :created
    else
      render json: { error: "The fact entry could not be created. #{@fact.errors.full_messages.to_sentence}"}, status: :bad_request
    end
  end

  # PUT /members/:member_id/facts/:id
  def update
    # your code goes here
    if @fact.update(fact_params)
      render json: @fact, status: :ok
    else
      render json: { error: "The fact could not be updated. #{@fact.error.full_messages.to_sentence}"}, status: :bad_request
    end
  end

  # DELETE /members/:member_id/facts/:id
  def destroy
    # your code goes here
    @fact.destroy
    render json: @member.facts, status: :ok
  end

  private

  def fact_params
    params.require(:fact).permit(:fact_text, :likes)
  end

  def set_fact
    @fact = Fact.find(params[:id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
