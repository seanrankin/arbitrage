desc "Update product prices"
task :update_products => :environment do
  require 'nokogiri'
  require 'open-uri'

  @products = Product.where(:name => nil)
  # @products = Product.where(:active => true)
  @products.each do | product |
    url = "http://www.amazon.com/dp/#{product.pid}"
    doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0:", "From" => "test@test.com", "Referer" => "http://www.google.com"))

    # if product.name.blank?
      name = doc.at_css("#productTitle").text if doc.at_css("#productTitle")
    # else
      # name = product.name
    # end

    isbn = doc.css("#bylineBullets_feature_div .a-section span")[1].text if doc.css("#bylineBullets_feature_div .a-section span")[1]
    isbn10 = doc.css("#bylineBullets_feature_div .a-section span")[3].text if doc.css("#bylineBullets_feature_div .a-section span")[3]
    product.update_attributes!(:name => name, :isbn => isbn, :isbn10 => isbn10)

    puts product.name
    # puts price
  end
end
