# frozen_string_literal: true

ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  
  # Create custom link with new active_admin
  collection_action :all_post, :method => :get


  menu parent: 'PortFolio'
  # menu label: 'User', parent: 'Appointments', priority: 1 ( is single line se bhi drop down ho jayega )
  

  # hide/remove the delete option from activeAdmin
  actions :all, :except => [:destroy]

  # controller do
  #   before_action only: :index do
  #     @per_page = 10
  #   end
  # end

  # index download_links: false
  # index download_links: [:pdf]
  # index download_links: proc{ current_user.can_view_download_links? }
  config.filters = false

  # form title: 'A custom title' do |f|
  #   inputs 'Details' do
  #     input :content
  #     input :created_at, label: "Publish Post At"
  #     li "Created at #{f.object.created_at}" unless f.object.new_record?
  #     input :attachment
  #   end
  #   panel 'Markup' do
  #     "The following can be used in the content below..."
  #   end
  #   inputs 'Content', :content
  #   para "Press cancel to return to the list without saving."
  #   actions
  # end



  config.sort_order = 'attachment_asc'
  # config.per_page = [10, 50, 100]
  permit_params :attachment, :content, :status, :count

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
    column "allllll" do |post|
      link_to "All Post", all_post_admin_posts_path(post)
    end
    column 'Attachment' do |img|
      "<a href='#{img.attachment}'><img src='#{img.attachment}' width='70'></a>".html_safe
    end
    actions
  end

  show  do
    render 'some_partial', locals: {post: post}
  end
end
