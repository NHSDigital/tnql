module Tnql #:nodoc: all
  module Nodes
    module DeadOrAliveNode
      def meta_data_item
        { 'patient.dead' => { Tnql::EQUALS => vital_status.text_value == 'dead' } }
      end
    end

    module DeathCertificateNode
      def meta_data_item
        { 'patient.death_certificate' => { Tnql::EQUALS => modifier.text_value != 'no' } }
      end
    end
  end
end
