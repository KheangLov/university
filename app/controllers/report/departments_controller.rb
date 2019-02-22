class Report::DepartmentsController < ApplicationController
  layout :admin_layout_template

  # List all departments
  def index
    @departments = Department.all
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
