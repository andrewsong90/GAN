# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Skill.create([{skill: 'Finance'},{skill: 'Programming'},{skill: 'Documents'},{skill: 'Communication'},{skill: 'Marketing'}, {skill: 'Chemical Engineering'},{skill: 'Computer Graphics'},{skill: 'Spanish'}, {skill: 'Economics'}, {skill: 'Cooking'}, {skill: 'Photoshop'}, {skill: 'Biological Engineering'}, {skill: 'Big Data'}, {skill: 'Web Development'}])
Type.create([{name: 'Full-Time'},{name: 'Part-Time'},{name: 'Internship'},{name: "Mentorship"}])
