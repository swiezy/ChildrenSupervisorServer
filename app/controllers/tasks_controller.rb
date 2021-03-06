class TasksController < ApplicationController
  before_action :find_child, only: [:index, :new, :create]
  before_action :find_task, only: [:show, :edit, :update]

  def index
    @tasks = @child.tasks
    respond_to do |format|
      format.json { render json: @tasks }
    end
  end

  def after_date
    date = Time.parse(params[:date]) if params[:date]
    date ||= Time.current
    @tasks = Task.after_date(date)
    respond_to do |format|
      format.json { render json: @tasks }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @task }
      format.html # show.html.erb
    end
  end

  def new
    @task = @child.tasks.build
  end

  def create
    @task = @child.tasks.build(task_params)
    @task.status = false

    if @task.save
      flash[:success] = "Your task has been added!"
      redirect_to parent_child_path(@child.parent, @child)
    else
      flash.now[:alert] = "Your task couldn't be added! Please check the form"
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task
    end
  end

  private

  def find_child
    @child = Child.find(params[:child_id])
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:summary, :description, :mark)
  end
end
