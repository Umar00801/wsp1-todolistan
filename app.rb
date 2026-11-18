require 'debug'
require "awesome_print"

class App < Sinatra::Base
    register Sinatra::Reloader

    def db
      return @db if @db

      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    get '/' do 
        redirect('/todos')
    end

    get '/todos' do  
        @todos = db.execute ('SELECT * FROM todos ORDER BY completed') 
        ap @todos     
        erb(:'todos/index')
    end

end
