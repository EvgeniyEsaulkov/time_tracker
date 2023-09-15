import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cell"]

  connect() {
    document.addEventListener("cellUpdated", this.moveToNextCell.bind(this))
    console.log('Cells: ', this.cellTargets);
  }

  moveToNextCell(event) {
    const currentCell = event.detail.currentCell
    const currentCellIndex = Array.from(this.cellTargets).indexOf(currentCell)
    const nextCellIndex = currentCellIndex + 1

    const nextCell = this.cellTargets[nextCellIndex]
    if (nextCell) {
      nextCell.querySelector("[data-action='click->worklog-edit#edit']").click()
    }
  }
}
