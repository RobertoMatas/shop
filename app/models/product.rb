# encoding: utf-8
class Product < ActiveRecord::Base
	ALLOWED_CATEGORIES = ['libros', 'hogar', 'juguetes', 'ropa', 'comestibles', 'música & películas', 'electrónica']

	validates :name, :stored_at, :stock, :price, presence: true
	validates :stock, numericality: { only_integer: true }
	validates :price, numericality: true
	validates :category, inclusion: { in: ALLOWED_CATEGORIES,
			message: "must be in #{ALLOWED_CATEGORIES.join(', ')}" }, allow_blank: true
	validates :name, uniqueness: true

	has_many :line_items
	has_many :orders, through: :line_items
	mount_uploader :photo, ProductPhotoUploader
end
