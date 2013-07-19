
require_relative 'extract_charset_service/extract'
require 'rubygems'
require 'bundler/setup'

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

      def extract_from_json(data_string)
        begin
          JSON.parse data_string
        rescue
          nil
        end
      end

      def compute_result (data_hash)

        case
        when data_hash.nil?
          {:success => false, :message => "json malformed"}
        when ! data_hash.has_key?("text")
          {:success => false, :message => "json lacks a 'text' key"}
        else
          {:success => true, :report => ExtractCharset::extract(data_hash["text"])}
        end
      end

      def post
        # data is a hash where key is "text"
        # data = JSON.parse @request.body.read

        data = extract_from_json(@request.body.read)

        puts "pipo"
        puts data.nil?

        @result = compute_result(data)
        
        @headers['Content-Type'] = "application/json"
        @result.to_json(:root=>'response')
      end
    end
  end
end

