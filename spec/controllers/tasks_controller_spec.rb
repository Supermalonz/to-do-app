# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #index' do
    subject { get :index}

    context 'does not sign in' do
      it is_expected_to redirect_to new_user_session_path
    end

    context 'does sign in' do
      it is_expected_to redirect_to tasks_path
    end
  end
end
