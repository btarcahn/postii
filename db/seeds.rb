# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
  Rake::Task['db:core:setup'].invoke
  Rake::Task['db:seed:development'].invoke
else
  puts "No automatic database seeding available for #{Rails.env} environment"
  puts "If you still want to seed the database, run 'rails db:seed:development'"
end
