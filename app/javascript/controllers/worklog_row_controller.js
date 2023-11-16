import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cell", "total"];
  static values = {
    activity: Number,
    project: Number
  }

  connect() {
    document.addEventListener("cellUpdated", this.calculateTotal.bind(this))
  }

  calculateTotal(event) {
    const currentProject = event.detail.currentCell.dataset.project
    const currentActivity = event.detail.currentCell.dataset.activity

    if ((this.activityValue == currentActivity) && (this.projectValue == currentProject)) {
      const rowTotal = this.cellTargets.reduce((sum, cell) => sum + Number(cell.innerText), 0)
      this.totalTarget.innerText = rowTotal.toFixed(1)
    }
  }
}
