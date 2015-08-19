require 'test_helper'

# diagnosis date tests
class DiagnosisTest < Minitest::Test
  def test_should_filter_by_diagnosis_year
    parser = Tnql::Parser.new('all tumours diagnosed in 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-01-01', '2010-12-31'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_filter_by_diagnosis_month_year
    parser = Tnql::Parser.new('all tumours diagnosed in 08.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-01', '2010-08-31'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_filter_by_diagnosis_day_month_year
    parser = Tnql::Parser.new('all tumours diagnosed on 03.08.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-03', '2010-08-03'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_filter_by_diagnosis_month_in_words_and_year
    parser = Tnql::Parser.new('all tumours diagnosed in aug 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-01', '2010-08-31'] },
                 parser.meta_data['tumour.diagnosisdate'])

    parser = Tnql::Parser.new('all tumours diagnosed in august 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-01', '2010-08-31'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_filter_by_diagnosis_year_range
    parser = Tnql::Parser.new('all tumours diagnosed between 2007 and 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-01-01', '2010-12-31'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_filter_by_diagnosis_month_year_range
    parser = Tnql::Parser.new('all tumours diagnosed between 08.2007 and 07.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-01', '2010-07-31'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_filter_by_diagnosis_day_month_year_range
    parser = Tnql::Parser.new('all tumours diagnosed between 03.08.2007 and 15.07.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-03', '2010-07-15'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_return_diagnosis_range_correctly
    parser = Tnql::Parser.new('all tumours')
    assert_nil parser.diagnosis_range

    parser = Tnql::Parser.new('all tumours diagnosed between 03.11.2007 and 15.12.2010')
    assert_equal Daterange.new('03.11.2007 to 15.12.2010'), parser.diagnosis_range

    parser = Tnql::Parser.new('all tumours diagnosed in January 2012')
    assert_equal Daterange.new('01.01.2012 to 31.01.2012'), parser.diagnosis_range
  end

  def test_should_filter_by_month_in_words_and_diagnosis_year_range
    parser = Tnql::Parser.new('all tumours diagnosed between aug 2007 and jul 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-01', '2010-07-31'] },
                 parser.meta_data['tumour.diagnosisdate'])

    parser = Tnql::Parser.new('all tumours diagnosed between august 2007 and july 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-01', '2010-07-31'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end

  def test_should_filter_by_chronic_diagnosis_date
    parser = Tnql::Parser.new('all tumours diagnosed on february 14, 2004')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2004-02-14', '2004-02-14'] },
                 parser.meta_data['tumour.diagnosisdate'])
  end
end
