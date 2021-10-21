module AlertHelpers
  extend ActiveSupport::Concern

  # Constructs a message hash of structure: {code: code, message: message}
  def message!(code, args=[], custom_message=nil)
    if custom_message.present?
      return {code: '', message: custom_message}
    end

    message = ErrMsg.exists?(err_code: code) ? ErrMsg.find_by_err_code(code)[:message] :
                "Can't find message with code #{code}. Please contact admin."
    n_args_expected = count_formatter(message)
    n_args_actual = args ? args.size : 0
    raise ArgumentError.new(
      "Wrong number of args: expected #{n_args_expected} but received #{n_args_actual} in args. Raw message: \"#{message}\"."
    ) unless n_args_expected == n_args_actual
    {
      code: code,
      message: message % args
    }
  end

  private
  # Count the number of formatters, e.g. %s %d %f in a given string
  def count_formatter(string)
    string.scan(/%([csiguxo]|[1-9]?d|[0-9]?+(.[1-9])?[fe])/).size
  end

end
