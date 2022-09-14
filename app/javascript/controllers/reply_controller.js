import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="read-more"
export default class extends Controller {
  static targets = ["trigger", "closed", "content"]

  connect() {
    this.hide()
  }

  display() {
    this.triggerTarget.hidden = true
    this.contentTarget.hidden = false
    this.closedTarget.hidden = false
  }

  hide() {
    this.triggerTarget.hidden = false
    this.contentTarget.hidden = true
    this.closedTarget.hidden = true
  }
}