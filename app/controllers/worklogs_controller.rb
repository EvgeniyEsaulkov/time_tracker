# frozen_string_literal: true

class WorklogsController < ApplicationController
  def index
    @start_date = if params[:start_date].present?
      Date.parse(params[:start_date]).beginning_of_week
    else
      Date.current.beginning_of_week
    end

    @end_date = @start_date.end_of_week
    @grouped_worklogs = worklogs.group_by { |w| [w.project, w.activity] }
  end

  private

  def worklogs
    return [] if current_user.employees.none?

    current_user.employees.first.worklogs
      .includes(:project, :activity)
      .where(work_date: @start_date..@end_date)
  end
end
