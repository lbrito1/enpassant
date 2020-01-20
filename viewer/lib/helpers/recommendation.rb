class Recommendation
  attr_reader :text, :url, :post_url, :post_title, :year, :month

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
    return text if %(diversos textos sites).include?(category)

    text.gsub(/#{base_category}\s+/i, "").strip.capitalize
  end

  def title
    return linted_text unless author

    linted_text[/(.+),\sd[eoa]/i, 1].titleize
  end

  def author
    return unless %w(livro filme música).include?(category)

    linted_text[/,\sd[eoa]\s(.+)$/i, 1]&.titleize
  end

  # TODO move to presenter
  def icon_name
    norm = Category::normalize(category)
    return 'film' if norm == 'filme'
    return 'tv' if norm == 'série'
    return 'music' if norm == 'música'
    return 'book' if norm == 'livro'
    return 'file-text' if norm == 'text'
    'package'
  end

  private

  def base_category
    txt = text.downcase
    Category::CATEGORIES.find { |cat| txt.start_with?(cat) }
  end
end
