desc "Update product prices"
task :update_products => :environment do
  require 'nokogiri'
  require 'open-uri'

  @products = Product.where(:name => nil)
  @products.each do | product |
    url = "http://www.amazon.com/dp/#{product.pid}"
    doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0:", "From" => "test@test.com", "Referer" => "http://www.google.com"))
    name = doc.at_css("#productTitle").text if doc.at_css("#productTitle")
    product.update_attributes!(:name => name)
    puts product.name
    #puts price
  end
end
