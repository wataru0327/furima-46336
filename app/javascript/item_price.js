document.addEventListener("turbo:load", setupPriceCalc);
document.addEventListener("turbo:render", setupPriceCalc);

function setupPriceCalc() {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);
    const tax = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    if (Number.isNaN(price)) {
      tax.textContent = 0;
      profit.textContent = 0;
    } else {
      const taxValue = Math.floor(price * 0.1);
      const profitValue = Math.floor(price - taxValue);
      tax.textContent = taxValue;
      profit.textContent = profitValue;
    }
  });
}