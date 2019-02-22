class Admin::GroupsController < ApplicationController
  layout :admin_layout_template

  # List all groups
  def index
    @groups = Group.all
    @departments = Department.all
    @group_form_url = admin_groups_path
  end

  # init new group
  def new
    # initialize formdata
    @groups = Group.all
    @group = Group.new
    @departments = Department.all
    @group_form_url = admin_groups_path
  end

  # create new group
  def create
    # initialize formdata
    @groups = Group.all
    @group = Group.new(group_params)
    @group_form_url = admin_groups_path
    @departments = Department.all

    # if save record success
    if @group.save
      flash[:success] = "Group #{@group.name} had been created successfully."
      redirect_to admin_groups_path
      return
    else
      @error_messages = @group
      render 'new'
      return
    end
    @group_method = "PATCH"
    @group_form_url = admin_group_path(@group.id)
  end

  # edit group
  def edit
    # find record with an id params
    @group = Group.find_by_id(params[:id])

    unless @group
      flash[:error] = "Group not found with an id ##{params[:id]}"
      redirect_to admin_groups_path
      return
    end

    @departments = Department.all
    @group_method = "PATCH"
    @group_form_url = admin_group_path(@group.id)
  end

  # update group
  def update
    # find record with an id params
    @group = Group.find_by_id(params[:id])

    unless @group
      flash[:error] = "Group not found with an id ##{params[:id]}"
      redirect_to admin_groups_path
      return
    end

    @group_method = "PATCH"
    @group_form_url = admin_group_path(@group.id)
    @departments = Department.all

    # if update record success
    if @group.update(group_params)
      flash[:success] = "Group #{@group.name} had been updated successfully."
      redirect_to admin_groups_path
      return
    else
      @error_messages = @group
      render 'edit'
      return
    end
  end

  def show
    # find record with an id params
    @group = Group.find_by_id(params[:id])

    unless @group
      flash[:error] = "Group not found with an id ##{params[:id]}"
      redirect_to admin_dashboard_path
      return
    end

    @department = @group.department
    @students = Student.where(group_id: @group.id)
  end

  def report
    @group = Group.find_by_id(params[:id])

    unless @group
      flash[:error] = "Group not found with an id ##{params[:id]}"
      redirect_to admin_dashboard_path
      return
    end
    @students = Student.where(group_id: @group.id)
    @student_subjects = StudentSubjects.where(student_id: @student.id)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :department_id)
  end
end
