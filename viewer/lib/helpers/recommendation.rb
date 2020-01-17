class Recommendation
  attr_reader :text, :url, :post_url, :year, :month

  def initialize(text:, url:, post_url:, post_title:, year:, month:)
    @text = text
    @url = url
    @post_url = post_url
    @post_title = post_title
    @year = year
    @month = month
  end

  def category
    @category ||= begin
      if cat = base_category
        Category::normalize(cat)
      else
        "diversos"
      end
    end
  end

  def linted_text
    return text if category == "diversos"

    text.gsub(/#{base_category}/i, "").strip
  end

  private

  def base_category
    txt = text.downcase
    Category::CATEGORIES.find { |cat| txt.start_with?(cat) }
  end
end
