require "./avram"

module Avram
  class Database::DatabaseCleaner
    def truncate
      return if table_names.empty?

      # Removed `RESTART IDENTITY`
      # See https://github.com/cockroachdb/cockroach/issues/38931
      statement = "TRUNCATE TABLE #{table_names.join(", ")} CASCADE;"
      database.exec(statement)
    end
  end

  class Migrator::Runner
    def self.create_db(quiet? : Bool = false)
      DB.connect("#{credentials.connection_string}/#{db_user}") do |db|
        db.exec "CREATE DATABASE #{db_name}" # Removed `WITH OWNER DEFAULT`
      end
      unless quiet?
        puts "Done creating #{db_name.colorize(:green)}"
      end
    rescue e : DB::ConnectionRefused
      message = e.message.to_s
      if message.blank?
        raise ConnectionError.new(URI.parse(credentials.url_without_query_params), Avram.settings.database_to_migrate)
      else
        raise e
      end
    rescue e : Exception
      message = e.message.to_s
      if message.includes?(%("#{self.db_name}" already exists))
        unless quiet?
          puts "Already created #{self.db_name.colorize(:green)}"
        end
      elsif message.includes?("Cannot establish connection")
        raise PGNotRunningError.new(message)
      else
        raise e
      end
    end
  end
end
