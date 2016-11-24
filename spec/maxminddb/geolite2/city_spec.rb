require "spec_helper"

describe MaxMindDB::Geolite2::City do
  it "has a version number" do
    expect(MaxMindDB::Geolite2::City::VERSION).not_to be nil
  end

  let (:default_db) { MaxMindDB.default_city_db }

  it "creates a client based on the default db" do
    expect(default_db.class).to eq(MaxMindDB::Client)
  end

  it "supports city lookup" do
    expect(default_db.lookup('8.8.8.8').city.name).to eq("Mountain View")
  end
end
