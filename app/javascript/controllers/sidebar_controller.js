import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static get targets() {
    // ターゲットの更新
    return ["displaySidebar", "hamburger", "line1", "line2", "line3"]
  }

  toggle() {
    //  sidebar-containerターゲットを持つ要素のdata-expanded属性が0であるか判定
      if (this.hamburgerTarget.dataset.expanded === "0") {
        this.hamburger()
        this.expand()
      } else {
        this.collapse()
      }
    }

  hamburger() {
    this.line1Target.classList.add('line_1')
    this.line2Target.classList.add('line_2')
    this.line3Target.classList.add('line_3')
  }

  expand() {
    this.displaySidebarTarget.classList.add('sidebar')
  }

  collapse() {
// クラスをremoveする
  }
}
