FactoryGirl.define do
	factory :user do
		role_id 1
		email 'john@example.com'
		first_name 'John'
		last_name 'Doe'
		password 'user123'
	end
end
