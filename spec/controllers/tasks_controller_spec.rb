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
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'Get #new' do
    subject { get :new }
    include_examples 'authentication'

    context 'does sign in' do
      before { sign_in user }
      it { is_expected.to have_http_status(:ok) }

      it 'returns status' do
        subject
        expect(assigns(:task).status).to eq nil
      end
  end
end

  describe 'POST #create' do
    subject { post :create, params: params }
    let(:params){
      {
        task: {
          title: task1.title,
          body: task1.body,
          status: task1.status
        }
      }
    }
    include_examples 'authentication'

    context 'does sign in' do
      before { sign_in user }
      it { is_expected.to have_http_status(:found) }

      it 'creates task' do
        expect{ subject }.to change(Task, :count).by(1)
        expect(response).to redirect_to(tasks_path)
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: params }
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
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
  end
end

  describe 'PATCH #update' do
    subject { patch :update, params: params }
    let(:params){
      {
        id: task1.id,
        task: {
          title: 'edited_title',
          body: 'edited_body',
          status: :done
        }
      }
    }
    include_examples 'authentication'

    context 'does sign in' do
      before { sign_in user }
      it { is_expected.to have_http_status(:found) }

      it 'update task page' do
        subject
        expect(response).to redirect_to(tasks_path)
      end

      it 'update invalid body' do
        params[:task][:body] = 'shortbody'
        subject
        expect(response).to redirect_to(edit_task_path(params[:id]))
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params }
    let(:params){
      {
        id: task1.id,
        task: {
          title: 'edited_title',
          body: 'edited_body',
          status: :done
        }
      }
    }
    include_examples 'authentication'

    context 'does sign in' do
      before { sign_in user }
      it { is_expected.to have_http_status(:found) }

      it 'destroy task' do
        expect{ subject }.to change(Task, :count).by(-1)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
