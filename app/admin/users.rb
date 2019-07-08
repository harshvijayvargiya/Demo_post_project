# frozen_string_literal: true

ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    # h3 link_to "All Podcast: #{Podcast.all.count}", "#", style: "color:black; margin-left:43%;text-decoration: none !important;font-size: 25px;"

    selectable_column
    # id_column
    column :first_name
    column :last_name
    column :email
    column :role
    # column :date
    # column "Date" do |dat|
    #   "<p>#{dat.date.try(:strftime, "%m-%d-%Y" )}</p>".html_safe
    # end
    column 'Profile Picture' do |img|
      "<a href='#{img.profile_picture}'><img src='#{img.profile_picture}' width='70'></a>".html_safe
    end
  end
end
