# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #index' do
    subject { get :index}

    context 'does not sign in' do
      it 'redirecto to sign in page' do
        is_expected.to redirect_to 
      end
    end
    
    context 'does sign in' do
      is_expected.to redirect_to  
    end
  end
end
