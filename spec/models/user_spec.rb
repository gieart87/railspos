require 'rails_helper'

RSpec.describe User, type: :model do
	context 'validation test' do 
		it 'ensures first name presence' do 
			role_admin = Role.create(:name => 'admin')
			user = User.new(last_name: 'Last', email: 'user@example.com', password: 'user123', role_id: role_admin.id).save

			expect(user).to eq(false)
		end

		it 'ensures last name presence' do 
			role_admin = Role.create(:name => 'admin')
			user = User.new(first_name: 'First', email: 'user@example.com', password: 'user123', role_id: role_admin.id).save

			expect(user).to eq(false)
		end

		it 'ensures role presence' do 
			user = User.new(first_name: 'First', last_name: 'Last', email: 'user@example.com', password: 'user123').save

			expect(user).to eq(false)
		end
	end

	context 'scope test' do 

	end
end
