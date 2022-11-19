require './myapp'
run Rack::URLMap.new(App::ROUTES)
