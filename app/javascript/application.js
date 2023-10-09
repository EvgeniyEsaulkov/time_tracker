// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "trix"
import "@rails/actiontext"
import { Turbo } from "@hotwired/turbo"
import morphdom from "morphdom"
import TurboPower from "turbo_power"

TurboPower.initialize(Turbo.StreamActions)

document.addEventListener("turbo:before-render", (event) => {
  event.detail.render = async (currentElement, newElement) => {
    await new Promise((resolve) => setTimeout(() => resolve(), 0));

    morphdom(currentElement, newElement)
  }
})
