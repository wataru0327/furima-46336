document.addEventListener("turbo:load", setupPayjpForm);
document.addEventListener("turbo:render", setupPayjpForm);

function setupPayjpForm() {
  const form = document.getElementById("charge-form");
  if (!form) return;

  if (form.dataset.payjpInitialized === "true") return;

  if (typeof Payjp === "undefined") {
    setTimeout(setupPayjpForm, 50);
    return;
  }

  const numberEl = document.getElementById("card-number");
  const expEl = document.getElementById("card-exp");
  const cvcEl = document.getElementById("card-cvc");
  if (!numberEl || !expEl || !cvcEl) {
    setTimeout(setupPayjpForm, 50);
    return;
  }

  form.dataset.payjpInitialized = "true";

  const publicKey = document.querySelector("meta[name='payjp-public-key']").content;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();


  const numberElement = elements.create("cardNumber");
  numberElement.mount("#card-number");

  const expiryElement = elements.create("cardExpiry");
  expiryElement.mount("#card-exp");

  const cvcElement = elements.create("cardCvc");
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
    tokenObj.type = "hidden";
    tokenObj.name = "token";
    tokenObj.value = id;
    form.appendChild(tokenObj);

    form.submit();
  }, { once: true });
}













