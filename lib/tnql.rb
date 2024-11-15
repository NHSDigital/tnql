require 'active_support/deprecation'
begin
  require 'active_support/deprecator'
rescue LoadError
  # Ignore error: 'active_support/deprecator'' is not defined on active_support 7.0
end
require 'active_support/time'

require 'tnql/version'
require 'tnql/parser'
