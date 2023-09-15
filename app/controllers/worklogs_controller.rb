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

  def update
    worklog = current_user.employees.first.worklogs.find_or_initialize_by(
      work_date: params[:date],
      project_id: params[:project],
      activity_id: params[:activity]
    )

    worklog.hours = params[:hours]

    if worklog.save
      render json: {hours: worklog.hours}
    else
      render json: {error: "Failed to update worklog"}, status: :unprocessable_entity
    end
  end

  private

  def worklogs
    return [] if current_user.employees.none?

    current_user.employees.first.worklogs
      .includes(:project, :activity)
      .where(work_date: @start_date..@end_date)
  end
end
