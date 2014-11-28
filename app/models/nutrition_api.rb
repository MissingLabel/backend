require 'net/http'
#incomplete
class NutritionApi

  def call_usda_api(ndb_no)
    url = URI.parse("http://api.data.gov/usda/ndb/reports/?ndbno=#{ndb_no}&type=f&format=xml&api_key=T7Or56nDBNq3C6VdIJC47Sz1qxprwdyByquFaV4A")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts res.body
  end

end
# "http://api.data.gov/usda/ndb/reports/?ndbno=09503&type=f&format=xml&api_key=T7Or56nDBNq3C6VdIJC47Sz1qxprwdyByquFaV4A"
test = NutritionApi.new

test.call_usda_api("09503")