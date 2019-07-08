# frozen_string_literal: true

ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :attachment, :content, :status, :count
  #
  # or
  #
  permit_params do
    permitted = %i[permitted attachment content status count]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    # h3 link_to "All Podcast: #{Podcast.all.count}", "#", style: "color:black; margin-left:43%;text-decoration: none !important;font-size: 25px;"

    selectable_column
    # id_column
    column :content
    column :user
    column :status
    column :count
    column :created_at
    # column :date
    # column "Date" do |dat|
    #   "<p>#{dat.date.try(:strftime, "%m-%d-%Y" )}</p>".html_safe
    # end
    column 'Attachment' do |img|
      "<a href='#{img.attachment}'><img src='#{img.attachment}' width='70'></a>".html_safe
    end
    actions
  end
end
