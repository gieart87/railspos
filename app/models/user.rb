class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise 	:database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable

	before_validation :set_default_role, on: [:create, :update]

	belongs_to :role

	def name
		if !self.first_name.nil? and !self.last_name.nil?
			self.first_name + ' ' + self.last_name
		else 
			self.email
		end
	end
	
	private  
		def set_default_role  
			self.role ||= Role.find_by_name('user')  
		end
end
