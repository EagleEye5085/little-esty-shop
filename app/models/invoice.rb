class Invoice < ApplicationRecord
  validates_presence_of :status, presence: true

  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: { "in progress": 0, "completed": 1, "cancelled": 2 }


  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items: {status: 'shipped'})
    .distinct
    .order("created_at")
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def total_discounted_revenue
    binding.pry
    invoice_items.sum{|item| item.discount_price}
    # binding.pry
  end
end
