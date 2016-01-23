require 'rails_helper'

RSpec.describe Loan, type: :model do

  describe '.outstanding_balance' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment1) { loan.payments.create!(amount: 20) }
    let(:payment2) { loan.payments.create!(amount: 21) }


    it 'is the funded_amount when there are no payments' do
      expect(loan.outstanding_balance).to eq(loan.funded_amount)
    end

    it 'subtracts payments from the funded_amount' do
      payment1
      expect(loan.outstanding_balance).to eq(loan.funded_amount - payment1.amount)
    end

    it 'subtracts multiple payments from the funded_amount' do
      payment1;payment2
      expect(loan.outstanding_balance).to eq(loan.funded_amount - payment1.amount - payment2.amount)
    end
  end

end
