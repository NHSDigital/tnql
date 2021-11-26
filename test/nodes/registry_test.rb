require 'test_helper'

# tumour host registry tests
class RegistryTest < Minitest::Test
  def test_should_filter_by_registry_code
    parser = Tnql::Parser.new('all y0401 tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => ['Y0401', false] }, parser.meta_data['tumour.registry'])
  end

  def test_should_filter_by_registry_abbreviation
    parser = Tnql::Parser.new('all ecric tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => ['Y0401', false] }, parser.meta_data['tumour.registry'])
  end

  def test_should_filter_by_oxford_registry_abbreviation
    parser = Tnql::Parser.new('all oxford tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => ['Y0901', false] }, parser.meta_data['tumour.registry'])
  end

  def test_should_able_to_exclude_channel_islands_for_y1001_swcis
    parser = Tnql::Parser.new('all non channel islands y1001 tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => ['Y1001', true] }, parser.meta_data['tumour.registry'])
  end

  def test_should_able_to_exclude_isle_of_man_for_y1701_nwcis
    parser = Tnql::Parser.new('all exclude iom nwcis tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => ['Y1701', true] }, parser.meta_data['tumour.registry'])

    parser = Tnql::Parser.new('all not isle of man y1701 tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => ['Y1701', true] }, parser.meta_data['tumour.registry'])
  end

  def test_should_not_exclude_if_regirsty_doesnot_have_crown_dependency
    parser = Tnql::Parser.new('all exclude channel islands ecric tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => ['Y0401', false] }, parser.meta_data['tumour.registry'])
  end

  def test_should_filter_by_registry_equivalences
    assert_equal Tnql::Parser.new('all oxford tumours').meta_data,
                 Tnql::Parser.new('all ociu tumours').meta_data
  end
end
