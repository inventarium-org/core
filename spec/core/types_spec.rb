# frozen_string_literal: true

RSpec.describe Core::Types do
  describe 'LoggerLevel' do
    let(:type) { Core::Types::LoggerLevel }

    [
      [nil, :info],

      %i[trace trace],
      %i[unknown unknown],
      %i[error error],
      %i[fatal fatal],
      %i[warn warn],
      %i[info info],
      %i[debug debug],

      ['trace', :trace],
      ['unknown', :unknown],
      ['error', :error],
      ['fatal', :fatal],
      ['warn', :warn],
      ['info', :info],
      ['debug', :debug]
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['other'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:other] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'UUID' do
    let(:type) { Core::Types::UUID }
    let(:uuid) { SecureRandom.uuid }

    it { expect(type[uuid]).to eq(uuid) }
    it { expect { type['anything'] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'AuthIdentityProvider' do
    let(:type) { Core::Types::AuthIdentityProvider }

    [
      [:github, 'github'],
      %w[github github],

      [:google, 'google'],
      %w[google google],

      [:gitlab, 'gitlab'],
      %w[gitlab gitlab],

      [:login, 'login'],
      %w[login login]
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['invalid'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:invalid] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'AccountOrganisationRole' do
    let(:type) { Core::Types::AccountOrganisationRole }

    [
      [:owner, 'owner'],
      %w[owner owner],

      [:participator, 'participator'],
      %w[participator participator],

    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['invalid'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:invalid] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'ServiceClassification' do
    let(:type) { Core::Types::ServiceClassification }

    [
      [:critical, 'critical'],
      %w[critical critical],

      [:normal, 'normal'],
      %w[normal normal],

      [:internal, 'internal'],
      %w[internal internal],

      [:expiriment, 'expiriment'],
      %w[expiriment expiriment],

    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['invalid'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:invalid] }.to raise_error(Dry::Types::ConstraintError) }
  end

  describe 'ServiceStatus' do
    let(:type) { Core::Types::ServiceStatus }

    [
      [:adopt, 'adopt'],
      %w[adopt adopt],

      [:hold, 'hold'],
      %w[hold hold],

      [:trial, 'trial'],
      %w[trial trial],

      [:in_development, 'in_development'],
      %w[in_development in_development],
    ].each do |value, result|
      it { expect(type[value]).to eq(result) }
    end

    it { expect { type['invalid'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { type[:invalid] }.to raise_error(Dry::Types::ConstraintError) }
  end
end
