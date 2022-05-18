# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:user) { create(:user) }
  let!(:task1) { create(:task, user: user, title: 'TestTask') }
  let!(:task2) { create(:task, user: user) }

  describe 'GET #index' do
    subject { get :index }

    include_examples 'authentication'

    context 'does sign in' do
      before { sign_in user }
      it { is_expected.to have_http_status(:ok) }

      it 'returns matching tasks' do
        subject
        expect(assigns(:tasks)).to match_array [task1, task2]
      end
    end
  end

  describe 'GET #show' do
    subject { get :show, params: params }

    let(:params){
      {
        id: task1.id
      }
    }

    include_examples 'authentication'
    context 'does sign in' do
      before { sign_in user }
      it { is_expected.to have_http_status(:ok) }

      it 'returns task' do
        subject
        expect(assigns(:task)).to eq task1
      end

      it 'returns error' do
        params[:id] = 'invalid_id'
        # subject
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #new' do
    subject { post :new }
  end
end
