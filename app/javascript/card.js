document.addEventListener("turbo:load", () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = document.querySelector("meta[name='payjp-public-key']").content;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  if (!document.querySelector("#card-number iframe")) {
    const numberElement = elements.create("cardNumber");
    numberElement.mount("#card-number");

    const expiryElement = elements.create("cardExpiry");
    expiryElement.mount("#card-exp");

    const cvcElement = elements.create("cardCvc");
    cvcElement.mount("#card-cvc");
  }

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const { error, id } = await payjp.createToken();

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











