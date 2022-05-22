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
      return 'file-text' if norm == 'textos'
      return 'monitor' if norm == 'site'
      'package'
    end


    def color_name(category)
      norm = Category::normalize(category)
      return 'var(--color4);' if norm == 'livro'
      return 'var(--color1);' if norm == 'filme'
      return 'var(--color2);' if norm == 'série'
      return 'var(--color3);' if norm == 'música'
      return 'var(--color6);' if norm == 'site'
      return 'var(--color5);' if norm == 'textos'
      'linear-gradient(0deg, rgba(131,58,180,1) 0%, rgba(253,29,29,1) 50%, rgba(252,176,69,1) 100%);'
    end
  end
end
