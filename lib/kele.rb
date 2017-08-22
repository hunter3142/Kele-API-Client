require 'httparty'
require 'json'
require './lib/roadmap.rb'
require './lib/messages.rb'

class Kele
	include HTTParty
  include Roadmap
  include Messages

	base_uri 'https://www.bloc.io/api/v1'

	def initialize (e, p)
		@auth_token = get_auth_token(e, p)
	end

	def get_me
		response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
		@user_data = JSON.parse(response.body)
	end

  def get_mentor_availability (mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @mentor_availabilty = JSON.parse(response.body)
  end

  def create_submission (assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    response = self.class.post("/checkpoint_submissions", 
      body: {
        assignment_branch: assignment_branch,
        assignment_commit_link: assignment_commit_link,
        checkpoint_id: checkpoint_id,
        comment: comment,
        enrollment_id: enrollment_id
      },
      headers: { "authorization" => @auth_token })
    puts response
  end

  private
	def get_auth_token(e, p)
		response = self.class.post("/sessions", body: {email: e, password: p})
		raise StandardError if response.code != 200
		response["auth_token"]
	end
end