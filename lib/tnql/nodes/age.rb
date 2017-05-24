module Tnql #:nodoc: all
  module Nodes
    module AgeNode
      def to_limits
        age.to_limits
      end
    end

    module ExactAgeNode
      def to_exact
        text_value.to_i
      end

      def to_limits
        i = to_exact
        [i, i]
      end
    end

    module FuzzyAgeNode
      def to_limits
        [start.to_exact, finish.to_exact]
      end
    end

    module AgeAtDiagnosisNode
      def meta_data_item
        { 'patient.age' => { Tnql::LIMITS => age.to_limits } }
      end
    end

    module DeathDateNode
      def meta_data_item
        range = fuzzy_date.to_daterange
        {
          'patient.deathdate' => {
            Tnql::LIMITS => [
              range.date1.try(:to_date).try(:iso8601), range.date2.try(:to_date).try(:iso8601)
            ]
          }
        }
      end
    end

    module BirthDateNode
      def meta_data_item
        range = fuzzy_date.to_daterange
        {
          'patient.birthdate' => {
            Tnql::LIMITS => [
              range.date1.try(:to_date).try(:iso8601), range.date2.try(:to_date).try(:iso8601)
            ]
          }
        }
      end
    end

    module CtyaNode
      def meta_data_item
        { 'patient.age' => { Tnql::LIMITS => [0, 24] } }
      end
    end

    module PaediatricNode
      def meta_data_item
        { 'patient.age' => { Tnql::LIMITS => [0, 15] } }
      end
    end

    module TeenageNode
      def meta_data_item
        { 'patient.age' => { Tnql::LIMITS => [16, 18] } }
      end
    end

    module YoungAdultNode
      def meta_data_item
        { 'patient.age' => { Tnql::LIMITS => [19, 24] } }
      end
    end
  end
end
