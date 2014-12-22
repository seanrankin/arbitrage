desc "Update product prices"
task :update_prices => :environment do
  require 'nokogiri'
  require 'open-uri'

  @products = Product.all
  @products.each do | product |
    url = "http://www.amazon.com/dp/#{product.pid}"
    doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0:", "From" => "test@test.com", "Referer" => "http://www.google.com"))
    price = doc.at_css(".a-size-medium.a-color-price").text[/[0-9\.]+/] if doc.at_css(".a-size-medium.a-color-price")
    Price.create!(:product_id => product.id, :price => price)
    puts product.name
    #puts price
  end
end
