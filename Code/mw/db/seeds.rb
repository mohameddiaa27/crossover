# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ad = Admin.create(name: Faker::Name.name, email: 'admin@app.com', password: '123456')
ag = Agent.create(name: Faker::Name.name, email: 'agent@app.com', password: '123456')
Agent.create(name: Faker::Name.name, email: 'agent2@app.com', password: '123456')
c  = Customer.create(name: Faker::Name.name, email: 'customer@app.com', password: '123456')
t1 = Ticket.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, customer: c)
t2 = Ticket.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, customer: c)
Customer.create(name: 'customer2', email: 'customer2@app.com', password: '123456')

20.times.each do
	t1.comments.create(body: Faker::Lorem.sentence, account: c)
end

20.times do
	Ticket.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, customer: c)
end

ts = []
20.times do
	ts << Ticket.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, customer: c)
end

ts.each do |t|
	t.agent = ag
	t.status = "assigned"
	t.save!
end