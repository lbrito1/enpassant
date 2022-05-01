module Category
  CATEGORIES = %w(livro filme filmografia documentário série música playlist site texto coluna entrevista matéria diversos).freeze

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

    def normalized_categories
      CATEGORIES.map { |cat| normalize(cat) }.uniq
    end

    def icon_name(category)
      norm = Category::normalize(category)
      return 'film' if norm == 'filme'
      return 'tv' if norm == 'série'
      return 'music' if norm == 'música'
      return 'book' if norm == 'livro'
      return 'file-text' if norm == 'text'
      'package'
    end
  end
end
