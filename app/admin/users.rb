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

  config.filters = true
  filter :role, as: :select, label: "Role"#, as: :select, collection: ->{ User.role }
  menu parent: 'PortFolio'
  # menu label: 'User', parent: 'Appointments', priority: 1 ( is single line se bhi drop down ho jayega )

  scope("admin") { |scope| scope.where('role = ?', 'admin') }
  scope("user") { |scope| scope.where('role = ?', 'user') }

  index do
    # h3 link_to "All Podcast: #{Podcast.all.count}", "#", style: "color:black; margin-left:43%;text-decoration: none !important;font-size: 25px;"

    selectable_column
    # id_column
    column :first_name
    column :last_name
    column :email
    column :role
    column :contact_number
    column "Price", sortable: :price do |product|
      number_to_currency product.price
    end
    # column :date
    # column "Date" do |dat|
    #   "<p>#{dat.date.try(:strftime, "%m-%d-%Y" )}</p>".html_safe
    # end
    column 'Profile Picture' do |img|
      "<a href='#{img.profile_picture}'><img src='#{img.profile_picture}' width='70'></a>".html_safe
    end
  end
end
