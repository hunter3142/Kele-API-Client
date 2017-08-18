require 'httparty'

class Kele
	include HTTParty

	base_uri 'https://www.bloc.io/api/v1'

	def initialize (u, p)
		@auth_token = get_auth_token(u, p)
	end

	private
	def get_auth_token(u, p)
		response = self.class.post("/sessions", body: {email: u, password: p})
		raise StandardError if response.code != 200
		response["auth_token"]
	end
end