require 'rails/generators/active_record'

module HasApiKey
  class MigrationGenerator < Rails::Generators::NamedBase
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    
    argument :name, :type => :string, :default => 'create_api_keys'
    # Create migration in project's folder
    def generate_files
      migration_template 'migration.rb', "db/migrate/#{name}.rb"
    end

    def self.next_migration_number(path)
      unless @prev_migration_nr
        @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      else
        @prev_migration_nr += 1
      end
      @prev_migration_nr.to_s
    end
  end
end
