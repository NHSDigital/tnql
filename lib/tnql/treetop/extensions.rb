module Treetop
  module Runtime
    # We extend the SyntaxNode class to include a hash of meta data.
    # Individual rules can define meta_data_item method that must return
    # a hash that is merged with the hash data for the entire query.
    class SyntaxNode
      def meta_data(hash = {})
        hash.merge!(meta_data_item) if respond_to?(:meta_data_item)

        if nonterminal?
          elements.each do |element|
            element.meta_data(hash)
          end
        end

        hash
      end
    end
  end
end
