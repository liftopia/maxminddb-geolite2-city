require 'maxminddb/geolite2/city/version'
require 'maxminddb'

module MaxMindDB
  def MaxMindDB.default_city_db
    return @default_city_db if @default_city_db

    default_db_path = File.join(File.dirname(__FILE__), 'db', 'GeoLite2-City.mmdb')
    @default_city_db = MaxMindDB.new(default_db_path)
  end
end
