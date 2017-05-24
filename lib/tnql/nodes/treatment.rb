module Tnql #:nodoc: all
  module Nodes
    module TreatmentDateRangeNode
      def meta_data_item
        {
          'treatment.startoradmissiondate' => {
            Tnql::LIMITS => [
              start.to_daterange.date1.try(:to_date).try(:iso8601),
              finish.to_daterange.date2.try(:to_date).try(:iso8601)
            ]
          }
        }
      end
    end

    module TreatmentPreciseDateNode
      def meta_data_item
        date_range = date_fragment.to_daterange

        {
          'treatment.startoradmissiondate' => {
            Tnql::LIMITS => [
              date_range.date1.try(:to_date).try(:iso8601),
              date_range.date2.try(:to_date).try(:iso8601)
            ]
          }
        }
      end
    end

    module TreatmentProviderNameNode
      def meta_data_item
        { 'treatment.providername' => { Tnql::MESSAGE => 'TODO: "' + text_value + '" ignored' } }
      end
    end

    module TreatmentProviderCodeNode
      def meta_data_item
        # default to provider
        key = provider_type.text_value == 'cancer network' ? 'cn_ukacr' : 'providercode'
        { "treatment.#{key}" => { Tnql::EQUALS => code.text_value.upcase } }
      end
    end
  end
end
