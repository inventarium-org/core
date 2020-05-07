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

      def link_to_repository(service)
        if service.repository_link
          raw "(#{link_to 'Repository', service.repository_link})"
        end
      end

      def owner_information(service)
        if service.owner_name && service.owner_slack_channel
          "Owner: #{service.owner_name} (##{service.owner_slack_channel})"
        elsif service.owner_name
          "Owner: #{service.owner_name}"
        elsif service.owner_slack_channel
          "Owner: ##{service.owner_slack_channel}"
        end
      end
    end
  end
end
