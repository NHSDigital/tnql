require 'test_helper'

# main entry point tests
class MainTest < Minitest::Test
  def test_should_not_filter_all_tumours
    parser = Tnql::Parser.new('all tumours')
    assert parser.valid?
    assert_instance_of Hash, parser.meta_data
    assert parser.meta_data.empty?
    assert_nil parser.failure_reason
  end

  def test_should_filter_by_record_count
    parser = Tnql::Parser.new('first 27 tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 27 }, parser.meta_data['limit'])
  end
end
