# frozen_string_literal: true

class MsgsController < InheritedResources::Base
  def create
    @msg = Msg.new(msg_params)

    respond_to do |format|
      if @msg.save
        message = " '#{@msg.name}' was just added."
        TwilioTextMessenger.new(message).tempcall
        format.html { redirect_to @msg, notice: 'successfully created.' }
        format.json { render :show, status: :created, location: @msg }
      else
        format.html { render :new }
        format.json { render json: @msg.errors, status: :unprocessable_entity }
      end
    end
end

  private

  def msg_params
    params.require(:msg).permit(:name, :description)
  end
end
