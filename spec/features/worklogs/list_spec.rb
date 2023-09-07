# frozen_string_literal: true

require "rails_helper"

feature "List worklogs" do
  include_context "when current user signed in"

  let(:project) { create(:project, name: "Project Name 1") }
  let(:activity) { create(:activity, name: "Activity Name 1") }
  let(:employee) { create(:employee, user: current_user) }

  scenario "User views Worklogs with existing records" do
    create(:worklog, employee:, project:, activity:, work_date: Date.current, hours: 6.5)

    visit worklogs_path

    expect(page).to have_content("Project Name 1")
    expect(page).to have_content("Activity Name 1")
    expect(page).to have_content(Date.current.strftime("%m/%d/%y"))
    expect(page).to have_content("6.5")
  end
end
