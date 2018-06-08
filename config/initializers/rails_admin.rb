RailsAdmin.config do |config|
  config.main_app_name = ["Buku Saku Admin", ""]
  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.model "User" do
    list do
      exclude_fields :id, :created_at
      fields :name do
        label "User name"
      end
    end
    fields :name do          # adding and configuring
      label "User name"
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete do
      except User
    end
    show_in_app
    
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
