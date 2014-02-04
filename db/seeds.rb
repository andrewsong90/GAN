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
Skill.where(:skill => "Human Resources").first_or_create!
Skill.where(:skill => "IT/Software Development").first_or_create!
Skill.where(:skill => "Legal").first_or_create!
Skill.where(:skill => "Security/Protective Services").first_or_create!
Skill.where(:skill => "Installation/Maintenance/Repair").first_or_create!
Skill.where(:skill => "Logistics/Transportation").first_or_create!
Skill.where(:skill => "Manufacturing/Production/Operation").first_or_create!
Skill.where(:skill => "Marketing/Product").first_or_create!
Skill.where(:skill => "Medical/Health").first_or_create!
Skill.where(:skill => 'Project/Program Management').first_or_create!
Skill.where(:skill => "Quality Assurance/Safety").first_or_create!
Skill.where(:skill => "Sales/Retail/Business Development").first_or_create!
Skill.where(:skill => "Other").first_or_create!

EduLevel.where(:education => "Current High School Student").first_or_create!
EduLevel.where(:education => "High School Graduate").first_or_create!
EduLevel.where(:education => "Current College Undergraduate").first_or_create!
EduLevel.where(:education => "College Graduate").first_or_create!

Opportunity.update_all(:edu_level => "College Graduate")

# admin=User.where(:email => "admin@gannacademy.org", :type => "Admin").first_or_create!(:password => "111111", :confirmed_at => Time.now, :invitation_limit => nil)
# User.where(:email => "admin@gannacademy.org", :type => "Admin").first.update!(:fname => "Susan", :lname => "Rubin", :parent_email =>"be@gmail.com", :password => "111111", :confirmed_at => Time.now, :invitation_limit => 9999)
# User.where(:email => "admin2@gannacademy.org", :type => "Admin").first.update!(:fname => "Chris", :lname => "Russo", :password => "111111", :confirmed_at => Time.now, :invitation_limit => 9999)