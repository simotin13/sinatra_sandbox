# myapp.rb
require 'sinatra'
require "active_record"
require 'sinatra/reloader'
require 'memcache'
set :bind, '0.0.0.0'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: './sample.db'
)

# For Debug
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = 0
Time.zone_default = 'Tokyo'

# モデルファイルの読み込み
$LOAD_PATH.push('./models')
Dir.glob("./models/*.rb").each do |entry|
   filename = File.basename(entry)
   require filename
end

class MyApp < Sinatra::Base
  # コントローラファイルの読み込み
  Dir.glob("./controllers/**/*").each do |entry|
    if /\.rb/ =~ entry
      require entry
    end
  end

  ROUTES = {
    '/' => RootController
  }
  app_cached = MemCache.new('localhost:11211')
  @work = app_cached['W']
end
