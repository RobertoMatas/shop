class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, :unit_price, :product, presence: true
  validates :quantity, numericality: { only_integer: true }
	validates :unit_price, numericality: true
end
