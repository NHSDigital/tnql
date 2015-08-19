require 'test_helper'

# patient vital status tests
class VitalStatusTest < Minitest::Test
  def test_should_filter_by_patient_vital_status
    parser = Tnql::Parser.new('all tumours for dead patients')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => true }, parser.meta_data['patient.dead'])

    parser = Tnql::Parser.new('all tumours for alive patients')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => false }, parser.meta_data['patient.dead'])
  end

  def test_should_filter_by_existence_of_patient_death_certificate
    parser = Tnql::Parser.new('all tumours for patients who have a death certificate')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => true }, parser.meta_data['patient.death_certificate'])

    parser = Tnql::Parser.new('all tumours for patients who have no death certificate')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => false }, parser.meta_data['patient.death_certificate'])
  end
end
