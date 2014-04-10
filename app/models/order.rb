class Order < ActiveRecord::Base
	before_create :set_order_status

	validates :customer_name, :customer_last_name, :shipping_address, :shipping_city, :payment_method, presence: true
	validates :payment_method, inclusion: { in: :allowed_payment_methods }
	validates :status, presence: true, 
			inclusion: { in: :allowed_status }, 
			on: :update

	has_many :line_items
	has_many :products, through: :line_items
	accepts_nested_attributes_for :line_items, :allow_destroy => true, 
		:reject_if => lambda { |li| li[:product_id].blank? or li[:quantity].blank? }

	protected
		def set_order_status
			self.status = 'Pendiente'
		end
		def allowed_status
			I18n.t 'order_special_fields.allowed_status'
		end
		def allowed_payment_methods
			I18n.t 'order_special_fields.allowed_payment_methods'
		end
end
