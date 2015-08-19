module Tnql #:nodoc: all
  module Nodes
    module BatchTypeNode
      def to_type
        string = respond_to?(:normalise) ? normalise : text_value
        string.upcase
      end
    end

    module USomNode
      def normalise
        'usom'
      end
    end

    module UPathNode
      def normalise
        'upath'
      end
    end

    module UPasNode
      def normalise
        'upas'
      end
    end

    module UCwtNode
      def normalise
        'ucwt'
      end
    end

    module UCdNode
      def normalise
        'ucd'
      end
    end

    module UNcdNode
      def normalise
        'uncd'
      end
    end

    module UExtregNode
      def normalise
        'uextreg'
      end
    end
  end
end
