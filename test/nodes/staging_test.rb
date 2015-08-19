require 'test_helper'

# tumour stage tests
class StagingTest < Minitest::Test
  def test_should_filter_by_stage_4
    parser = Tnql::Parser.new('all stage 4 tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(4) }, parser.meta_data['staging.stage'])
  end

  def test_should_filter_by_stage_u
    parser = Tnql::Parser.new('all stage U tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(U) }, parser.meta_data['staging.stage'])
  end

  def test_should_filter_by_stage_question_mark
    parser = Tnql::Parser.new('all stage ? tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(?) }, parser.meta_data['staging.stage'])
  end

  def test_should_filter_by_stage_1_u_question_mark
    parser = Tnql::Parser.new('all stage 1U? tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(1 U ?) }, parser.meta_data['staging.stage'])
  end

  def test_should_filter_by_valid_stage
    parser = Tnql::Parser.new('all valid stage tumours')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => %w(1 2 3 4) }, parser.meta_data['staging.stage'])
  end

  def test_should_filter_by_unstaged
    parser = Tnql::Parser.new('all unstaged tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => nil }, parser.meta_data['staging.stage'])
  end
end
