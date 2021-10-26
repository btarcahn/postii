namespace :db do
  namespace :seed do

    __password__ = 'Hello@123'
    __sector_code__ = 'dev'

    desc 'Create Creators for development/sample database'
    task creators: :environment do
      (1..10).each do |i|
        Creator.create!(
          creator_name: "Development Creator ##{i}",
          email_address: "creator.#{i}@a.com",
          sector_code: __sector_code__,
        )
      end
      puts 'Populated creators!'
    end

    desc 'Create users for development/sample database'
    task users: :environment do
      Creator.where(sector_code: __sector_code__).each do |creator|
        # One admin
        Admin.create!(
          email: "admin.#{creator.email_address}",
          password: __password__,
          creator: creator
        )
        # Two users
        (1..2).each do |i|
          User.create!(
            email: "user.#{i}.#{creator.email_address}",
            password: __password__,
            creator: creator
          )
        end
      end
      puts 'Populated users!'
    end

    desc 'Create BasicPosters for development/sample database'
    task basic_posters: :environment do
      Creator.where(sector_code: __sector_code__).each do |creator|
        (1..5).each do |i|
          creator.basic_posters.create!(
            poster_id: "#{creator.id}.#{i}",
            title: "Basic Poster ##{i} of Creator ##{creator.id}",
            description: "Belongs to Creator #{creator.email_address}",
            security_question: 'What is my Creator\'s id?',
            security_answer: "#{creator.id}",
            passcode: 'P0st!!123'
          )
        end
      end
      puts 'Populated basic_posters!'
    end

    desc 'Create Quests for development/sample database'
    task quests: :environment do
      BasicPoster.all.each do |poster|
        (1..2).each do |i|
          poster.quests.create!(
            quest_type: 'short',
            mandatory: false,
            question: "Am I Quest ##{i} for BasicPoster #{poster.poster_id}?",
            answer: 'Yes, yes I am!'
          )
        end
      end
      puts 'Populated quests!'
    end

    desc 'Seed development database'
    task development: %w[db:seed:creators db:seed:users db:seed:basic_posters db:seed:quests]
  end
end
