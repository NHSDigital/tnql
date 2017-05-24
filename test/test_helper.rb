$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tnql'

require 'minitest/autorun'
require 'minitest/unit'

# Override the default Date#to_s format to ensure the formmating is right
Date::DATE_FORMATS.update(default: '%d.%m.%Y')

# This method helps make the assertion that a query producing more than one meta_data filter
# contains all the meta_data filters of the equivalent array of of individual queries.
# i.e. the query:
#
#   'all tumours diagnosed in january 2011 with unprocessed records'
#
# contains all the meta_data filters of the following queries:
#
#   'all tumours diagnosed in january 2011'
#   'all tumours with unprocessed records'
#
def assert_meta_data_includes(combined_query, individual_queries)
  combined_meta_data = combined_query.meta_data
  individual_queries.each do |individual_query|
    individual_meta_data = Tnql::Parser.new(individual_query).meta_data
    individual_meta_data.each do |name, filter|
      assert_equal combined_meta_data[name], filter,
                   "combined meta data does not include #{filter.inspect}"
    end
  end
end
