import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cell", "display", "input"]

  edit() {
    this.displayTarget.classList.add("hidden")
    this.inputTarget.classList.remove("hidden")
    this.inputTarget.focus()
  }

  update(event) {
    const date = this.cellTarget.dataset.date
    const project = this.cellTarget.dataset.project
    const activity = this.cellTarget.dataset.activity
    const hours = this.inputTarget.value

    const input = this.inputTarget
    const currentCell = this.cellTarget

    fetch("/worklogs/update", {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify({
        date: date,
        project: project,
        activity: activity,
        hours: hours,
      }),
    })
    .then(response => response.json())
    .then(data => {
      const display = this.displayTarget
      display.innerText = hours
      display.classList.remove("hidden")
      input.classList.add("hidden")

      this.toggleCell();

      const eventToDispatch = new CustomEvent("cellUpdated", { detail: { currentCell } })
      document.dispatchEvent(eventToDispatch)
    })
    .catch(error => {
      console.error("Error:", error)
      // Handle errors if needed
    })
  }

  toggleCell() {
    this.inputTarget.classList.toggle("hidden")
    this.displayTarget.classList.toggle("hidden")
  }

  handleKeyUp(event) {
    if (event.key === "Enter") {
      this.update(event)
    }
  }
}
