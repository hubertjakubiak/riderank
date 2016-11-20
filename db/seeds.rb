puts 'Create Users...'
user = User.create(email: 'hubert.jakubiak@gmail.com', password: 'asdfasdf')

puts 'Create Companies...'
company1 = Company.create(name: 'Sawa')
company2 = Company.create(name: 'Uber')
company2 = Company.create(name: 'MTP')

puts 'Create Rides...'
ride1 = Ride.create(start_address: 'Parkingowa 18, Żyrardów, Polska', destination_address: 'Słomińskiego 7, Warszawa, Polska', date:  '2016-11-11', payment_amount: 40, company: company1, user: user)