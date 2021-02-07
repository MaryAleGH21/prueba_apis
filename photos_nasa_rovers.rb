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

nasa_hash = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1", "sADGbmlSFHZbnl6FmA2skA94XsDrcigc1h3AqLSu")
photo_url = nasa_hash["photos"].map do |i|
    i["img_src"] 
end

def build_page_nasa(info_hash) 
    File.open("index.html", "w") do |file|  
        info_hash.each  do |photo|
            file.puts "<img src='#{photo}' width ='500'>"    
        end
    end
end

puts build_page_nasa(nasa_hash)






