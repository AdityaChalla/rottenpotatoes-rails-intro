class Movie < ActiveRecord::Base
    attr_accessor :all_ratings
    def self.all_ratings
        ['G','PG','PG-13','R']
    end
end
