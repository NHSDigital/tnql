module Tnql #:nodoc: all
  module Nodes
    module DiagnosisDateRangeNode
      def meta_data_item
        { 'tumour.diagnosisdate' =>
          { Tnql::LIMITS =>
            [
              start.to_daterange.date1.try(:to_date).try(:iso8601),
              finish.to_daterange.date2.try(:to_date).try(:iso8601)
            ]
          }
        }
      end
    end

    module DiagnosisDetailNode
      def meta_data_item
        range = date_fragment.to_daterange

        { 'tumour.diagnosisdate' =>
          { Tnql::LIMITS =>
            [
              range.date1.try(:to_date).try(:iso8601),
              range.date2.try(:to_date).try(:iso8601)
            ]
          }
        }
      end
    end
  end
end
