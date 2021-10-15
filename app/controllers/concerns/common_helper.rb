module CommonHelper
  extend ActiveSupport::Concern

  def CommonHelper.count_formatter(string)
    string.scan(/%([csiguxo]|[1-9]?d|[0-9]?+(.[1-9])?[fe])/).size
  end

  def CommonHelper.error!(code='', args=[], custom_message=nil)
    message_not_found = "Cannot find message for error code #{code}. Contact admin for information."
    message = if custom_message.present?
                custom_message
              else
                ErrMsg.exists?(err_code: code) ? ErrMsg.find_by(err_code: code)[:message] : message_not_found
              end
    n_args_expected = CommonHelper.count_formatter(message)
    n_args_actual = args ? args.size : 0
    raise ArgumentError.new("Wrong number of args: expected #{n_args_expected} but received #{n_args_actual} in args. Raw message: \"#{message}\".") unless n_args_expected == n_args_actual
    { code: code, message: message % args }
  end
end
