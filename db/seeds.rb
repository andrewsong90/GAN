# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Skill.where(:skill => "Accounting/Finance/Insurance").first_or_create!
Skill.where(:skill => "Banking/Real Estate/Mortgage Professionals").first_or_create!
Skill.where(:skill => "Administrative/Clerical").first_or_create!
Skill.where(:skill => "Biotech/R&D/Science").first_or_create!
Skill.where(:skill => "Building Construction/Skilled Trades").first_or_create!
Skill.where(:skill => "Business/Strategic Management").first_or_create!
Skill.where(:skill => "Creative/Design").first_or_create!
Skill.where(:skill => "Customer Support/Client Care").first_or_create!
Skill.where(:skill => "Editorial/Writing").first_or_create!
Skill.where(:skill => "Education/Training").first_or_create!
Skill.where(:skill => "Engineering").first_or_create!
Skill.where(:skill => "Food Services/Hospitality").first_or_create!
Skill.where(:skill => "Engineering").first_or_create!
Skill.where(:skill => "Human Resources").first_or_create!
Skill.where(:skill => "IT/Software Development").first_or_create!
Skill.where(:skill => "Legal").first_or_create!
Skill.where(:skill => "Security/Protective Services").first_or_create!


Type.where(:name => "Full-Time").first_or_create!
Type.where(:name => "Part-Time").first_or_create!
Type.where(:name => "Paid Intern").first_or_create!
Type.where(:name => "Unpaid Intern").first_or_create!
Type.where(:name => "Mentorship").first_or_create!


admin=User.where(:email => "admin@gannacademy.org", :type => "Admin").first_or_create!(:password => "111111", :confirmed_at => Time.now)