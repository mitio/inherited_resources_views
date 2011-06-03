module InheritedResourcesViews
  module ActionView
    extend ActiveSupport::Concern

    included do
      def self.process_view_paths(value)
        PathSet.new(Array.wrap(value))
      end
    end

    class PathSet < ::ActionView::PathSet
      def find(path, prefix = nil, partial = false, details = {}, key = nil)
        super
      rescue ::ActionView::MissingTemplate
        prefix.to_s.sub!(/[\w]+$/, "inherited_resources")
        super
      end
      
      def find_template(original_template_path, format = nil, html_fallback = true)
        super
      rescue ::ActionView::MissingTemplate
        original_template_path.sub!(/^[\w]+/, "inherited_resources")
        super
      end
    end
  end
end

ActionView::Base.send :include, InheritedResourcesViews::ActionView
