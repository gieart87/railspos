class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise 	:database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable

	before_validation :set_default_role, on: [:create, :update]

	validates :first_name, presence: true
	validates :last_name, presence: true

	belongs_to :role

	def name
		if !self.first_name.nil? and !self.last_name.nil?
			self.first_name + ' ' + self.last_name
		elsif !self.first_name.nil? and self.last_name.nil?
			self.first_name
		else 
			self.email
		end
	end
	
	private  
		def set_default_role  
			self.role ||= Role.find_by_name('user')  
		end
end
