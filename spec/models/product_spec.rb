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
end