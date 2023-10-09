import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hideModal(event) {
    const targetEl = document.getElementById(event.target.dataset.target);
    const modal = new Modal(targetEl);
    modal.hide();
  }
}
