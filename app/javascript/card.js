document.addEventListener("turbo:load", () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = document.querySelector("meta[name='payjp-public-key']").content;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#card-number");
  expiryElement.mount("#card-exp");
  cvcElement.mount("#card-cvc");

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const { error, id } = await payjp.createToken(numberElement);

    if (error) {
      console.error("トークン作成エラー:", error);
      alert("カード情報が正しくありません");
      return;
    }

    const tokenObj = document.createElement("input");
    tokenObj.setAttribute("type", "hidden");
    tokenObj.setAttribute("name", "token");
    tokenObj.setAttribute("value", id);
    form.appendChild(tokenObj);

    form.submit();
  });
});










