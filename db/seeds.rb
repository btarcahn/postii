# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Creator.create(
  creator_name: 'admin',
  email_address: 'batr.schip@gmail.com',
  sector_code: 'com',
  prefix_code: 'abc')

guest = Creator.create(
  creator_name: 'guest',
  email_address: 'guest@postii.com',
  sector_code: 'org',
  prefix_code: 'ano')

p_admin = admin.basic_posters.create(
  poster_id: "#{admin.sector_code}-#{admin.prefix_code}",
  title: 'poster of admin',
  description: 'This is a poster of admin.',
  security_question: 'Who is Gamora?',
  security_answer: 'Why is Gamora?',
  passcode: 'Hello@123'
)
