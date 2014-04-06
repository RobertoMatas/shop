class LineItem < ActiveRecord::Base
	before_save :set_product_price, on: [ :create, :update ]

  belongs_to :order
  belongs_to :product

  validates :quantity, :product, presence: true
  validates :quantity, numericality: { only_integer: true }

	protected
	  def set_product_price
	    self.unit_price = self.product.price
	    self.product.decrement_stock self.quantity
	  end

end
