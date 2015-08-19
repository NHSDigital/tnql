require 'test_helper'

# tumour type tests
class TumourTypeTest < Minitest::Test
  def test_should_filter_by_site
    parser = Tnql::Parser.new('all C509 tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(C509) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_snomed_site
    parser = Tnql::Parser.new('all T28802 tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(T28802) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_site_part
    parser = Tnql::Parser.new('all C50 tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(C50) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_snomed_site_part
    parser = Tnql::Parser.new('all T28 T77 tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(T28 T77) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_site_sentence
    parser = Tnql::Parser.new('all C71, C78 and C85 tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(C71 C78 C85) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_site_list
    parser = Tnql::Parser.new('all C71  C78  C85 tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(C71 C78 C85) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_site_list_with_double_spaces
    parser = Tnql::Parser.new('all C71 C78 C85 tumours')
    assert parser.valid?, parser.failure_reason.to_s
    assert_equal({ Tnql::BEGINS => %w(C71 C78 C85) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_site_list_with_commas
    parser = Tnql::Parser.new('all C71,C78,C85 tumours')
    assert parser.valid?, parser.failure_reason.to_s
    assert_equal({ Tnql::BEGINS => %w(C71 C78 C85) }, parser.meta_data['tumour.primarycode'])
  end

  def test_should_filter_by_site_group
    parser = Tnql::Parser.new('all lower gi tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 4 }, parser.meta_data['tumour.site_group'])
  end

  def test_should_filter_by_melanoma_named_type
    parser = Tnql::Parser.new('all melanoma tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => 'C43' }, parser.meta_data['tumour.icd10o2_primarycode'])
  end

  def test_should_filter_by_non_melanoma_named_type
    parser = Tnql::Parser.new('all non-melanoma tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => 'C44' }, parser.meta_data['tumour.icd10o2_primarycode'])
  end

  def test_should_filter_by_non_melanoma_named_type_equivalences
    assert_equal Tnql::Parser.new('all non-melanoma tumours').meta_data,
                 Tnql::Parser.new('all non melanoma tumours').meta_data

    assert_equal Tnql::Parser.new('all non-melanoma tumours').meta_data,
                 Tnql::Parser.new('all nmsc tumours').meta_data
  end

  def test_should_filter_by_behaviour
    parser = Tnql::Parser.new('all behaviour 2 tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => '2' }, parser.meta_data['tumour.behaviour'])
  end

  def test_should_filter_by_noninvasive_behaviour
    parser = Tnql::Parser.new('all noninvasive tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(0 1 2) }, parser.meta_data['tumour.behaviour'])

    parser = Tnql::Parser.new('all non-invasive tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(0 1 2) }, parser.meta_data['tumour.behaviour'])
  end

  def test_should_filter_by_invasive_behaviour
    parser = Tnql::Parser.new('all invasive tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(3 5) }, parser.meta_data['tumour.behaviour'])
  end

  def test_should_filter_by_metastatic_behaviour
    parser = Tnql::Parser.new('all metastatic tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => '6' }, parser.meta_data['tumour.behaviour'])
  end
end
