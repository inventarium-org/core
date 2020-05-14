# frozen_string_literal: true

class CommunicationsRepository < Hanami::Repository
  associations do
    belongs_to :service
  end
end
