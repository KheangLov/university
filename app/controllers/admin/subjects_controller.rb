class Admin::SubjectsController < ApplicationController
  layout :admin_layout_template

  # List all subjects
  def index
    @subjects = Subject.all
  end

  # init new subject
  def new
    # initialize formdata
    @subject = Subject.new
    @departments = Department.all
    @subject_form_url = admin_subjects_path
  end

  # create new subject
  def create
    # initialize formdata
    @subject = Subject.new(subject_params)
    @subject_form_url = admin_subjects_path
    @departments = Department.all

    # if save record success
    if @subject.save
      respond_to do |format|
        format.html {
          flash[:success] = "subject #{@subject.name} had been created successfully."
          redirect_to admin_subjects_path
        }
        format.json { render :json => { status: true, title: 'create subject', message: "Subject #{@subject.name} had been created successfully." } }
      end
      return
    else
      @error_messages = @subject
      html_form = render_to_string(partial: 'shared/error_messages', formats: [:html], layout: false)
      respond_to do |format|
        format.html { render 'new' }
        format.json { render :json => { status: false, title: 'create subject', html_form: html_form } }
      end
      return
    end
  end

  # edit subject
  def edit
    # find record with an id params
    @subject = Subject.find_by_id(params[:id])

    unless @subject
      flash[:error] = "subject not found with an id ##{params[:id]}"
      redirect_to admin_subjects_path
      return
    end

    @departments = Department.all
    @subject_method = "PATCH"
    @subject_form_url = admin_subject_path(@subject.id)
  end

  # update subject
  def update
    # find record with an id params
    @subject = Subject.find_by_id(params[:id])

    unless @subject
      flash[:error] = "subject not found with an id ##{params[:id]}"
      redirect_to admin_subjects_path
      return
    end

    @subject_method = "PATCH"
    @subject_form_url = admin_subject_path(@subject.id)
    @departments = Department.all

    # if update record success
    if @subject.update(subject_params)
      flash[:success] = "subject #{@subject.name} had been updated successfully."
      redirect_to admin_subjects_path
      return
    else
      @error_messages = @subject
      render 'edit'
      return
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :department_id)
  end
end
