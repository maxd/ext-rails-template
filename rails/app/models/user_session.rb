class UserSession < Authlogic::Session::Base

  generalize_credentials_error_messages I18n.t("invalid_login_or_password")

end