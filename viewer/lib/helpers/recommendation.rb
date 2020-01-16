class Recommendation
  attr_reader :text, :url, :post_url

  def initialize(text:, url:, post_url:)
    @text = text
    @url = url
    @post_url = post_url
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
