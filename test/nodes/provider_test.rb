require 'test_helper'

# diagnosis provider tests
class ProviderTest < Minitest::Test
  def test_should_filter_by_hospital_code
    parser = Tnql::Parser.new('all tumours diagnosed at hospital RGT01')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'RGT01' }, parser.meta_data['diagnosis.providercode'])
  end

  def test_should_filter_by_hospital_name
    parser = Tnql::Parser.new("all tumours diagnosed at addenbrooke's hospital")
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => "ADDENBROOKE'S", :interval => 25...47 },
                 parser.meta_data['diagnosis.providername'])
  end

  def test_should_filter_by_cancer_network_code
    parser = Tnql::Parser.new('all tumours diagnosed at cancer network N20')
    assert parser.valid?
    assert_equal({ Tnql::EQUALS => 'N20' }, parser.meta_data['diagnosis.cn_ukacr'])
  end

  def test_should_filter_by_cancer_network_name
    parser = Tnql::Parser.new('all tumours diagnosed at mount vernon cancer network')
    assert parser.valid?
    assert_equal({ Tnql::BEGINS => 'MOUNT VERNON', :interval => 25...52 },
                 parser.meta_data['diagnosis.cn_ukacrname'])
  end
end
