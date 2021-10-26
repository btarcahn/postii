namespace :db do
  namespace :core do

    email = {
      guest: 'public.guest@postii.com', sys_admin: 'bach.tran@employmenthero.com'
    }

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
                      additional_note: 'created with rails db:core:alerts'
      end
      puts "Added #{AlertHelpers::ALERTS.count} to '#{table_name}'."
    end

    desc "Create first and second Creators"
    task creators: :environment do
      sys_admin = Creator.create!(
        creator_name: 'Postii System Administrators',
        email_address: email[:sys_admin],
        sector_code: 'core',
      )

      guest = Creator.create!(
        creator_name: 'Public Guest',
        email_address: email[:guest],
        sector_code: 'core'
      )

      puts "Injected {#{sys_admin.email_address}, id=#{sys_admin.id}} as sysadmin, and {#{guest.email_address}, id=#{guest.id}} as guest."
    end

    desc "Create a superuser to the database"
    task :create_super_user, [:email, :password] => :environment do |t, args|

      # Check if first and second Creators exist
      unless Creator.exists?(email_address: email[:sys_admin]) && Creator.exists?(email_address: email[:guest])
        return puts "Creators #{email.values} required. Try to run 'rails db:core:creators'"
      end

      # Check parameters
      return puts 'Email or password required.' unless args[:email].present? && args[:password].present?
      return puts "#{args[:email]} is taken, try another one." if User.exists?(email: args[:email])

      # Fetch the sysadmin
      sysadmin = Creator.find_by_email_address(email[:sys_admin])

      SuperUser.create!(email: args[:email], password: args[:password], creator: sysadmin)
      puts "Created superuser #{args[:email]} and assigned to sysadmin #{sysadmin.email_address}"
    end

    desc 'Setup the fresh database (only for first-time users)'
    task setup: %w[db:core:alerts db:core:creators]
  end
end
