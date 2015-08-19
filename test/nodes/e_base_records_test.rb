require 'test_helper'

# registration action and unprocessed record tests
class EBaseRecordsTest < Minitest::Test
  def test_should_filter_by_wait_action
    parser = Tnql::Parser.new('all tumours with wait action')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'WAIT' }, parser.meta_data['action.actioninitiated'])
  end

  def test_should_filter_by_action_hosital_code
    parser = Tnql::Parser.new('all tumours with search action at hospital RGT01')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'SEARCH' }, parser.meta_data['action.actioninitiated'])
    assert_equal({ Tnql::EQUALS => 'HOSPITAL' }, parser.meta_data['action.providertype'])
    assert_equal({ Tnql::EQUALS => 'RGT01' }, parser.meta_data['action.providercode'])
  end

  def test_should_filter_by_action_hosital_name
    parser = Tnql::Parser.new('all tumours with search action at addenbrookes hospital')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'SEARCH' }, parser.meta_data['action.actioninitiated'])
    assert_equal({ Tnql::EQUALS => 'HOSPITAL' }, parser.meta_data['action.providertype'])
    assert_equal({ Tnql::BEGINS => 'ADDENBROOKES' }, parser.meta_data['action.providername'])
  end

  def test_should_filter_by_unprocessed_records
    parser = Tnql::Parser.new('all tumours with unprocessed records')
    assert parser.valid?
    assert_equal({ Tnql::ALL => true }, parser.meta_data['unprocessed_records.sources'])
  end

  def test_should_filter_by_particular_types_of_unprocessed_records
    parser = Tnql::Parser.new('all tumours with unprocessed path, cancer wait or death records')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(UPATH UCWT UCD) },
                 parser.meta_data['unprocessed_records.sources'])

    parser = Tnql::Parser.new('all tumours with unprocessed weird records')
    refute parser.valid?
  end
end
