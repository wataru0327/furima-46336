document.addEventListener("turbo:load", setupPayjpForm);

function setupPayjpForm() {
  console.log("setupPayjpForm called");

  const form = document.getElementById("charge-form");
  console.log("form:", form);

  if (!form) return;

  console.log("Payjp:", Payjp);
  if (typeof Payjp === "undefined") {
    console.error("Payjp is not loaded");
    return;
  }

  const newForm = form.cloneNode(true);
  form.parentNode.replaceChild(newForm, form);

  ["card-number", "card-exp", "card-cvc"].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.innerHTML = "";
  });

  const publicKey = document.querySelector("meta[name='payjp-public-key']").content;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  numberElement.mount("#card-number");

  const expiryElement = elements.create("cardExpiry");
  expiryElement.mount("#card-exp");

  const cvcElement = elements.create("cardCvc");
  cvcElement.mount("#card-cvc");

  newForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    try {
      const result = await payjp.createToken(numberElement);
      console.log("createToken result:", result);

      if (result.error || !result.id) {
        console.error("Payjp Error:", result.error);
        alert("カード情報が正しく入力されていません。");
        return; // ❌ submitしない
      }

      console.log("Payjp Token:", result.id);

      const tokenObj = document.createElement("input");
      tokenObj.type = "hidden";
      tokenObj.name = "token";
      tokenObj.value = result.id;
      newForm.appendChild(tokenObj);

      newForm.submit();
    } catch (e) {
      console.error("Token creation failed:", e);
      alert("カード情報の登録中にエラーが発生しました。時間を置いて再度お試しください。");
    }
  });
}

















