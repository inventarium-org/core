# frozen_string_literal: true

require 'yaml'

module Testing
  class ServiceYamlPayload
    def self.generate
      path = File.join(File.dirname(__FILE__), 'fixtures/billing_service_v0.yaml')
      YAML.load_file(path)
    end
  end
end
