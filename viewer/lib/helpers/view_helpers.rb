def posts
  @posts ||= begin
    file = File.read('../cache.json')
    posts = JSON.parse(file)['data'] || []
    # @posts_by_category = Hash.new { |h, k| h[k] = [] }

    posts.each do |_year, posts_by_year|
      posts_by_year.each do |month, posts_by_month|
        posts_by_month.reject! { |post| post['recommendations'].empty? }
      end
      posts_by_year.reject! { |month, posts_by_month| posts_by_month.empty? }
    end

    posts
  end
end

def posts_by_year
  posts.keys.sort.reverse
end

def recommendations_by_category
  @recommendations_by_category ||= recommendations.group_by(&:category)
end

def recommendations_by_year
  @recommendations_by_year ||= recommendations.group_by(&:year)
end

def recommendations_by_month(year)
  recommendations_by_year[year.to_s].sort_by(&:month).reverse.group_by(&:month)
end

def categories
  Category::normalized_categories
end

def recommendations
  @recommendations ||= begin
    list = []
    posts.each do |year, posts_by_year|
      posts_by_year.each do |month, posts_by_month|
        posts_by_month.each do |post|
          post['recommendations'].each do |rec|
            list << Recommendation.new(
              text: rec["text"],
              url: rec["url"],
              post_url: post["url"],
              post_title: post["title"],
              year: year,
              month: month)
          end
        end
      end
    end

    list
  end
end

def month_label(month_integer)
  %w(Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)[month_integer - 1]
end

def current_year
  Time.now.year
end
