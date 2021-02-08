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

nasa_api = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1", "sADGbmlSFHZbnl6FmA2skA94XsDrcigc1h3AqLSu")
picture_web = nasa_api["photos"].map do |i|
    i["img_src"] 
end

def build_page_nasa(info_hash) 
    File.open("index.html", "w") do |file| 
        file.puts"<html>\n<head>\n<title>API Nasa</title>\n</head>"
        file.puts"<body>\n<h1 align = 'center'>Photos Rovers Nasa</h1>\n<ul>"
        info_hash.each  do |photo|
            file.puts "<img src='#{photo}'width ='300' height = '200'>"    
        end
        file.puts"</ul>\n</body>\n</html>\n"  
    end
end

puts build_page_nasa(picture_web)

def photos_count(info_hash)
    counter = Hash.new(0)
    info_hash["photos"].each do |name_camera|
        name_camera["camera"].each do |k, v|
            if k == "name"
                puts v
            elsif counter.include? v
                counter[v] += 1
            else
                counter[v] = 1
            end
        end
    end
    #puts "Name of camera and number of photos#{counter}"
end
#photos_count(nasa_api)

 