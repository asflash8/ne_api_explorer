class Endpoint < Hanami::Entity
  def self.all
    @endpoints ||= YAML.load_file("#{Hanami.root}/config/api.yml")["endpoints"]
  end
end
