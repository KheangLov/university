class Admin::UsersController < ApplicationController
  layout :admin_layout_template

  def dashboard
    @departments = Department.all
  end

  def reports
    @departments = Department.all
  end
end
