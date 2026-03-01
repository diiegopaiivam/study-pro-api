class RemoveWwwAuthenticateHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers.delete("www-authenticate")
    headers.delete("WWW-Authenticate")
    [status, headers, body]
  end
end

Rails.application.config.middleware.use RemoveWwwAuthenticateHeader