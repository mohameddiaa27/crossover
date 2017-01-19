class FakeRequest
  attr_accessor :remote_ip, :user_agent, :headers

  def initialize(remote_ip: '23.12.54.111', user_agent: 'Safari', headers: {})
    self.remote_ip = remote_ip
    self.user_agent = user_agent
    self.headers = headers
  end
end
