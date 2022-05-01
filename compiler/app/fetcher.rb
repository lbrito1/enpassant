require 'nokogiri'
require 'open-uri'

require 'byebug'
require 'awesome_print'

require './compiler/lib/logger'

class Fetcher
  include Logger

  BASE_URL = 'https://xadrezverbal.com'
  THROTTLE_MS = 100

  def initialize(year, month)
    @year = year
    @month = month
    log("Created fetcher for #{year}-#{month}")
  end

  def call
    page = get("#{BASE_URL}/#{@year}/#{@month}")

    posts = page.css('h2.post-title')

    log("Found #{posts.count} posts.")

    posts = posts.map do |post|
      [post.text, post.css('a').first['href']]
    end

    posts.map! do |title, url|
      page = get(url).css('div.entry.clearfix')
      header = [
        page.at('p:contains("Sétimo Selo")'),
        page.at('p:contains("sétimo selo")'),
        page.at('p:contains("Sétimo selo")'),
        page.at('h4:contains("Sétimo Selo")'),
        page.at('h4:contains("sétimo selo")'),
        page.at('h4:contains("Sétimo selo")')
      ].compact.first

      recommendations = []
      candidate = header&.next_element
      while (candidate && candidate.name == 'p')
        if candidate.css('a').any?
          recommendations << {
            text: candidate.content,
            url: candidate.css('a').first['href']
          }
        end

        candidate = candidate.next_element
      end

      {
        title: title,
        url: url,
        recommendations: recommendations
      }
    end
  end

  private

  def get(url)
    sleep(THROTTLE_MS / 1_000.0)
    Nokogiri::HTML(URI.open(url))
  end
end

