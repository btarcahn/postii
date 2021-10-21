namespace :db do
  namespace :seed do
    desc "Seeds the error messages (alerts) to the database"
    task :alerts, [:drop_table] => :environment do |t, args|
      table_name = 'err_msgs'
      if %w[drop drop_table reset].include? args[:drop_table]
        puts "This will truncate table '#{table_name}', and it works for PostgreSQL only!"
        ActiveRecord::Base.connection.execute("TRUNCATE #{table_name} RESTART IDENTITY")
        puts "'#{table_name}' was truncated."
      end
      AlertHelpers::ALERTS.each do |err_code, value|
        ErrMsg.create err_code: err_code,
                      message: value[:message],
                      reason: value[:reason],
                      component: 'core',
                      additional_note: 'created with rails db:seed:alerts'
      end
      puts "Added #{AlertHelpers::ALERTS.count} to '#{table_name}'."
    end

    desc "Create a superuser to the database"
    task :create_super_user, [:email, :password] => :environment do |t, args|
      return puts 'Email or password required.' unless args[:email].present? && args[:password].present?
      return puts "#{args[:email]} is taken, try another one." if User.exists?(email: args[:email])
      SuperUser.create!(email: args[:email], password: args[:password])
      puts "Created superuser #{args[:email]}."
    end
  end
end
