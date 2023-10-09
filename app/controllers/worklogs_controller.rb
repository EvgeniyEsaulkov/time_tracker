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

  def create
    worklog_attrs = worklogs_params.merge(employee_id: current_user.employees.first.id).to_h.symbolize_keys
    result = worklogs_service.create_blank_week(**worklog_attrs)

    if result.success?
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("worklog-table", partial: "worklogs/worklog_row", locals: result.value),
            turbo_stream.dispatch_event("#worklog-row-form", "worklogRow:created")
          ]
        end
      end
    else
      worklog = Worklog.new(worklog_attrs)
      worklog.errors.add(:project_id, result.failure.dig(:payload, :message))
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "worklog-row-form",
            partial: "worklogs/worklog_row_form",
            locals: { worklog: worklog }
          )
        end
      end
    end
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

  def worklogs_params
    params.require(:worklog).permit(:project_id, :activity_id, :work_date)
  end

  def worklogs
    return [] if current_user.employees.none?

    current_user.employees.first.worklogs
      .includes(:project, :activity)
      .where(work_date: @start_date..@end_date)
  end

  def worklogs_service
    @worklogs_service ||= WorklogsService.new
  end
end
