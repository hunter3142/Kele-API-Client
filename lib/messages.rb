module Messages
  def get_messages(page_number = nil)
    if page_number == nil
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token})
    else
      response = self.class.get("/message_threads?page=#{page_number}", headers: { "authorization" => @auth_token})
    end
    @message_threads = JSON.parse(response.body)
  end

  def create_message (sender, recipient_id, token, subject, stripped_text)
    response = self.class.post("/messages",
      body: {
        sender: sender,
        recipient_id: recipient_id,
        token: token,
        subject: subject, 
        stripped_text: stripped_text
      }, 
      headers: { "authorization" => @auth_token})
    @created_message = JSON.parse(response.body)

  end
end
