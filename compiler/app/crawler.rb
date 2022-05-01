require 'json'
require 'byebug'

require './compiler/app/fetcher'
require './compiler/lib/logger'

class Crawler
  include Logger

  CACHE_PATH = 'cache.json'

  def call
    start_year_month = cache['last_updated_year_month'].split('-') || year_months.first
    end_year_month = [Time.now.year.to_s, '%02i' % Time.now.month]

    start_idx = year_months.index { |year_month| year_month == start_year_month }
    end_idx = year_months.index { |year_month| year_month == end_year_month }

    collection = cache['data']
    year_months[start_idx..end_idx].each do |year, month|
      collection[year] ||= {}
      collection[year][month] ||= {}

      begin
        collection[year][month] = Fetcher.new(year, month).call
      rescue OpenURI::HTTPError => e
        log("HTTP Error #{e}")
      end
    end

    bytes = File.open(CACHE_PATH, "w") do |file|
      file.write({ last_updated_year_month: end_year_month.join('-'), data: collection }.to_json)
    end

    log("Done, wrote #{bytes} bytes.")
  rescue StandardError => e
    log("Something went wrong! #{e.inspect}")
  end

  private

  def cache
    @cache ||= begin
      file = File.read(CACHE_PATH)
      JSON.parse(file)
    end
  end

  def year_months
    @year_months ||= begin
      years = (2015..Date.today.year).map(&:to_s)
      months = (1..12).map { |month| '%02i' % month }
      years.map { |year| months.map { |month| [year, month] } }.flatten(1)
    end
  end
end
