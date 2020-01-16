puts "Category"
module Category
  CATEGORIES = %w(livro filme filmografia documentário série música playlist site texto coluna entrevista matéria).freeze

  class << self
    def normalize(category)
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

    def url_safe(category)
      I18n.transliterate(normalize(category))
    end
  end
end