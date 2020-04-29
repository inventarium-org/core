# frozen_string_literal: true

Container.boot(:sidekiq) do |container|
  init do
    require 'sidekiq-scheduler'
    require 'sidekiq/job_logger'

    use :logger
    use :redis

    class TaggedJobLogger < Sidekiq::JobLogger
      def call(item, queue, &block)
        logger.tagged(context_tags(item)) do
          super(item, queue, &block)
        end
      end

      private

      def context_tags(item)
        {
          jid: item['jid'],
          args: item['args'],
          queue: item['queue'],
          class: item['class']
        }
      end
    end

    Sidekiq.configure_server do |config|
      config.redis = container['persistance.redis']

      config.logger = SemanticLogger['Inventarium::Sidekiq']
      config.options[:job_logger] = TaggedJobLogger
    end

    Sidekiq.configure_client do |config|
      config.redis = container['persistance.redis']

      config.logger = SemanticLogger['Inventarium::Sidekiq']
      config.options[:job_logger] = TaggedJobLogger
    end
  end
end
