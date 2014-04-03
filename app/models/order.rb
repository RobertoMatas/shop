class Order < ActiveRecord::Base
	ALLOW_STATUS = ['Pendiente', 'Enviado', 'Recibido']
	ALLOW_PAYMENT_METHODS = ['en efectivo', 'tarjeta', 'paypal']

	validates :customer_name, :customer_last_name, :shipping_address, :shipping_city, :payment_method, :status, presence: true
	validates :payment_method, inclusion: { in: ALLOW_PAYMENT_METHODS, message: "must be in #{ALLOW_PAYMENT_METHODS.join(', ')}" }
	validates :status, inclusion: { in: ALLOW_STATUS, message: "must be in #{ALLOW_STATUS.join(', ')}" }

	has_many :line_items
	has_many :products, through: :line_items
	accepts_nested_attributes_for :line_items, :allow_destroy => true, 
		:reject_if => lambda { |li| li[:product_id].blank? or li[:quantity].blank? or li[:unit_price].blank? }
end
