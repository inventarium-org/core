# frozen_string_literal: true

require 'dry-types'

# Module with all project types
#
# {http://dry-rb.org/gems/dry-types/ Dry-types documentation}
module Core
  module Types
    include Dry::Types.module

    # System types
    LoggerLevel = Symbol.constructor(proc { |value| value.to_s.downcase.to_sym })
                        .default(:info)
                        .enum(:trace, :unknown, :error, :fatal, :warn, :info, :debug)

    UUID = Strict::String.constrained(
      format: /\A(\h{32}|\h{8}-\h{4}-\h{4}-\h{4}-\h{12})\z/
    )

    # Accounts
    AuthIdentityProvider = String.constructor(proc { |value| value.to_s.downcase })
                                 .enum('login', 'github', 'google', 'gitlab')

    AccountOrganisationRole = String.constructor(proc { |value| value.to_s.downcase })
                                    .enum('owner', 'participator')

    # Organisations
    OrganisationPlans = String.constructor(proc { |value| value.to_s.downcase })
                              .enum('demo', 'free', 'pro', 'ent')

    # Services
    ServiceClassification = String.optional.constructor(proc { |value| value.nil? ? nil : value.to_s.downcase })
                                  .enum('critical', 'normal', 'internal', 'expiriment', nil)

    ServiceStatus = String.optional.constructor(proc { |value| value.nil? ? nil : value.to_s.downcase })
                          .enum('adopt', 'hold', 'trial', 'in_development', nil)
  end
end
