# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/login', to: 'signin#index', as: 'login'
get '/:provider', to: 'oauth#show'
