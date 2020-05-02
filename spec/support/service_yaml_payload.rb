require 'yaml'

module Testing
  class ServiceYamlPayload
    def self.generate
      path = File.join(File.dirname(__FILE__), 'fixtures/billing_service.yaml')
      YAML.load_file(path)
    end
  end
end
