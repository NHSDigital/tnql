require 'chronic'
require 'ndr_support/daterange'

module Tnql #:nodoc: all
  module Nodes
    module FuzzyDateNode
      def to_daterange
        date.to_daterange
      end
    end

    module SpecificDateNode
      def to_daterange
        date_fragment.to_daterange
      end
    end

    module FragmentedDateRangeNode
      def to_daterange
        d1 = start.to_daterange.date1
        d2 = finish.to_daterange.date2

        Daterange.new(d1, d2)
      end
    end

    module DateFragmentNode
      def to_daterange
        fragment.to_daterange
      end
    end

    module DateRangeNode
      def to_daterange
        Daterange.new(text_value.to_s)
      end
    end

    module ChronicDateNode
      def to_daterange
        chronic = Chronic.parse(text_value.to_s, :context => :past, :guess => false)
        if chronic.instance_of?(Chronic::Span)
          Daterange.new(chronic.begin, chronic.end - 1.day)
        else
          Daterange.new(chronic)
        end
      end
    end
  end
end
