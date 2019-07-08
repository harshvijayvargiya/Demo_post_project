# frozen_string_literal: true

class CreateSmsController < InheritedResources::Base
  def create
    @create_sms = CreateSm.new(create_sms_params)

    respond_to do |format|
      if @create_sms.save
        message = " '#{@create_sms.name}' was just added."
        TwilioTextMessenger.new(message).call
        format.html { redirect_to @create_sms, notice: 'successfully created.' }
        format.json { render :show, status: :created, location: @create_sms }
      else
        format.html { render :new }
        format.json { render json: @coffee_roast.errors, status: :unprocessable_entity }
      end
    end
end

  private

  def create_sm_params
    params.require(:create_sm).permit(:name, :description)
  end
end
