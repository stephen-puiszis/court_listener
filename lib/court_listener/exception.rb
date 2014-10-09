module CourtListener
  class Error               < StandardError; end
  class BadRequestError     < Error; end
  class InvalidPathError    < Error; end
  class AuthorizationError  < Error; end
  class ForbiddenError      < Error; end
  class ConnectionError     < Error; end
  class FormatError         < Error; end
  class InvalidEndpoint     < Error; end
end
