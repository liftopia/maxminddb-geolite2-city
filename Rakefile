require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'digest/md5'
require 'highline'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Update to the newest MaxMindDB (geolite city)'
task :update_db do
  cli = HighLine.new
  if is_same_db?
    cli.say "The current DB is already up-to-date."
    next
  end

  db_filepath = download_db
  unless db_checksum_valid?(db_filepath)
    cli.say "ERROR: md5 checksum failed. Please try again"
    return
  end

  move_db_to_lib
  run_tests!

  new_version = bump_version
  update_changelog(new_version)

  can_commit_and_push = cli.agree "Do you want to commit and push (y/n)?"
  next unless can_commit_and_push

  commit_and_push(new_version)

  can_release_to_rubygems = cli.agree "Do you want to release the gem (rubygems.org) (y/n)?"
  next unless can_release_to_rubygems

  release_to_rubygems
end

def is_same_db?
  checksum = `md5sum -b ./lib/maxminddb/geolite2/db/GeoLite2-City.mmdb`.split(' ')[0]
  fetch_db_md5_checksum == checksum
end

def fetch_db_md5_checksum
  @db_md5_checksum ||= `curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.md5`
end

def download_db
  `wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz -O GeoLite2-City.mmdb.gz`
  `gunzip -f GeoLite2-City.mmdb.gz`

  './GeoLite2-City.mmdb'
end

def db_checksum_valid?(db_path)
  checksum = `md5sum -b #{db_path}`.split(' ')[0]
  fetch_db_md5_checksum == checksum
end

def move_db_to_lib
  `mv GeoLite2-City.mmdb ./lib/maxminddb/geolite2/db/`
end

def run_tests!
  # this will trigger a SystemExit error if the tests fail
  Rake::Task['spec'].invoke
end

def bump_version
  current_version = MaxMindDB::Geolite2::City::VERSION
  minor_version = current_version.split('.')[1].to_i
  generate_new_version(minor_version + 1)
end

def generate_new_version(minor_version)
  new_version = "1.#{minor_version}.0"

  content = <<VERSION_CONTENT
module MaxMindDB
  module Geolite2
    module City
      VERSION = "#{new_version}"
    end
  end
end
VERSION_CONTENT

  File.write('./lib/maxminddb/geolite2/city/version.rb', content)
  new_version
end

def update_changelog(new_version)
  update_content = <<NEW_UPDATE
 Release #{new_version}
- Bundled the #{Date.today.strftime("%B %Y")} geolite2-city db

NEW_UPDATE

  changelog_content = File.read('CHANGELOG.md')
  # Split on updates
  updates = changelog_content.split('####')
  # the first element is the changelog's title/basic info,
  # so insert after that
  updates.insert(1, update_content)

  File.write('CHANGELOG.md', updates.join('####'))
end

def commit_and_push(version)
  date_str = Date.today.strftime("%B %Y")
  `git commit -a -m 'Update DB to #{date_str}. Bumped to #{version}.'`
  `git push`
end

def release_to_rubygems
  # We need to reload the VERSION constant before releasing
  # Rake::Task['release'].invoke
  `bundle exec rake release` # tmp fix
end
