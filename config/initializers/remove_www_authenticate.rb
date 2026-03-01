Rails.application.config.middleware.insert_before Warden::Manager, Class.new {
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers.delete("WWW-Authenticate")
    headers.delete("www-authenticate")
    [status, headers, body]
  end
}