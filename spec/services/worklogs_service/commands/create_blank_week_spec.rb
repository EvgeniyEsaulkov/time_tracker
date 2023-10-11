# frozen_string_literal: true

require "rails_helper"

describe WorklogsService::Commands::CreateBlankWeek do
  subject(:create_blank_week) do
    described_class.call(
      project_id: project.id,
      activity_id: activity.id,
      employee_id: employee.id,
      work_date: work_date
    )
  end

  let(:project) { create(:project) }
  let(:activity) { create(:activity) }
  let(:employee) { create(:employee) }
  let(:work_date) { Date.current.strftime("%d-%m-%Y") }

  describe ".call" do
    context "when worklog data does not exist" do
      it "creates a blank week of worklogs" do
        expect { subject }.to change(Worklog, :count).by(7)
      end
    end

    context "when worklog data already exists" do
      before do
        create(:worklog, project: project, activity: activity, employee: employee, work_date: work_date)
      end

      it "returns a failure result" do
        result = create_blank_week

        expect(result.failure?).to be true
        expect(result.failure).to eq({
          type: :already_created,
          payload: {message: "Row with these Project and Activity is already present in the table"}
        })
      end

      it "doesn't create new records" do
        expect { subject }.not_to change(Worklog, :count)
      end
    end
  end
end
