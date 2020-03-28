class Payment < ApplicationRecord
    # validates :card_number, length: { is: 16 }, numericality: { only_integer: true }, uniqueness: true
    # validates :cvv, length: { is: 3 }, numericality: { only_integer: true }, uniqueness: true
    # validates :expiry_date_validation,
    # def expiry_date_validation
    #     if expiry_date.present? && expiry_date < Date.today
    #         errors.add(:expiry_date, "can't be in the past")
    #     end
    # end

    belongs_to :user
end