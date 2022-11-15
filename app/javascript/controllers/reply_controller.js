import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="read-more"
export default class extends Controller {
  static targets = ["trigger", "closed", "content"]

  display() {
    if (this.closedTarget.classList.contains('hidden')){
      this.closedTarget.classList.remove('hidden')
      this.contentTarget.classList.remove('hidden')
      this.triggerTarget.classList.add('hidden')
    }
  }

  hide() {
    if (this.triggerTarget.classList.contains('hidden')){
      this.closedTarget.classList.add('hidden')
      this.contentTarget.classList.add('hidden')
      this.triggerTarget.classList.remove('hidden')
    }
  }
}