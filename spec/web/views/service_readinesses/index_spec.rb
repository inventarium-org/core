RSpec.describe Web::Views::ServiceReadinesses::Index, type: :view do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/service_readinesses/index.html.slim') }
  let(:view)      { described_class.new(template, **exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end
end
