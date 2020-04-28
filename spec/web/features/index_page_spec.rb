# frozen_string_literal: true

require 'features_helper'

RSpec.xdescribe 'GET /', type: :feature do
  let(:url) { '/' }

  before do
  end

  it 'returns a index page with all projects' do
    visit(url)

    expect(page.status_code).to eq 200
    expect(page.body).to include 'Project'
  end
end
