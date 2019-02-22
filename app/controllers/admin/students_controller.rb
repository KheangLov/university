class Admin::StudentsController < ApplicationController
  layout :admin_layout_template

  # List all students
  def index
    @students = Student.all
  end

  # init new student
  def new
    # initialize formdata
    @student = Student.new
    @groups = Group.all
    @student_form_url = admin_students_path
  end

  # create new student
  def create
    # initialize formdata
    @student = Student.new(student_params)
    @student_form_url = admin_students_path
    @groups = Group.all
    # @student.name = @student.lastname + @student.firstname

    # if save record success
    if @student.save
      flash[:success] = "student #{@student.name} had been created successfully."
      redirect_to admin_students_path
      return
    else
      @error_messages = @student
      render 'new'
      return
    end
  end

  # edit student
  def edit
    # find record with an id params
    @student = Student.find_by_id(params[:id])

    unless @student
      flash[:error] = "student not found with an id ##{params[:id]}"
      redirect_to admin_students_path
      return
    end

    @groups = Group.all
    @student_method = "PATCH"
    @student_form_url = admin_student_path(@student.id)
  end

  # update student
  def update
    # find record with an id params
    @student = Student.find_by_id(params[:id])

    unless @student
      flash[:error] = "student not found with an id ##{params[:id]}"
      redirect_to admin_students_path
      return
    end

    @student_method = "PATCH"
    @student_form_url = admin_student_path(@student.id)
    @groups = Group.all

    # if update record success
    if @student.update(student_params)
      flash[:success] = "student #{@student.name} had been updated successfully."
      redirect_to admin_students_path
      return
    else
      @error_messages = @student
      render 'edit'
      return
    end
  end

  def show
    # find record with an id params
    @student = Student.find_by_id(params[:id])

    unless @student
      flash[:error] = "Student not found with an id ##{params[:id]}"
      redirect_to admin_dashboard_path
      return
    end

    @student_subject = StudentSubject.new
    @student_subject_form_url = admin_student_add_score_path(@student.id)

    @group = @student.group
    @department = @group.department
    @subjects = @department.subjects
    @student_subjects = StudentSubject.where(student_id: @student.id, department_id: @department.id)
  end

  def add_score
    # find record with an id params
    @student = Student.find_by_id(params[:id])

    unless @student
      respond_to do |format|
        format.html {
          flash[:error] = "Student not found with an id ##{params[:id]}"
          redirect_to admin_dashboard_path
        }
        format.json { render json: {status: false, cls_opt: 'error', title: 'Add Score', message: "Student not found with an id ##{params[:id]}"} }
      end
      return
    end

    @group = @student.group
    @department = @group.department
    @subjects = @department.subjects

    @student_subjects = StudentSubject.where(student_id: @student.id, department_id: @department.id)

    @student_subject = StudentSubject.new(student_subject_params)
    @student_subject_form_url = admin_student_add_score_path(@student.id)

    @student_subject.department_id = @department.id
    @student_subject.student_id = @student.id
    if @student_subject.save
      list_html = render_to_string(partial: 'student_list', formats: [:html], layout: false)
      respond_to do |format|
        @success_message = @student_subject
        success_html = render_to_string(partial: 'shared/success_messages', formats: [:html], layout: false)
        format.html {
          flash[:success] = "student #{@student.name}'s score has been added successfully."
          redirect_to admin_student_path(@student.id)
        }
        format.json { render json: {status: true, cls_opt: 'success', list_html: list_html, title: 'Add Score', message: success_html} }
      end
      return
    else
      respond_to do |format|
        @error_messages = @student_subject
        error_html = render_to_string(partial: 'shared/error_messages', formats: [:html], layout: false)
        format.html {
          render 'show'
        }
        format.json { render json: {status: false, cls_opt: 'error', title: 'Add Score', message: error_html} }
      end
      return
    end
  end

  private

  def student_subject_params
    params.require(:student_subject).permit(:score, :subject_id, :student_id, :department_id, :homework, :total)
  end

  def student_params
    params.require(:student).permit(:lastname, :firstname, :name, :group_id, :gender, :dob, :email, :phone)
  end
end
