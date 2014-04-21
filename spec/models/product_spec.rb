require 'spec_helper'

describe Product do
	
	it 'is invalid without a name' do
		product = build(:product, name: nil)
		expect(product).to have(1).errors_on(:name)
	end
	
	it 'is invalid without a date of storage' do
		product = build(:product, stored_at: nil)
		expect(product).to have(1).errors_on(:stored_at)
	end
	
	it 'is invalid without a stock' do
		product = build(:product, stock: nil)
		expect(product).to have(2).errors_on(:stock)
	end
	
	it 'is invalid without a price' do
		product = build(:product, price: nil)
		expect(product).to have(2).errors_on(:price)
	end
	
	it 'is invalid without a numerical price' do
		product = build(:product, price: 'NaN')
		expect(product).to have(1).errors_on(:price)
	end
	
	it 'is invalid without a numerical stock' do
		product = build(:product, stock: 'NaN')
		expect(product).to have(1).errors_on(:stock)
	end

	it 'is invalid without a permit category' do
		product = build(:product, category: 'non-a-permit-category')
		expect(product).to have(1).errors_on(:category)
	end

	it 'is invalid with a duplicate name' do
		create :product
		product = build :product
		expect(product).to have(1).errors_on :name
	end

	it 'decrement stock substracts a quantity at current stock' do
		product = create :product, stock: 10
		product.decrement_stock 7
		expect(product.stock).to eq(3)
	end

	describe 'Filter by category' do
		before :each do
			@products = create_list(:product_with_diff_name, 5, category: 'food')
			@products = @products + create_list(:product_with_diff_name, 3, category: 'books')
		end

		context 'matching categories' do
			it 'return all products with food category' do
				filter_products_size = Product.category_is('food').size
				expect(filter_products_size).to eq(5)
			end
		end

		context 'non-matching categories' do
			it 'return nothing' do
				filter_products_size = Product.category_is('wear').size
				expect(filter_products_size).to eq(0)
			end
		end
	end

	describe 'Filter by price' do
		before :each do
			@products = create_list(:product_with_diff_name, 5, price: 10.5)
			@products = @products + create_list(:product_with_diff_name, 3, price: 20.75)
			@products = @products + create_list(:product_with_diff_name, 10, price: 5.25)
		end

		context 'price greater than' do
			it 'return only product above a price' do
				filter_products_size = Product.price_gt(10.49).size
				expect(filter_products_size).to eq(8)
			end
		end

		context 'price lower than' do
			it 'return only product under a price' do
				filter_products_size = Product.price_lt(5.30).size
				expect(filter_products_size).to eq(10)
			end
		end

		context 'price between than' do
			it 'return product in a price range' do
				p = Product.price_gt(6)
				p = p.price_lt(20)
				expect(p.size).to eq(5)
			end
		end
	end

end