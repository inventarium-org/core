# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'dashboard#index'

namespace '/:slug' do
  get '/', to: 'organisations#show', as: :organisation_dashboard

  resources :services, only: [:index]

  get '/quality-attributes', to: 'organisations#show'
  get '/settings', to: 'organisations#show'
end
