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

  # Common alert messages, this may be transferred to a csv file
  ALERTS = {
    'ERR00000': {
      'message': 'Please contact administrator.',
      'reason': 'Something went wrong in general, so please contact an admin for solutions.'
    },
    'ERR00001': {
      'message': "%s is not allowed.",
      'reason': 'The system does not allow you to do this.'
    },
    'ERR00002': {
      'message': "%s is not implemented.",
      'reason': 'The accessed resource is not implemented. It may be implemented in the future.'
    },
    'ERR00003': {
      'message': "%s is not available.",
      'reason': 'The requested entity is not available/ can\'t be found.'
    },
    'ERR00004': {
      'message': 'Not authenticated.',
      'reason': 'This resource cannot be accessed because you don\'t have permission.'
    },

    'ERR00005': {
      'message': 'Not found',
      'reason': 'The requested entity is not available/ can\'t be found.'
    },

    'ERR00006': {
      'message': 'Invalid login credentials',
      'reason': 'You have provided the wrong username or password.'
    },

    'ERR00007': {
      'message': '%s already exists',
      'reason': 'This record already exists in database, cannot create a new one due to uniqueness.'
    },

    'ERR00008': {
      'message': "The request is correct, but something went wrong so we can't process your request",
      'reason': "The parameters supplied is correct but it can't be handled in the database."
    },

    'ERR00009': {
      'message': 'Insufficient authority',
      'reason': "Your account doesn't have enough permission to access this resource."
    },

    # Messages
    'MSG00001': {
      'message': 'Completed!',
      'reason': 'The resource has been executed successfully.'
    }
  }

  private
  # Count the number of formatters, e.g. %s %d %f in a given string
  def count_formatter(string)
    string.scan(/%([csiguxo]|[1-9]?d|[0-9]?+(.[1-9])?[fe])/).size
  end

end
