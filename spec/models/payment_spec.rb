require 'rails_helper'

RSpec.describe Payment, type: :model do
  it "prevents payments from exceeding the loan's funded_ammount" do
    loan = Loan.create!(funded_amount: 100.0)
    payment = loan.payments.create(amount: 101)
    expect(payment.valid?).to be(false)
    expect(payment.errors[:amount]).to include("must be less than the outstanding balance of $100.0")
  end
end
