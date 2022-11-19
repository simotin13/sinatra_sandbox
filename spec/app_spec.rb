# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'

require './myapp.rb'
require 'rspec'
require 'rack/test'

describe "MyApp のテスト" do
  include Rack::Test::Methods

  def app
    RootController
  end

  it "return Hello" do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to eq 'Hello'
  end
end

