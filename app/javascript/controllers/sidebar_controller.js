import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = 
    ["displaySidebar", "hamburger", "line1", "line2", "line3", "covering"]

  static values = { open: Boolean }

    // open valueのboolean値による切り替え
    toggle() {
      this.openValue = !this.openValue
    }

    openValueChanged() {
      if (this.openValue == "1") {
        this.hamburgerOn()
        this.expand()
        this.cover()
      } else {
        this.hamburgerOff()
        this.collapse()
        this.uncover()
      }
    }

  close() {
    if (this.openValue == "1") {
      this.hamburgerOff()
      this.collapse()
      this.uncover()
    }
  }
  
  hamburgerOn() {
    this.line1Target.classList.add('line_1')
    this.line2Target.classList.add('line_2')
    this.line3Target.classList.add('line_3')
  }

  expand() {
    this.displaySidebarTarget.classList.add('sidebar')
    this.openValue = true;
  }

  hamburgerOff() {
    this.line1Target.classList.remove('line_1')
    this.line2Target.classList.remove('line_2')
    this.line3Target.classList.remove('line_3')
  }

  collapse() {
    this.displaySidebarTarget.classList.remove('sidebar')
    this.openValue = false;
  }
  
  cover() {
    this.coveringTarget.classList.add('sidebar-cover')
  }

  uncover() {
    this.coveringTarget.classList.remove('sidebar-cover')
  }
}
