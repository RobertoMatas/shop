class Product < ActiveRecord::Base
	validates :name, length: { maximum: 255 }, presence: true
	has_many :line_items
	has_many :orders, through: :line_items
end
