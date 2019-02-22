class Report::UsersController < ApplicationController
  layout :admin_layout_template

  def reports
    @departments = Department.all
  end
end
