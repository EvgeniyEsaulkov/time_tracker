// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import morphdom from "morphdom"

document.addEventListener("turbo:before-render", (event) => {
  event.detail.render = async (currentElement, newElement) => {
    await new Promise((resolve) => setTimeout(() => resolve(), 0));

    morphdom(currentElement, newElement)
  }
})
