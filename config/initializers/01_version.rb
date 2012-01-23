module Balance
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 4
    TINY = 2
    BUILD = "pre" # nil, "pre", "beta1", "beta2", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end