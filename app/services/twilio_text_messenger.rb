# frozen_string_literal: true

require 'twilio-ruby'

class TwilioTextMessenger
  attr_reader :message

  def initialize(message, fname)
    # binding.pry
    @message = message
    @fname = fname
end

  # For send welcome text message after signup

  def call
    account_sid = 'ACf4a7038ad0d604094a2978de92d1ba1a'
    auth_token = 'eba8c9df9907b30db4806eac272b0eee'
    client = Twilio::REST::Client.new(account_sid, auth_token)
    # client = Twilio::REST::Client.new
    client.messages.create(
      from: '+12056273269',
      to: "+91#{@message}",
      body: "Dear #{@fname} your verification code is #{SecureRandom.hex(3)} you have sucessfully registered with our team Welcome and enjoy with us!!"
    )
  end

  # For call after signup

  # def call
  # account_sid = 'ACf4a7038ad0d604094a2978de92d1ba1a'
  # auth_token = 'eba8c9df9907b30db4806eac272b0eee'
  # @client = Twilio::REST::Client.new(account_sid, auth_token)
  #   # client = Twilio::REST::Client.new
  #   call = @client.calls.create({
  #     from: "+12056273269",
  #     to: "+91#{@message}",
  #     url: "http://demo.twilio.com/docs/voice.xml"

  #   })

  # end

  def tempcall
    account_sid = 'ACf4a7038ad0d604094a2978de92d1ba1a'
    auth_token = 'eba8c9df9907b30db4806eac272b0eee'
    client = Twilio::REST::Client.new(account_sid, auth_token)
    # client = Twilio::REST::Client.new
    client.messages.create(
      from: '+12056273269',
      to: '+918878342452',
      body: 'Welcome'
    )
  end
  end
