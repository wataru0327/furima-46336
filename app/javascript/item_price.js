document.addEventListener("turbo:load", () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // 出品ページ以外では動作しないようにする

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);
    const tax = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    if (Number.isNaN(price)) {
      tax.textContent = 0;
      profit.textContent = 0;
    } else {
      const taxValue = Math.floor(price * 0.1); // 10% 手数料（小数点以下切り捨て）
      const profitValue = Math.floor(price - taxValue);
      tax.textContent = taxValue;
      profit.textContent = profitValue;
    }
  });
});