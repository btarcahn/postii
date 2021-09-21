# Place to register constants
module PostiiConstants

  LICENSE = 'Apache 2.0'
  AUTHOR = 'Bach Tran'

  # A list of common error messages and their explanations
  COMMON_ERRORS = {
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

    # Messages
    'MSG00001': {
      'message': 'Completed!',
      'reason': 'The resource has been executed successfully.'
    }
  }
end
