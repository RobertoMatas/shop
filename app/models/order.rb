class Order < ActiveRecord::Base
	has_many :line_items
	has_many :products, through: :line_items
	accepts_nested_attributes_for :line_items, :allow_destroy => true, 
		:reject_if => lambda { |li| li[:product_id].blank? or li[:quantity].blank? or li[:unit_price].blank? }
end
