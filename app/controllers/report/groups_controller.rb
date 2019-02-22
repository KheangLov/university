class Report::GroupsController < ApplicationController
  layout :admin_layout_template

  def index
    @groups = Group.all
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
    @student = Student.where(group_id: @group.id)
    @student_subjects = StudentSubject.where(student_id: @student.ids).distinct.order(:student_id)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :department_id)
  end
end
