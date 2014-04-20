FactoryGirl.define do
	factory :product do
		name nil
		stored_at DateTime.new
		stock 5
		price 10.5
	end
end