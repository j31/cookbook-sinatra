require 'nokogiri'
require 'open-uri'

class ScraperService

  def scraper(ingredient)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"
    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)
        # load titles into array
    titles = []
    html_doc.search(".m_titre_resultat").each do |item|
      titles << item.text.strip
    end

    # load short descriptions into array
    descs = []
    diffs = []
    html_doc.search(".m_detail_recette").each do |item|
      details = item.text.strip
      descs << details
      # extract and load difficulty level
      if details.downcase.include?("very easy")
        diffs << "Very Easy"
      elsif details.downcase.include?("easy")
        diffs << "Easy"
      elsif details.downcase.include?("moderate")
        diffs << "Moderate"
      else
        diffs << ""
      end
    end

    # load prep time into array
    prep_times = []
    html_doc.search(".m_detail_time").each do |item|
      string = item.text
      prep_times << string[/\d+/] + " min"
    end

    # create array of Recipe objects from scraped recipies
    scraped_recipies = []
    (0..titles.length - 1).each do |i|
      recipe = Recipe.new(titles[i], descs[i], prep_times[i], false, diffs[i])
      scraped_recipies << recipe
    end
    return scraped_recipies
  end
end
