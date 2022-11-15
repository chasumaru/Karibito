import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "output", "input", "bgOutput", "bgInput" ]

  preview() {
    var input = this.sourceTarget
    var files = input.files
    var imgLoc = document.getElementById("Img")
    for (var i = 0; i < files.length; i++) {
      let reader = new FileReader()
      reader.onload = function() {
        let image = document.createElement("img")
        imgLoc.appendChild(image)
        image.classList.add("pictures");
        image.src = reader.result
      }
      if (i > 0){
      reader.readAsDataURL(files[i])
      }
    }
  }

  readURL() {
    var input = this.inputTarget
    var output = this.outputTarget
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function () {
      output.src = reader.result
      }
    reader.readAsDataURL(input.files[0]);
    }
  }

  readBgURL() {
    var input = this.bgInputTarget
    var output = this.bgOutputTarget
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function () {
      output.src = reader.result
      }
    reader.readAsDataURL(input.files[0]);
    }
  }
}