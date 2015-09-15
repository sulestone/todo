class TodosController < ApplicationController
  before_action :signed_in_user #prevents any of the methods from being run before signed_in_user on the user_helper.rb is executed
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :do_complete, :do_uncomplete]

  def do_complete
    @todo.completed = true
    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end
# ​
  def do_uncomplete
    @todo.completed = false
    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /todos
  # GET /todos.json
  def index
    # @todos = Todo.all
    # @todos = Todo.order(created_at: :desc)
    @todos = current_user.todos.order(created_at: :desc)
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user       # associate the new todo to the current_user

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todos_path, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_path, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:title, :completed)
    end
end
