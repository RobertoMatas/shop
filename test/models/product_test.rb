require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	test "the truth" do
		assert true
	end

	test "should not save product without name" do
		product = Product.new
		assert !product.save, "Saved the product without a name"
	end
end
