# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ad = Admin.create(name: 'admin1', email: 'admin@app.com', password: '123456')
ag = Agent.create(name: 'agent1', email: 'agent@app.com', password: '123456')
Agent.create(name: 'agent2', email: 'agent2@app.com', password: '123456')
c  = Customer.create(name: 'customer1', email: 'customer@app.com', password: '123456')
t1 = Ticket.create(title: 'Test Title', body: 'Test Body .........!!', customer: c)
t2 = Ticket.create(title: 'Test Title', body: 'Test Body .........!!', customer: c)
t2.assign!(ag)
Customer.create(name: 'customer2', email: 'customer2@app.com', password: '123456')