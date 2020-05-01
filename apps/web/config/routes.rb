# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'dashboard#index'

get '/:slug', to: 'organisations#show'
get '/:slug/services', to: 'organisations#show'
get '/:slug/quality-attributes', to: 'organisations#show'
get '/:slug/settings', to: 'organisations#show'
