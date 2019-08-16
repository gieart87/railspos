require 'rails_helper'

RSpec.describe User, type: :model do
	context 'validation test' do 
		it 'is valid with a first name, last name, email, and password' do
			role = Role.create(:name => 'admin')
			user = User.new(
				first_name: 'John',
				last_name: 'Doe',
				email: 'john@example.com',
				password: 'john123',
				role_id: role.id
			)

			expect(user).to be_valid
		end

		it 'is invalid without a first name' do 
			user = User.new(first_name: nil)
			user.valid?

			expect(user.errors[:first_name]).to include("can't be blank")
		end

		it 'is invalid without a last name' do 
			user = User.new(last_name: nil)
			user.valid?

			expect(user.errors[:last_name]).to include("can't be blank")
		end

		it 'is invalid without an email address' do
			user = User.new(email: nil)
			user.valid?

			expect(user.errors[:email]).to include("can't be blank")
		end

		it 'is invalid with a duplicate email address' do 
			role = Role.create(:name => 'admin')

			User.create(
				first_name: 'John',
				last_name: 'Doe',
				email: 'john@example.com',
				password: 'john123',
				role_id: role.id
			)

			user = User.new(
				first_name: 'John 2',
				last_name: 'Doe 2',
				email: 'john@example.com',
				password: 'john123',
				role_id: role.id
			)

			user.valid?

			expect(user.errors[:email]).to include("has already been taken")
		end

		it "returns a user's full name as a string" do
			role = Role.create(:name => 'admin')

			user = User.new(
				first_name: 'John',
				last_name: 'Doe',
				email: 'john@example.com',
				password: 'john123',
				role_id: role.id
			)

			expect(user.name).to eq "John Doe"
		end
	end

	context 'scope test' do 

	end
end
