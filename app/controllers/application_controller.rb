# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_invited_user!

  private

  def authenticate_invited_user!
    return if user_signed_in? || invitation_pending? || devise_controller?

    redirect_to new_user_session_path
  end

  def invitation_pending?
    return false unless params[:invitation_token].present?

    user = User.find_by_invitation_token(params[:invitation_token], true)
    user.present? && !user.accepted_invitation?
  end
end
