# frozen_string_literal: true

module Organisations
  module Libs
    class TokenGenerator
      include Import[
        repo: 'repositories.organisation'
      ]

      def call
        token = SecureRandom.alphanumeric

        until repo.find_by_token(token).nil?
          token = SecureRandom.alphanumeric
        end

        token
      end
    end
  end
end
