function item (){
  const price = document.getElementById("item-price");
  price.addEventListener("input", () => {
    priceValue = price.value;
    const taxPrice = document.getElementById('add-tax-price');
    const profitPrice = document.getElementById('profit');
    const taxPriceFloor = Math.floor(priceValue * 0.1)
    
    taxPrice.innerHTML = taxPriceFloor
    profitPrice.innerHTML = priceValue - taxPriceFloor
  });
}

window.addEventListener('load', item);