class Recommendation
  CATEGORIES = %w(livro filme filmografia documentário série música playlist site texto coluna entrevista matéria).freeze

  attr_reader :text, :url, :post_url

  def initialize(text:, url:, post_url:)
    @text = text
    @url = url
    @post_url = post_url
  end

  def category
    @category ||= begin
      normalized_text = text.downcase
      rec_cat = CATEGORIES.find { |cat| normalized_text.start_with?(cat) }

      if rec_cat
        normalized_category(rec_cat)
      else
        "diversos"
      end
    end
  end

  def normalized_category(category)
    if %w(documentário filme filmografia).include?(category)
      'filme'
    elsif %w(música playlist).include?(category)
      'música'
    elsif %w(texto coluna entrevista matéria).include?(category)
      'textos'
    else
      category
    end
  end
end
