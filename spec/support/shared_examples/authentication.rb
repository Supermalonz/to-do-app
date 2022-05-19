# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'authentication' do
  context 'does not sign in' do
    it { is_expected.to redirect_to new_user_session_path }
  end
end
