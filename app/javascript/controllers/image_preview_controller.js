import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "output", "input", "bgOutput", "bgInput" ]

//   readURL() {
//     if (this.inputTarget){
//     var input = this.inputTarget
//     var output = this.outputTarget}
//     if (this.bgOutputTarget){
//     var input = this.inputTarget
//     var output = this.outputTarget}
//     if (input.files && input.files[0]) {
//       var reader = new FileReader();

//       reader.onload = function () {
//        output.src = reader.result
//      }
//      reader.readAsDataURL(input.files[0]);
//    }
//  }

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