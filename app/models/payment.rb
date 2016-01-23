class Payment < ActiveRecord::Base
  belongs_to :loan

  validate :balance_not_exceeded

  private
  def balance_not_exceeded
    outstanding_balance = loan.outstanding_balance
    if outstanding_balance - amount < 0
      errors.add(:amount, "must be less than the outstanding balance of $#{outstanding_balance}")
    end
  end
end
