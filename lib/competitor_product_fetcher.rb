require 'net/http'
require 'json'

class CompetitorProductFetcher
  API_URL = 'https://sinatra-pricing-api.fly.dev/prices'
  API_KEY = 'demo123'

  class << self
    def fetch_products
      uri = URI(API_URL)
      uri.query = URI.encode_www_form({ api_key: API_KEY })

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      begin
        request = Net::HTTP::Get.new(uri)
        response = http.request(request)
        response_code = response.code.to_i

        if response_code >= 200 && response_code < 300
          json_response = JSON.parse(response.body)
          json_response
        else
          Rails.logger.error "[ERROR] API request failed with status code #{response_code}"
          []
        end
      rescue Net::OpenTimeout, Net::ReadTimeout => e
        Rails.logger.error "[ERROR] API request timed out: #{e.message}"
        []
      rescue JSON::ParserError => e
        Rails.logger.error "[ERROR] Invalid JSON response: #{e.message}"
        []
      rescue => e
        Rails.logger.error "[ERROR] Unexpected error: #{e.message}"
        []
      end
    end
  end
end
