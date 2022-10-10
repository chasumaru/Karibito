import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="picture-cover"
export default class extends Controller {
  static targets = ["dangerCase", "normalCase" ]

  // カバーがない(hiddenがある)場合はカバーをかける(hiddenを外す)こと。カバーがある(hiddenがない)場合はカバーを外す(hiddenをつける)こと
  dangerToggle() {
    if (this.dangerCaseTarget.classList.contains('hidden')){
      this.dangerCaseTarget.classList.remove('hidden')
    }
    else {
      this.dangerCaseTarget.classList.add('hidden')
    }
  }

  normalToggle() {
    if (this.normalCaseTarget.classList.contains('hidden')){
      this.normalCaseTarget.classList.remove('hidden')
    }
    else {
      this.normalCaseTarget.classList.add('hidden')
    }
  }
}
