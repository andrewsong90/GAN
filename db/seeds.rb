# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Skill.where(:skill => "Accounting").first_or_create!
Skill.where(:skill => "Advertising & Public Relations").first_or_create!
Skill.where(:skill => "Banking / Finance").first_or_create!
Skill.where(:skill => "Biotech / Pharma").first_or_create!
Skill.where(:skill => "Construction / Building").first_or_create!
Skill.where(:skill => "Economics").first_or_create!
Skill.where(:skill => "Entertainment").first_or_create!
Skill.where(:skill => "Engineering").first_or_create!
Skill.where(:skill => "Environmental Science & Policy").first_or_create!
Skill.where(:skill => "Food Services & Hospitality").first_or_create!
Skill.where(:skill => "Fundraising").first_or_create!
Skill.where(:skill => "Government / Politics").first_or_create!
Skill.where(:skill => "Human Resources").first_or_create!
Skill.where(:skill => "Insurance").first_or_create!
Skill.where(:skill => "Internet Technology").first_or_create!
Skill.where(:skill => "IT / Software Development").first_or_create!
Skill.where(:skill => "Jewish - Communal Life").first_or_create!
Skill.where(:skill => "Jewish - Rabbinic / Cantorial").first_or_create!
Skill.where(:skill => "Law / Legal").first_or_create!
Skill.where(:skill => "Manufacturing").first_or_create!
Skill.where(:skill => "Marketing").first_or_create!
Skill.where(:skill => 'Medical / Health Professions').first_or_create!
Skill.where(:skill => "Not-for-profits").first_or_create!
Skill.where(:skill => "Project Management").first_or_create!
Skill.where(:skill => "Real Estate").first_or_create!
Skill.where(:skill => "Retail").first_or_create!
Skill.where(:skill => "Teaching").first_or_create!
Skill.where(:skill => "Science / Research").first_or_create!
Skill.where(:skill => "Writing / Editing").first_or_create!
Skill.where(:skill => "Other").first_or_create!

EduLevel.where(:education => "Current High School Student").first_or_create!
EduLevel.where(:education => "High School Graduate").first_or_create!
EduLevel.where(:education => "Current College Undergraduate").first_or_create!
EduLevel.where(:education => "College Graduate").first_or_create!

Opportunity.update_all(:edu_level => "College Graduate")

# admin=User.where(:email => "admin@gannacademy.org", :type => "Admin").first_or_create!(:password => "111111", :confirmed_at => Time.now, :invitation_limit => nil)
# User.where(:email => "admin@gannacademy.org", :type => "Admin").first.update!(:fname => "Susan", :lname => "Rubin", :parent_email =>"be@gmail.com", :password => "111111", :confirmed_at => Time.now, :invitation_limit => 9999)
# User.where(:email => "admin2@gannacademy.org", :type => "Admin").first.update!(:fname => "Chris", :lname => "Russo", :password => "111111", :confirmed_at => Time.now, :invitation_limit => 9999)