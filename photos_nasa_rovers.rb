require "uri"
require "net/http"
require "json"

def request (url, token = nil)
    url = URI("#{url}&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end

 nasa_hash = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1", "sADGbmlSFHZbnl6FmA2skA94XsDrcigc1h3AqLSu")
 puts nasa_hash["photos"].length


def build_web_page (info_hash)
    pictures = info_hash["photos"]
    pictures_url = photos.map{|i| i["img_src"]} 
    pictures_url.each do |photo|
        photo.puts "<img src=#{photo}>"
    end
end









