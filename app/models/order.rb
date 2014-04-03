class Order < ActiveRecord::Base
	ALLOW_STATUS = ['Pendiente', 'Enviado', 'Recibido']
	ALLOW_PAYMENT_METHODS = ['en efectivo', 'tarjeta', 'paypal']

	before_create :set_order_status

	validates :customer_name, :customer_last_name, :shipping_address, :shipping_city, :payment_method, presence: true
	validates :payment_method, inclusion: { in: ALLOW_PAYMENT_METHODS, message: "must be in #{ALLOW_PAYMENT_METHODS.join(', ')}" }
	validates :status, presence: true, 
			inclusion: { in: ALLOW_STATUS, message: "must be in #{ALLOW_STATUS.join(', ')}" }, 
			on: :update

	has_many :line_items
	has_many :products, through: :line_items
	accepts_nested_attributes_for :line_items, :allow_destroy => true, 
		:reject_if => lambda { |li| li[:product_id].blank? or li[:quantity].blank? }

	protected
		def set_order_status
			self.status = 'Pendiente'
		end

end
