require "net/http"
require "uri"

module CourtListener
  class Request
    attr_accessor :path, :params
    attr_reader   :response

    def initialize(path, params = {})
      @path             = path
      @params           = params
      @params[:format]  ||= "json"
      send_request
    end


    private

    def send_request
      request = Net::HTTP::Get.new(create_uri)
      request.basic_auth(CourtListener.configuration.username, CourtListener.configuration.password)

      response = Net::HTTP.start(
        request.uri.hostname,
        request.uri.port,
        use_ssl: request.uri.scheme == 'https') { |http| http.request(request) }
      process_response(response)
    end

    def create_uri
      check_endpoint(self.path)
      uri       = URI(BASE_URL + self.path)
      uri.query = url_parameters
      uri
    end

    def url_parameters
      URI.encode_www_form(self.params) unless self.params.empty?
    end

    def process_response(response)
      valid_response = check_response_code(response)
      @response = CourtListener::Response.new(valid_response)
    end

    def follow_redirect(http_response)
      path = clean_redirect_path(http_response.header["location"])
      CourtListener::Request.new(path)
    end

    def check_endpoint(path)
      raise InvalidEndpoint unless CourtListener.endpoints.any? {|e| Regexp.new(e).match(path) }
    end

    def clean_redirect_path(uri_string)
      uri_string.split("/v1/").pop
    end

    def check_response_code(http_response)
      error = JSON.parse(http_response.body)["error"] || nil
      case http_response.code
        when "301"    then follow_redirect(http_response)
        when "400"    then raise BadRequestError, error
        when "401"    then raise AuthorizationError, error
        when "403"    then raise ForbiddenError, error
        when "404"    then raise InvalidPathError, error
        when "405"    then raise InvalidMethodError, error
        when /^50\d$/ then raise ConnectionError, error
        else http_response
      end
    end

  end
end
