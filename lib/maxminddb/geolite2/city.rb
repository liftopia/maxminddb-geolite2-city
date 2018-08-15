require 'maxminddb/geolite2/city/version'
require 'maxminddb'

module MaxMindDB
  def MaxMindDB.default_city_db(file_reader = nil)
    return @default_city_db if @default_city_db

    default_db_path = File.join(File.dirname(__FILE__), 'db', 'GeoLite2-City.mmdb')
    @default_city_db = (file_reader == nil ? MaxMindDB.new(default_db_path) : MaxMindDB.new(default_db_path, file_reader))
  end
end
