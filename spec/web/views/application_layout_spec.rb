# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::Views::ApplicationLayout, type: :view do
  let(:layout)   { described_class.new({ format: :html }, 'contents') }
  let(:rendered) { layout.render }

end
