class Recommendation
  attr_reader :text, :url, :post_url

  def initialize(text:, url:, post_url:)
    @text = text
    @url = url
    @post_url = post_url
  end

  def category
    @category ||= begin
      txt = text.downcase
      if cat = Category::CATEGORIES.find { |cat| txt.start_with?(cat) }
        normalized_category(cat)
      else
        "diversos"
      end
    end
  end
end
