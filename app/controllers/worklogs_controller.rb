# frozen_string_literal: true

class WorklogsController < ApplicationController
  def index
    @start_date = Date.current.beginning_of_week
    @end_date = Date.current.end_of_week

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
