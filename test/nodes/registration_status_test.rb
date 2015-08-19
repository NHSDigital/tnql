require 'test_helper'

# tumour status test
class RegistrationStatusTest < Minitest::Test
  def test_should_filter_by_final_statusofregistration
    parser = Tnql::Parser.new('final tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(F) }, parser.meta_data['tumour.statusofregistration'])
  end

  def test_should_filter_by_provisional_statusofregistration
    parser = Tnql::Parser.new('provisional tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(P) }, parser.meta_data['tumour.statusofregistration'])
  end

  def test_should_filter_by_referenced_statusofregistration
    parser = Tnql::Parser.new('referenced tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(R) }, parser.meta_data['tumour.statusofregistration'])
  end

  def test_should_filter_by_referenced_and_provisional_statusofregistration
    parser = Tnql::Parser.new('referenced and provisional tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(R P) }, parser.meta_data['tumour.statusofregistration'])
  end

  def test_should_filter_by_treatment_only_and_provisional_statusofregistration
    parser = Tnql::Parser.new('treatment only and provisional tumours')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => %w(T P) }, parser.meta_data['tumour.statusofregistration'])
  end
end
