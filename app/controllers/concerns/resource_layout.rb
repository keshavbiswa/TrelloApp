module ResourceLayout
  extend ActiveSupport::Concern

  included do 
    layout :layout_by_resource
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end