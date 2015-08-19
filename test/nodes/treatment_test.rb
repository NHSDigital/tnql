require 'test_helper'

# treatment date and provider tests
class TreatmentTest < Minitest::Test
  def test_should_filter_by_treatment_year
    parser = Tnql::Parser.new('all tumours treated in 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-01-01', '2010-12-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_treatment_month_year
    parser = Tnql::Parser.new('all tumours treated in 08.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-01', '2010-08-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_treatment_day_month_year
    parser = Tnql::Parser.new('all tumours treated on 03.08.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-03', '2010-08-03'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_treatment_month_in_words_and_year
    parser = Tnql::Parser.new('all tumours treated in aug 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-01', '2010-08-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])

    parser = Tnql::Parser.new('all tumours treated in august 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2010-08-01', '2010-08-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_treatment_year_range
    parser = Tnql::Parser.new('all tumours treated between 2007 and 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-01-01', '2010-12-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_treatment_month_year_range
    parser = Tnql::Parser.new('all tumours treated between 08.2007 and 07.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-01', '2010-07-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_treatment_day_month_year_range
    parser = Tnql::Parser.new('all tumours treated between 03.08.2007 and 15.07.2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-03', '2010-07-15'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_month_in_words_and_treatment_year_range
    parser = Tnql::Parser.new('all tumours treated between aug 2007 and jul 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-01', '2010-07-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])

    parser = Tnql::Parser.new('all tumours treated between august 2007 and july 2010')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2007-08-01', '2010-07-31'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_chronic_treatment_date
    parser = Tnql::Parser.new('all tumours treated on february 14, 2004')
    assert parser.valid?
    assert_equal({ Tnql::LIMITS => ['2004-02-14', '2004-02-14'] },
                 parser.meta_data['treatment.startoradmissiondate'])
  end

  def test_should_filter_by_treatment_hospital_code
    parser = Tnql::Parser.new('all tumours treated at hospital RGT01')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'RGT01' },
                 parser.meta_data['treatment.providercode'])
  end

  def test_should_filter_by_treatment_cancer_network_code
    parser = Tnql::Parser.new('all tumours treated at cancer network N20')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'N20' },
                 parser.meta_data['treatment.cn_ukacr'])
  end
end
