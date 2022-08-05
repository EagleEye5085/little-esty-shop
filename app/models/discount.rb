class Discount < ApplicationRecord
  validates_presence_of :precentage, presence: true
  validates_presence_of :quantity, presence: true

  belongs_to :merchant

end
