# frozen_string_literal: true

class ServiceRepository < Hanami::Repository
  associations do
    has_many :environments

    belongs_to :organisation
  end
end
