require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      loan = Loan.create!(funded_amount: 100)
      get :index, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    it 'responds with a 200' do
      loan = Loan.create!(funded_amount: 100)
      payment = loan.payments.create!(amount: 50)
      get :show, id: payment.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'responds with a 200' do
      loan = Loan.create!(funded_amount: 100)
      post :create, loan_id: loan.id, payment: {amount: 100}
      expect(response).to have_http_status(:ok)
    end

    it 'responds with a 400 when overpaying' do
      loan = Loan.create!(funded_amount: 100)
      post :create, loan_id: loan.id, payment: {amount: 101}
      expect(response).to have_http_status(:bad_request)
    end

    it 'responds with errors when overpaying' do
      loan = Loan.create!(funded_amount: 100)
      post :create, loan_id: loan.id, payment: {amount: 101}
      expect(JSON.parse(response.body)['amount']).to include("must be less than the outstanding balance of $100.0")
    end

  end
end
