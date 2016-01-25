class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.find(params[:loan_id]).payments
  end

  def show
    render json: Payment.find(params[:id])
  end

  def create
    loan = Loan.find(params[:loan_id])
    payment = loan.payments.build(params.require(:payment).permit(:amount, :payment_date))
    if payment.save
      render json: payment
    else
      render json: payment.errors, status: :bad_request
    end
  end
end
