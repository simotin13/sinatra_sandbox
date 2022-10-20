require 'active_record'

class Work < ActiveRecord::Base
    belongs_to :store
end