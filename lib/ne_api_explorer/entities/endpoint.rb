class Endpoint < Hanami::Entity
  def self.all
    @endpoints ||= YAML.load_file("#{Hanami.root}/config/api.yml")["endpoints"]
  end

  def self.all_to_hash
    all.each_with_object({}){|(target, methods), obj|
      methods.map{|method, name| obj[name] = target + "_" + method}
    }
  end
end
