//window.addEventListener('load', function(){
function sellingprice(){

  const priceInput = document.getElementById("item-price")
 // console.log("set")
 // console.log(priceInput)
  const addTaxPrice = document.getElementById("add-tax-price");
  const profitElement = document.getElementById("profit");

  priceInput.addEventListener('input', function() {
 // console.log(priceInput)

  const price = parseFloat(priceInput.value);
  if (!isNaN(price)) {
    const commission = price * 0.1; // 10%を計算
    addTaxPrice.textContent = commission.toFixed(0) ; // 結果を表示

    const profit = price - commission; // 販売利益を計算
    profitElement.textContent = profit.toFixed(0) ;

  } else {
    addTaxPrice.textContent = ''; // 価格が無効な場合は表示をクリア
    profitElement.textContent = ''; // 価格が無効な場合は表示をクリア
  }
  })
}

import { application } from "controllers/application"

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

window.addEventListener('DOMContentLoaded', sellingprice)
//window.addEventListener('load', sellingprice)
