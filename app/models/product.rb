# encoding: utf-8
class Product < ActiveRecord::Base
	ALLOWED_CATEGORIES = I18n.t('product_special_fields.allowed_categories')

	scope :category_is, ->(category) { where category: category }
	scope :stock_gt, ->(stock) { where('stock > ?', stock) }
	scope :price_lt, ->(price) { where('price < ?', price) }
	scope :price_gt, ->(price) { where('price > ?', price) }
	scope :stored_at_after, ->(date) { where('stored_at > ?', date) }
	scope :manufacturer_like, ->(manufacturer) { where("manufacturer like ?", "#{manufacturer}%") }

	validates :name, :stored_at, :stock, :price, presence: true
	validates :stock, numericality: { only_integer: true }
	validates :price, numericality: true
	validates :category, inclusion: { in: ALLOWED_CATEGORIES,
			message: I18n.t('activerecord.errors.messages.inclusion', list: ALLOWED_CATEGORIES.join(', ')) }, allow_blank: true
	validates :name, uniqueness: true

	has_many :line_items
	has_many :orders, through: :line_items
	mount_uploader :photo, ProductPhotoUploader

	def decrement_stock(quantity)
		self.stock -= quantity
		update_column(:stock, self.stock)
	end
end
