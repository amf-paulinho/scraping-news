#!/usr/bin/env ruby

require 'httparty'
require 'nokogiri'
require 'byebug'
require 'pg'
require 'date'

class HeadLine
	def title
		@title
	end

	def link
		@link
	end

	def content_id
		@content_id
	end

	def initialize (title, link, content_id)
		@title = title
		@link = link
		@content_id = content_id
	end
end

class ScraperEngine

	def initialize (scrappers)
		@scrappers = scrappers
	end

	def run
		puts "Starting Scrapping Engines..."
		puts ""
		@scrappers.each do |scrapper|
			scrapper.run
		end
		puts "Done!"
	end

end

class BaseScraper
	M_NOT_IMPL_MSG = "SYSTEM ERROR: method have to be implemented"
	P_NOT_IMPL_MSG = "SYSTEM ERROR: property have to be implemented"
	
	def site
		@site
	end

	def initialize (site)
		@site = site
	end

	def scrape
		raise M_NOT_IMPL_MSG
	end

	def run
		puts "Scraping:  #{@site}"
		data = self.scrape
		puts "Persisting:  #{@site}"
		self.persist(data)
		puts "#{data.count} Headlines found and persisted."
		puts ""

	end

	protected
	def persist(data)
		begin

			con = PG.connect :host => ENV['MY_POSTGRES_HOST'], :dbname => 'scraping_news_development', :user => ENV['MY_POSTGRES_USER'], :password => ENV['MY_POSTGRES_PASSWORD']

			con.transaction do |con|
				con.prepare('qry', 'INSERT INTO head_lines (scrape_date, source, content_id, title, link) VALUES($1, $2, $3, $4, $5) ON CONFLICT DO NOTHING')

				data.each do |item|
					con.exec_prepared('qry', [DateTime.now().strftime("%Y-%m-%d %T"), @site, item.content_id, item.title, item.link ])
				end
			end

		rescue PG::Error => e
			puts e.message 
		ensure
			con.close if con
		end
	end

	protected
	def getId(url) 
		if url.include? "?"
			url.split("?").last.split("=").last
		else
			id = url.split("-").last

			if id.include? "/" 
				id = id.split("/").last.nil? ? "0" : id.split("/").last
			else
				id
			end
		end
	end

	protected
	def getLink(domain, url) 
		if url.include? "https://" or url.include? "http://"
			url
		else
			domain + url
		end
	end

end

class AbcNews < BaseScraper
	def scrape
		rawData = HTTParty.get(@site)
		objData = Nokogiri::HTML(rawData.body)

		#Format 1
		headlines = objData.css('li.headlines-li')
		news_list = Array.new
		headlines.each do |headline|
			lnk = headline.css('a')[0].attributes["href"].value
			if lnk != 'javascript:void(0);'
				news_list << HeadLine.new(headline.text.strip, lnk, headline.attributes["data-id"].value)
			end
		end

		#Format 2
		headlines = objData.css('div.caption-wrapper')
		headlines.each do |headline|
			lnk = headline.css('h1').css('a')[0].attributes["href"].value
			if lnk != 'javascript:void(0);'
				news_list << HeadLine.new(headline.css('h1').text.strip.gsub("\n",""), lnk, getId(lnk))
			end
		end

		news_list
	end
end

class BBCNews < BaseScraper
	def scrape
		rawData = HTTParty.get(@site)
		objData = Nokogiri::HTML(rawData.body)

		headlines = objData.css('h3.media__title')
		news_list = Array.new
		headlines.each do |headline|
			news_list << HeadLine.new(headline.text.strip, getLink(@site, headline.css('a')[0].attributes["href"].value), getId(headline.css('a')[0].attributes["href"].value))
		end

		news_list
	end
end


engines = Array.new
engines << AbcNews.new("https://abcnews.go.com")
engines << BBCNews.new("https://www.bbc.com")

ScraperEngine.new(engines).run
