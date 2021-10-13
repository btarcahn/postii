require './lib/PostiiConstants'

namespace :db do
  desc "add default error messages to the database"
  task :seed_err_msg, [:drop_table] => :environment do |t, args|
    if %w[drop_table reset].include? args[:drop_table]
      ErrMsg.delete_all
    end
    PostiiConstants::COMMON_ERRORS.each do |err_code, value|
      ErrMsg.create err_code: err_code,
                    message: value[:message],
                    reason: value[:reason],
                    component: 'core',
                    additional_note: 'created with rails db:seed_err_msg'
    end
  end

end
