class Organisation < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :name, Types::String
    attribute :slug, Types::String

    attribute :token, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
