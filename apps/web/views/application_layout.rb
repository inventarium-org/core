# frozen_string_literal: true

module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def dashboard_active_class
        ''
      end

      def services_active_class
        ''
      end

      def quality_attributes_active_class
        ''
      end

      def settings_active_class
        ''
      end
    end
  end
end
