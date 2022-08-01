class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    build_resource({})
    5.times {resource.tags.build}
    respond_with resource
  end

  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up) { |user| user.permit(permitted_attributes) }
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: permitted_attributes)
  end

  def permitted_attributes
    [
      :email,
      :password,
      :password_confirmation,
      :remember_me,
      :role,
      :first_name, 
      :last_name, 
      :phone,
      :description, 
      :avatar,
      tags_attributes:  :body
    ]
  end
end
