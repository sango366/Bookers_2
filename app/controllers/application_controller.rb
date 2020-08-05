class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_out_path_for(resource)
   flash[:logout] = 'Signed out successfully.'
 	 root_path
  end
  def after_sign_up_path_for(resource)
   flash[:signup] = 'Welcome! You have signed up successfully.'
 	 user_path(resource)
  end

  def after_sign_in_path_for(resource)
   flash[:login] = 'Signed in successfully.'
 	 user_path(resource)
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    #devise利用の機能（ユーザ登録、ログイン認証など）が使われる場合、その前にconfigure_permitted_parametersが実行されます。
    #今回のケースでは、ユーザ登録（sign_up）の際に、ユーザ名（name）のデータ操作が許可されます。
    #これは、CARAVAN作成時のStrong Parametersと同様の機能です。privateは、自分のコントローラ内でしか参照できません。一方、protectedは呼び出された他のコントローラからも参照できます。
  end
end
