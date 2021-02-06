require "uri"
require "net/http"
require "json"

def request (url, token = nil)
    url = URI("#{url}&api_key=#{token}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    return JSON.parse(response.read_body)
end


def buid_web_page(photo_hash) 

   File.open('index.html', 'w') do |file|
    puts photo_hash["photos"].to_s
    file.puts "<img src='#{photo_hash["photos"][0]['img_src']}'>"
   end
 end   

nasa_hash = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1", "sADGbmlSFHZbnl6FmA2skA94XsDrcigc1h3AqLSu")

puts buid_web_page(nasa_hash)







