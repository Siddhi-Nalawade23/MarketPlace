require "net/http"
require "json"

class GenerateRandomProductsJob < ApplicationJob
  queue_as :default

  DUMMYJSON_URL = "https://dummyjson.com/products?limit=0"

  def perform(count = 1000)
    fallback_category_id = Category.first&.id
    seller_ids = User.where(role: "seller").pluck(:id)

    if fallback_category_id.nil? || seller_ids.empty?
      Rails.logger.error("Cannot generate products: no categories or sellers exist")
      return
    end

    templates = fetch_dummyjson_products

    if templates.empty?
      Rails.logger.error("Could not fetch electronics products from DummyJSON")
      return
    end

    now = Time.current

    products = Array.new(count) do
      template = templates.sample

      variant_suffix = [ "", " Pro", " Plus", " Max", " Lite", " 2.0", " Edition" ].sample
      name = "#{template["brand"] || template["category"].to_s.titleize} #{template["title"]}#{variant_suffix}".strip

      base_price = template["price"].to_f
      price = (base_price * rand(0.8..1.3)).round(2)

      {
        name: name,
        description: template["description"].to_s.truncate(300),
        price: price,
        stock: rand(0..150),
        category_id: fallback_category_id,
        user_id: seller_ids.sample,
        image_url: template["thumbnail"],
        created_at: now,
        updated_at: now
      }
    end

    Product.insert_all(products)
    Rails.logger.info("Generated #{count} electronics products from DummyJSON templates")
  end

  private

  def fetch_dummyjson_products
    uri = URI(DUMMYJSON_URL)
    response = Net::HTTP.get_response(uri)

    unless response.is_a?(Net::HTTPSuccess)
      Rails.logger.error("DummyJSON request failed: #{response.code}")
      return []
    end

    data = JSON.parse(response.body)

    electronics_categories = [
      "smartphones",
      "laptops",
      "tablets",
      "mobile-accessories"
    ]

    (data["products"] || []).select do |product|
      electronics_categories.include?(product["category"])
    end
  rescue => e
    Rails.logger.error("DummyJSON fetch error: #{e.message}")
    []
  end
end
