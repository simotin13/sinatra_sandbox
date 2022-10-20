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

=begin
configure do
  set :app_cached, MemCache.new('localhost:11211')
end
=end
app_cached = MemCache.new('localhost:11211')
get '/' do
  @work = app_cached['W']
  if @work.nil?
    puts "nil!!!!"
    @work = Work.first
    # expire は秒単位
    app_cached.set('W', @work, 10)
  end
  "#{@work.store.name}"
end
