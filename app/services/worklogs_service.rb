# frozen_string_literal: true

class WorklogsService
  def create_blank_week(project_id:, activity_id:, employee_id:, work_date:)
    start_date = Date.parse(work_date).beginning_of_week
    end_date = start_date.end_of_week

    if worklog_data_exists?(project_id: project_id, activity_id: activity_id, employee_id: employee_id, start_date: start_date, end_date: end_date)
      failure = Result.failure(type: :already_created, payload: { message: "Row with these Project and Activity is already present in the table" })
      return failure
    end

    project = Project.find(project_id)
    activity = Activity.find(activity_id)

    worklogs = []
    ActiveRecord::Base.transaction do
      (start_date..end_date).each do |work_date|
        worklogs << Worklog.create!(project: project, activity: activity, employee_id: employee_id, work_date: work_date, hours: 0.0)
      end
    end

    Result.success({
      project: project,
      activity: activity,
      start_date: start_date,
      end_date: end_date,
      worklogs: worklogs
    })
  end

  private

  def worklog_data_exists?(project_id:, activity_id:, employee_id:, start_date:, end_date:)
    Worklog
      .where(project_id: project_id, activity_id: activity_id, employee_id: employee_id, work_date: start_date..end_date)
      .exists?
  end
end
