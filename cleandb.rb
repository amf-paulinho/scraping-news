#!/usr/bin/env ruby

require 'pg'

def clean
		begin
			con = PG.connect :host => ENV['MY_POSTGRES_HOST'], :dbname => 'scraping_news_development', :user => ENV['MY_POSTGRES_USER'], :password => ENV['MY_POSTGRES_PASSWORD']

			con.exec 'delete from head_lines'

		rescue PG::Error => e
			puts e.message 
		ensure
			con.close if con
		end
end

clean