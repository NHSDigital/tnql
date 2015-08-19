module Tnql #:nodoc: all
  module Nodes
    module RegistrationStatusNode
      def meta_data_item
        { 'tumour.statusofregistration' => { Tnql::EQUALS => statuses } }
      end

      def statuses
        [status_keyword.statusofregistration] + remaining_statuses
      end

      def remaining_statuses
        more_statuses.elements.map do |comma_and_status|
          comma_and_status.status_keyword.statusofregistration
        end
      end
    end

    module StatusKeywordNode
      def statusofregistration
        # Currently every status is the upper case first letter of the description
        # May need to replace this with a case statement at a later date, if needed
        text_value[0, 1].upcase
      end
    end
  end
end
