class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :discounts, through: :merchant

  enum status: { "pending": 0, "packaged": 1, "shipped": 2 }

  def find_best_discount
    discounts.where('quantity <= ?', quantity).order(percentage: :desc).first
  end

  def total_revenue
    quantity * unit_price
  end

  def revenue_reduction
    (total_revenue * find_best_discount.percentage/100).to_i
  end

  def discount_price
    if find_best_discount.nil?
      total_revenue
    else
      total_revenue - revenue_reduction
    end
  end
end
