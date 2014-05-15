require 'active_record'
require 'yaml'

module DB
  def self.connect(root_dir, rackenv)
    databese_yml_path = File.join(root_dir, 'config', 'database.yaml')
    database_yml      = YAML.load_file(database_yml_path)
    connection_data   = database_yml[rack_env]

    if connection_data[:adapter] == 'sqlite3'
      connection_data[:database] = File.join(root_dir, connection_data[:database])
    end
    
    ActiveRecord::Base.establish_connection(connection_data)
  end

  def self.close
    ActiveRecord::Base.connection.close
  end
end
