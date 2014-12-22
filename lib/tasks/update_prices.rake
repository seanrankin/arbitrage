desc "Update product prices"
task :update_prices => :environment do
  require 'nokogiri'
  require 'open-uri'

  @products = Product.all
  @products.each do | product |
    url = "http://www.amazon.com/dp/#{product.pid}"
    doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0:", "From" => "test@test.com", "Referer" => "http://www.google.com"))

    sleep(1)

    price = doc.at_css(".a-size-medium.a-color-price").text[/[0-9\.]+/] if doc.at_css(".a-size-medium.a-color-price")
    price_new = doc.css("#olp_feature_div .a-section span span")[0].text[/[0-9\.]+/] if doc.css("#olp_feature_div .a-section span span")[0]
    price_used = doc.css("#olp_feature_div .a-section span span")[1].text[/[0-9\.]+/] if doc.css("#olp_feature_div .a-section span span")[1]

    unless price.blank?
      Price.create!(:product_id => product.id, :price => price, :price_new => price_new, :price_used => price_used)
    end

    puts "#{product.name} - Price: #{price}"
  end
end
