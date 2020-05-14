# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'dashboard#index'

# TODO: 'organisations' invalid name for organisation, I mean in model organisation name "organisation" is invalod.
#       I need to add validation for protected words for organisation names
resources :organisations, only: %i[new create]

namespace '/:slug' do
  get '/', to: 'organisations#show', as: :organisation_dashboard

  resources :services, only: %i[index show] do
    resources :readiness, only: %i[index], controller: 'service_readinesses'
    resources :audit, only: %i[index], controller: 'service_audit'
  end

  get '/quality-attributes', to: 'organisation_quality_attributes#index', as: :organisation_quality_attributes

  get '/settings', to: 'organisation_settings#index', as: :organisation_settings
  post '/settings/invites', to: 'organisation_invites#create', as: :organisation_invites

  get '/map', to: 'organisation_maps#index', as: :organisation_map
  get '/integrations', to: 'organisation_integrations#index', as: :organisation_integrations
end
