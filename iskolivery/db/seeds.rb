# LICENSE
# This is a course requirement for CS 192 Software Engineering II under the 
# supervision of Asst. Prof. Ma. Rowena C. Solamo of the Department of Computer 
# Science, College of Engineering, University of the Philippines, Diliman for the 
# AY 2018-2019
# 
# This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 
# International License.
# 
# Author: Marc Teves
# 
# Modified by Marc Teves on February 5. Added location records.
#
# Modified by Marc Teves on February 22. Moved contents of test_script.rb to
# seeds.rb
#
# CODE HISTORY
#
# 
# INFORMATION
# File creation: February 5, 2019
# Development group: Group 1 - Iskolivery
# Client group: None
# Purpose of the software: To create a crowdsourced courier service for the 
# UP Community
# This file should contain all the record creation needed to seed the database 
# with its default values.
# The data can then be loaded with the rails db:seed command (or created 
# alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)

Location.create(name: 'Palma Hall')
Location.create(name: 'Melchor Hall')
Location.create(name: 'Engineering Library 2')
Location.create(name: 'College of Science Library')

default_pass = 'password'

userA_email = 'testA@test.com'
userB_email = 'testB@test.com'

userA = User.create(email: userA_email, password: default_pass,
				password_confirmation: default_pass)

userB = User.create(email: userB_email, password: default_pass,
				password_confirmation: default_pass, admin: true)

location = Location.find_by(name: 'Palma Hall')
req1 = Request.create(title: 'chinese new year',
				  location_id: location.id,
				  item_name: 'tikoy',
				  bounty: 8.00)

userA.postings.create(request_id: req1.id)

ass = Assignment.find_by(request_id: req1.id)

userB.accepteds << ass

location = Location.find_by(name: 'Melchor Hall')
req2 = Request.create(title: 'gutom ako',
				  location_id: location.id,
				  item_name: 'pabili ng spacanton',
				  bounty: 20.00)

userB.postings.create(request_id: req2.id)
