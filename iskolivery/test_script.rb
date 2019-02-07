# UC-10.0-S1: Successful Login
# UC-7.0-S1: Requester posts a request
# UC-8.0-S1: Fulfiller views his accepted requests
# UC-8.0-S2: Fulfiller accepts a request

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
