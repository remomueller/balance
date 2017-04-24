# frozen_string_literal: true

module Balance
  module VERSION #:nodoc:
    MAJOR = 2
    MINOR = 3
    TINY = 1
    BUILD = 'pre' # 'pre', 'beta1', 'beta2', 'rc', 'rc2', nil

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
