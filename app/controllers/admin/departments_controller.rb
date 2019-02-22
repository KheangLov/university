class Admin::DepartmentsController < ApplicationController
  layout :admin_layout_template

  # List all departments
  def index
    @departments = Department.all
    @department = Department.new
    @department_form_url = admin_departments_path
  end

  # init new department
  def new
    # initialize formdata
    @departments = Department.all
    @department = Department.new
    @department_form_url = admin_departments_path
  end

  # create new department
  def create
    # initialize formdata
    @departments = Department.all
    @department = Department.new(department_params)
    @department_form_url = admin_departments_path

    # if save record success
    if @department.save
      list_html = render_to_string(partial: 'list', formats: [:html], layout: false)
      respond_to do |format|
        # @success_messages = @department
        # success_html = render_to_string(partial: 'shared/success_messages', formats: [:html], layout: false)
        format.html {
          flash[:success] = "Department #{@department.name} had been created successfully."
          redirect_to admin_departments_path
        }
        format.json { render :json => { status: true, cls_opt: 'success', list_html: list_html, title: 'create department', message: "Department #{@department.name} had been added successfully." } }
      end
      return
    else
      respond_to do |format|
        @error_messages = @department
        html_form = render_to_string(partial: 'shared/error_messages', formats: [:html], layout: false)
        format.html { render 'index' }
        format.json { render json: { status: false, cls_opt: 'error', title: 'create department', message: html_form } }
      end
      return
    end
  end

  # edit department
  def edit
    # find record with an id params
    @departments = Department.all
    @department = Department.find_by_id(params[:id])

    unless @department
      flash[:error] = "Department not found with an id ##{params[:id]}"
      redirect_to admin_departments_path
      return
    end

    @department_method = "PATCH"
    @department_form_url = admin_department_path(@department.id)
  end

  # update department
  def update
    # find record with an id params
    @department = Department.find_by_id(params[:id])

    unless @department
      flash[:error] = "Department not found with an id ##{params[:id]}"
      redirect_to admin_departments_path
      return
    end

    @department_method = "PATCH"
    @department_form_url = admin_department_path(@department.id)

    # if update record success
    if @department.update(department_params)
      flash[:success] = "Department #{@department.name} had been updated successfully."
      redirect_to admin_departments_path
      return
    else
      @error_messages = @department
      render 'edit'
      return
    end
  end

  def show
    # find record with an id params
    @department = Department.find_by_id(params[:id])

    unless @department
      flash[:error] = "Department not found with an id ##{params[:id]}"
      redirect_to admin_dashboard_path
      return
    end

    @groups = Group.where(department_id: @department.id)
  end

  private

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
