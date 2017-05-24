module Tnql #:nodoc: all
  module Nodes
    module BehaviourDetailNode
      def meta_data_item
        case text_value
        when 'noninvasive', 'non-invasive'
          { 'tumour.behaviour' => { Tnql::EQUALS => %w(0 1 2) } }
        when 'invasive'
          { 'tumour.behaviour' => { Tnql::EQUALS => %w(3 5) } }
        when 'metastatic'
          { 'tumour.behaviour' => { Tnql::EQUALS => '6' } }
        else
          { 'tumour.behaviour' => { Tnql::EQUALS => number.text_value } }
        end
      end
    end

    module SiteGroupNode
      SITE_GROUPS = {
        'brain'          => 1,
        'breast'         => 2,
        'endocrine'      => 3,
        'gynaecological' => 6,
        'haematological' => 7,
        'head and neck'  => 8,
        'lower gi'       => 4,
        'lung'           => 9,
        'other'          => 14,
        'sarcoma'        => 10,
        'skin'           => 11,
        'upper gi'       => 5,
        'urological'     => 12
      }.freeze unless defined?(SITE_GROUPS)

      def meta_data_item
        { 'tumour.site_group' => { Tnql::EQUALS => SITE_GROUPS[text_value] } }
      end
    end

    module MelanomaNode
      def meta_data_item
        { 'tumour.icd10o2_primarycode' => { Tnql::BEGINS => 'C43' } }
      end
    end

    module NonMelanomaNode
      def meta_data_item
        { 'tumour.icd10o2_primarycode' => { Tnql::BEGINS => 'C44' } }
      end
    end

    module SitesNode
      def meta_data_item
        sites_array = [first.to_site]
        rest.elements.map { |e| sites_array << e.to_site if !e.nil? && e.respond_to?(:to_site) }
        sites_array.flatten.delete_if { |a| a.nil? || a.empty? }

        { 'tumour.primarycode' => { Tnql::BEGINS => sites_array } }
      end
    end

    module AdditionalSiteNode
      def to_site
        site.to_site
      end
    end

    module SingleSiteNode
      def to_site
        text_value.upcase
      end
    end
  end
end
