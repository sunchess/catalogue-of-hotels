require "forgery"
namespace :articles do
  namespace :place do
    desc 'add test articles to db'
    task :add => :environment do
      place = Place.where({:draft => false}).first
      10.times do |t|
        place.articles << Article.new(:title => Forgery::LoremIpsum.words, :body => Forgery::LoremIpsum.paragraphs)
      end
    end
  end
end
