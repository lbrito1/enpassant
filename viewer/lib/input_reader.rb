require 'json'

def posts
  @posts ||= begin
    file = File.read('../cache.json')
    posts = JSON.parse(file)['data'] || []

    posts.each do |_year, posts_by_year|
      posts_by_year.each do |month, posts_by_month|
        posts_by_month.reject! { |post| post['recommendations'].empty? }
      end
      posts_by_year.reject! { |month, posts_by_month| posts_by_month.empty? }
    end

    posts
  end
end

def years_ordered
  posts.keys.sort.reverse
end

def month_label(month_integer)
  %w(Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)[month_integer - 1]
end

def current_year
  Time.now.year
end
