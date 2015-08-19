require 'test_helper'

# patient-based querying
class PatientTest < Minitest::Test
  def test_should_filter_by_patient_gender
    parser = Tnql::Parser.new('all tumours for male patients')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => '1' }, parser.meta_data['patient.sex'])

    parser = Tnql::Parser.new('all tumours for female patients')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => '2' }, parser.meta_data['patient.sex'])
  end
end
