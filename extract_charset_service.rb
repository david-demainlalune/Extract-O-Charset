require 'camping'
require 'json'

Camping.goes :ExtractCharsetService


module ExtractCharsetService
  module ExtractCharsetService::Controllers

    class Home  < R '/'
      def get
        @headers["Content-Type"] = "text/html"
        File.read('public/index.html')
      end
    end 

    class APIExtractCharset < R '/api_extract'
      def post
        # data is a hash where key is "text"
        data = JSON.parse @request.body.read

        File.open("test.txt", 'w') do |file|
          file.write(data["text"])
        end

        @result = {:today => Date.today.to_s}
        
        @headers['Content-Type'] = "application/json"
        @result.to_json(:root=>'response')
      end
    end
  end
end

