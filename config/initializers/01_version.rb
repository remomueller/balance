module Balance
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 11
    TINY = 0
    BUILD = nil # 'pre', 'beta1', 'beta2', 'rc', 'rc2', nil

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
