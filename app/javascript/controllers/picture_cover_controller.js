import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="picture-cover"
export default class extends Controller {
  static targets = ["dangerClick", "normalClick", "dangerPicture", "normalPicture" ]

  // カバーがない(hiddenがある)場合はカバーをかける(hiddenを外す)こと。カバーがある(hiddenがない)場合はカバーを外す(hiddenをつける)こと
  dangerToggle() {
    if (this.dangerClickTarget.classList.contains('hidden')){
      this.dangerClickTarget.classList.remove('hidden')
      this.dangerPictureTarget.classList.add('blur-sm')
    }
    else {
      this.dangerClickTarget.classList.add('hidden')
      this.dangerPictureTarget.classList.remove('blur-sm')
    }
  }

  normalToggle() {
    if (this.normalClickTarget.classList.contains('hidden')){
      this.normalClickTarget.classList.remove('hidden')
      this.normalPictureTarget.classList.add('blur-sm')
    }
    else {
      this.normalClickTarget.classList.add('hidden')
      this.normalPictureTarget.classList.remove('blur-sm')
    }
  }
}
