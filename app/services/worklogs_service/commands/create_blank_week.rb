# frozen_string_literal: true

class WorklogsService::Commands::CreateBlankWeek
  def self.call(...)
    new(...).call
  end

  def initialize(project_id:, activity_id:, employee_id:, work_date:)
    @start_date = Date.parse(work_date).beginning_of_week
    @end_date = start_date.end_of_week
    @project = Project.find(project_id)
    @activity = Activity.find(activity_id)
    @employee_id = employee_id
  end

  def call
    return already_created_failure if worklog_data_exists?

    worklogs = []
    worklog_attrs = {project:, activity:, employee_id:, hours: 0.0}
    ActiveRecord::Base.transaction do
      (start_date..end_date).each do |work_date|
        worklogs << Worklog.create!(worklog_attrs.merge(work_date: work_date))
      end
    end

    Result.success({project:, activity:, start_date:, end_date:, worklogs:})
  end

  private

  attr_reader :start_date, :end_date, :project, :activity, :employee_id

  def worklog_data_exists?
    Worklog
      .where(project: project, activity: activity, employee_id: employee_id, work_date: start_date..end_date)
      .exists?
  end

  def already_created_failure
    Result.failure(
      type: :already_created,
      payload: {message: "Row with these Project and Activity is already present in the table"}
    )
  end
end
