# frozen_string_literal: true

port 2300

# please don't use forking. it will break logging and hanami-events
workers 0
worker_timeout 30 # in seconds
worker_boot_timeout 30

threads 0, 4

# just to prevert situations, when we have develop mode in production pods
environment 'production'

preload_app!
