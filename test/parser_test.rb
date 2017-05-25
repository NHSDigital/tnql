require 'test_helper'

class ParserTest < Minitest::Test
  def test_tnql_parser
    query = "first 27 referenced ecric non-invasive stage 4 head and neck tumours \
      diagnosed between august 2010 and oct 2010 at hospital RGT01 treated at hospital RGN42 \
      with wait action and unprocessed pas, uhaem, or somerset records for dead male patients \
      who were born in 1999, died between may 2001 and aug 2003, and have no death certificate"
    parser = TnqlParser.new
    parser.parse(query.downcase)
  end

  def test_should_raise_exception_on_non_string_query
    assert_raises ArgumentError do
      Tnql::Parser.new(/all tumours/)
    end
  end

  def test_should_display_error_msg_on_empty_query
    parser = Tnql::Parser.new('')
    refute parser.valid?
    assert_instance_of Hash, parser.meta_data
    assert parser.meta_data.empty?
    refute_nil parser.failure_reason
  end

  def test_should_display_error_msg_on_invalid_query
    parser = Tnql::Parser.new('bob and simon')
    refute parser.valid?
    assert parser.meta_data.empty?
    refute_nil parser.failure_reason
  end

  def test_should_cope_with_a_mixed_case_query
    parser = Tnql::Parser.new('All Tumours')
    assert parser.valid?
    assert parser.meta_data.empty?
    assert_nil parser.failure_reason
  end

  def test_should_capture_correct_characters_for_short_chronic_date_in_combined_query
    parser = Tnql::Parser.new('all tumours diagnosed in aug 2011 at hospital RGT01')
    assert parser.valid?
    assert_equal 2, parser.meta_data.count
    individual_queries = [
      'all tumours diagnosed in aug 2011',
      'all tumours diagnosed at hospital RGT01'
    ]
    assert_meta_data_includes(parser, individual_queries)
  end

  def test_should_capture_correct_characters_for_chronic_dates_in_combined_query
    parser = Tnql::Parser.new('all tumours diagnosed between august 2010 and oct 2010 ' \
                            'with staged action')
    assert parser.valid?
    assert_equal 2, parser.meta_data.count
    individual_queries = [
      'all tumours diagnosed between august 2010 and oct 2010',
      'all tumours with staged action'
    ]
    assert_meta_data_includes(parser, individual_queries)
  end

  def test_should_capture_correct_characters_for_long_chronic_dates_in_combined_query
    parser = Tnql::Parser.new('all tumours diagnosed in january 2011 with unprocessed records')
    assert parser.valid?
    assert_equal 2, parser.meta_data.count
    individual_queries = [
      'all tumours diagnosed in january 2011',
      'all tumours with unprocessed records'
    ]
    assert_meta_data_includes(parser, individual_queries)
  end

  # patient-based querying

  def test_should_filter_by_patient_with_multiple_pre_conditions
    parser = Tnql::Parser.new('all tumours for dead teenage male patients')
    assert parser.valid?
    assert_equal 3, parser.meta_data.count
  end

  def test_should_filter_by_patient_with_multiple_post_conditions
    parser = Tnql::Parser.new('all tumours for patients who were aged 12, were born in 1985, ' \
                            'died between 2001 and 2003, and have no death certificate')
    assert parser.valid?
    assert_equal 4, parser.meta_data.count
  end

  # advanced tests

  def test_should_allow_reordering_of_filters
    [
      'first 27 referenced ecric non-invasive stage 4 head and neck tumours',
      'first 27 ecric stage 4 head and neck non-invasive referenced tumours'
    ].each do |query_string|
      parser = Tnql::Parser.new(query_string)
      assert parser.valid?, "Query not valid: '#{query_string}'"
      assert_equal 6, parser.meta_data.count
      individual_queries = [
        'first 27 tumours',
        'referenced tumours',
        'all ecric tumours',
        'all stage 4 tumours',
        'all head and neck tumours',
        'all non-invasive tumours'
      ]
      assert_meta_data_includes(parser, individual_queries)
    end
  end

  def test_should_combine_filters
    parser = Tnql::Parser.new("first 27 referenced ecric non-invasive stage 4 \
      head and neck tumours \
      diagnosed between august 2010 and oct 2010 at hospital RGT01 treated at hospital RGN42 \
      with wait action and unprocessed pas, uhaem, or somerset records for dead male patients \
      who were born in 1999, died between may 2001 and aug 2003, and have no death certificate")
    assert parser.valid?
    assert_equal 16, parser.meta_data.count
    individual_queries = [
      'first 27 tumours',
      'referenced tumours',
      'all ecric tumours',
      'all non-invasive tumours',
      'all stage 4 tumours',
      'all head and neck tumours',
      'all tumours diagnosed between august 2010 and oct 2010',
      'all tumours diagnosed at hospital RGT01',
      'all tumours treated at hospital RGN42',
      'all tumours with wait action',
      'all tumours with unprocessed pas, uhaem, or somerset records',
      'all tumours for dead patients',
      'all tumours for male patients',
      'all tumours for patients who were born in 1999',
      'all tumours for patients who died between may 2001 and aug 2003',
      'all tumours for patients who have no death certificate'
    ]
    assert_meta_data_includes(parser, individual_queries)
  end
end
