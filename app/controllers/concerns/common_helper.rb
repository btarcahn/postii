module CommonHelper
  extend ActiveSupport::Concern

  def CommonHelper.count_formatter(string)
    string.scan(/%([csiguxo]|[1-9]?d|[0-9]?+(.[1-9])?[fe])/).size
  end

  def CommonHelper.construct_error_message(code, args=[], custom_message=nil)
    pulled_message = ErrMsg.find_by(err_code: code)[:message]

    message = if custom_message.present?
                custom_message
              else
                pulled_message.present? ? pulled_message : 'Can\'t find a corresponding message, please contact admin.'
              end
    n_args_expected = CommonHelper.count_formatter(message)
    n_args_actual = args ? args.size : 0
    raise ArgumentError.new(
            "Wrong number of args: expected #{n_args_expected} but received #{n_args_actual} in args. Raw message: \"#{message}\"."
          ) unless n_args_expected == n_args_actual
    {
      code: code,
      message: message % args
    }
  end
end
