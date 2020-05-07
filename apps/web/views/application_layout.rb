# frozen_string_literal: true

module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def breadcrumb; end

      def organisations_active_class; end

      def new_organisation_active_class; end

      def dashboard_active_class; end

      def services_active_class; end

      def quality_attributes_active_class; end

      def integratins_active_class; end

      def settings_active_class; end

      def tags_html(tags)
        html.div do
          tags.map { |tag| span(tag, class: 'badge badge-primary') }
        end
      end
    end
  end
end
