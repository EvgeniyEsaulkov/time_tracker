# frozen_string_literal: true

require "rails_helper"

feature "Create blank week of worklogs" do
  include_context "when current user signed in"

  let!(:project) { create(:project, name: "Project Name 1") }
  let!(:activity) { create(:activity, name: "Activity Name 1") }
  let!(:employee) { create(:employee, user: current_user) }
  let(:work_date) { Date.current }

  before { visit worklogs_path }

  scenario "User successfully adds a new row with worklogs", js: true do
    click_button "Add new row"

    within "#addNewRowModal" do
      select project.name, from: "Project:"
      select activity.name, from: "Activity:"
      click_button "Add"
    end

    expect(page).not_to have_css("#addNewRowModal")

    within "#worklog-table" do
      expect(page).to have_content(project.name)
      expect(page).to have_content(activity.name)
    end
  end

  scenario "User tries to add a new row with duplicated data", js: true do
    create(:worklog, project: project, activity: activity, employee: employee, work_date: Date.current)

    click_button "Add new row"

    within "#addNewRowModal" do
      select project.name, from: "Project:"
      select activity.name, from: "Activity:"
      click_button "Add"
    end

    modal = page.find("#addNewRowModal")
    expect(modal).not_to have_css("hidden")

    within "#addNewRowModal" do
      expect(page).to have_content("Row with these Project and Activity is already present in the table")
    end
  end
end
