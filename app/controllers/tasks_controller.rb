# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      flash[:error] = @task.errors.full_messages
      redirect_to new_task_path
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      flash[:error] = @task.errors.full_messages
      redirect_to edit_task_path
    end
  end

  def destroy
    @task.destroy

    redirect_to root_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :body, :status)
  end
end
