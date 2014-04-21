FactoryGirl.define do
	factory :product do
		name 'Product name'
		stored_at DateTime.new
		stock 5
		price 10.5
	end

	sequence :name do |n|
		"Product #{n} name"
	end

	factory :product_with_diff_name, class: Product do
		name
		stored_at DateTime.new
		stock 5
		price 10.5
	end
end