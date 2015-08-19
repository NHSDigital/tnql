require 'test_helper'

# tumour host registry tests
class RegistryTest < Minitest::Test
  def test_should_filter_by_registry_code
    parser = Tnql::Parser.new('all y0401 tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'Y0401' }, parser.meta_data['tumour.registry'])
  end

  def test_should_filter_by_registry_abbreviation
    parser = Tnql::Parser.new('all ecric tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'Y0401' }, parser.meta_data['tumour.registry'])
  end

  def test_should_filter_by_oxford_registry_abbreviation
    parser = Tnql::Parser.new('all oxford tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'Y0901' }, parser.meta_data['tumour.registry'])
  end

  def test_should_filter_by_registry_equivalences
    assert_equal Tnql::Parser.new('all oxford tumours').meta_data,
                 Tnql::Parser.new('all ociu tumours').meta_data
  end
end
