// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

// Hotwireを適切に設定しないと、エラーメッセージが表示されなくなる
import "@hotwired/turbo-rails"
// Hotwireを利用したくない場面では適宜無効化する
// Turbo.session.drive = false


// ハンバーガーメニューのクリックイベント
function hamburger() {
  document.getElementById('line1').classList.toggle('line_1');
  document.getElementById('line2').classList.toggle('line_2');
  document.getElementById('line3').classList.toggle('line_3');
  document.getElementById('sidebar').classList.toggle('in');
}
document.getElementById('hamburger').addEventListener('click', hamburger);


// /* スクロール時にヘッダーの表示切り替え */

// // ヘッダーを取得
// const header = document.getElementById("header");
// // ヘッダーの高さを取得
// const hH = header.clientHeight;
// // 現在地を示す変数を定義
// let pos = 0;
// // スクロール直前の位置を示す変数を定義
// let lastPos = 0;
// const onScroll = () => {
//   if(pos > hH && pos > lastPos) {
//     header.classList.add('header--unpinned');
//   }

//   // スクロール直前の位置を示す変数を定義
//   // 最後のスクロール位置を保存
//   lastPos = pos;
//   // ウィンドウの高さを取得
//   const winH = window.innerHeight;
//   // ページの高さを取得
//   const docH = document.documentElement.scrollHeight;
//   // ウィンドウが最下部達した場合のウィンドウ上部の位置を取得
//   const windBtm = docH - winH;
//   if(pos < hH || pos < lastPos || windBtm <= pos) {
//     header.classList.remove('header--unpinned');
//   }
// };
//   window.addEventListener("scroll", () => {
//     // スクロールするごとにpos（現在地）の値を更新
//     pos = window.scrollY;
//     onScroll();
// });

