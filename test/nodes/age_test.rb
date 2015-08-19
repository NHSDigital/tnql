require 'test_helper'

# patient age tests
class AgeTest < Minitest::Test
  def test_should_filter_by_ctya_patient_age_group
    parser = Tnql::Parser.new('all tumours for ctya patients')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => [0, 24] }, parser.meta_data['patient.age'])
  end

  def test_should_filter_by_paediatric_patient_age_group
    parser = Tnql::Parser.new('all tumours for paediatric patients')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => [0, 15] }, parser.meta_data['patient.age'])
  end

  def test_should_filter_by_teenage_patient_age_group
    parser = Tnql::Parser.new('all tumours for teenage patients')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => [16, 18] }, parser.meta_data['patient.age'])
  end

  def test_should_filter_by_young_adult_patient_age_group
    parser = Tnql::Parser.new('all tumours for young adult patients')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => [19, 24] }, parser.meta_data['patient.age'])
  end

  def test_should_filter_by_year_patient_birthdate
    parser = Tnql::Parser.new('all tumours for patients who were born in 2012')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2012-01-01', '2012-12-31'] },
                 parser.meta_data['patient.birthdate'])
  end

  def test_should_filter_by_exact_patient_birthdate
    parser = Tnql::Parser.new('all tumours for patients who were born on 12.1.2012')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2012-01-12', '2012-01-12'] },
                 parser.meta_data['patient.birthdate'])
  end

  def test_should_filter_by_daterange_patient_birthdate
    parser = Tnql::Parser.new('all tumours for patients ' \
                             'who were born between may 1990 and oct 1992')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['1990-05-01', '1992-10-31'] },
                 parser.meta_data['patient.birthdate'])
  end

  def test_should_filter_by_year_patient_death_date
    parser = Tnql::Parser.new('all tumours for patients who died in 1982')
    assert_equal({ Tnql::LIMITS => ['1982-01-01', '1982-12-31'] },
                 parser.meta_data['patient.deathdate'])
  end

  def test_should_filter_by_exact_patient_death_date
    parser = Tnql::Parser.new('all tumours for patients who died on 4.2.1998')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['1998-02-04', '1998-02-04'] },
                 parser.meta_data['patient.deathdate'])
  end

  def test_should_filter_by_daterange_patient_death_date
    parser = Tnql::Parser.new('all tumours for patients who died between may 2001 and nov 2002')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2001-05-01', '2002-11-30'] },
                 parser.meta_data['patient.deathdate'])
  end

  def test_should_filter_by_patient_age_at_diagnosis
    parser = Tnql::Parser.new('all tumours for patients who were aged 12')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => [12, 12] }, parser.meta_data['patient.age'])

    parser = Tnql::Parser.new('all tumours for patients who were aged between 0 and 123')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => [0, 123] }, parser.meta_data['patient.age'])
  end
end
