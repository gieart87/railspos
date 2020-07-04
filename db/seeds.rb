# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  role_user = Role.create(:name => 'user')  
  role_admin = Role.create(:name => 'admin')  
  User.create(:email => 'user@example.com' ,  :password => 'user123', :role_id => role_user.id, :first_name => 'user', :last_name => '-')   
  User.create(:email => 'admin@example.com' , :password => 'admin123', :role_id => role_admin.id, :first_name => 'admin', :last_name => '-')  