FactoryGirl.define do
	factory :user do
		name "roberto"
		last_name "matas"
		email "an_user@example.com"
		password "rmataspass"
		password_confirmation "rmataspass"
	end
end