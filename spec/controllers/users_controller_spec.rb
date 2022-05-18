# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  describe 'Get #show' do
    let(:user2) { create(:user) }
    subject { get :show, params: { id: user.id } }
  end
end
