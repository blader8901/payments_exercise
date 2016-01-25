require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns all loans' do
      Loan.create!(funded_amount: 100.0)
      Loan.create!(funded_amount: 100.0)
      get :index
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns outstanding_balance' do
      Loan.create!(funded_amount: 100.0)
      get :index
      expect(JSON.parse(response.body)[0]['outstanding_balance']).to eq('100.0')
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, id: loan.id
      expect(response).to have_http_status(:ok)
    end

    it 'returns the outstanding_balance' do
      get :show, id: loan.id
      puts response.body
      expect(JSON.parse(response.body)['outstanding_balance']).to eq('100.0')
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
