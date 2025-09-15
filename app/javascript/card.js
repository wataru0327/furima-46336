document.addEventListener("turbo:load", setupPayjpForm);

function setupPayjpForm() {
  const form = document.getElementById("charge-form");
  if (!form) return;

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

      if (result.id) {
        // トークンがある場合だけ hidden に追加
        const tokenObj = document.createElement("input");
        tokenObj.type = "hidden";
        tokenObj.name = "token";
        tokenObj.value = result.id;
        newForm.appendChild(tokenObj);
      }
      // トークンがなくても submit → Rails 側で "Token can't be blank" が出る
      newForm.submit();

    } catch (e) {
      console.error("Token creation failed:", e);
      newForm.submit(); // 失敗しても Rails に任せる
    }
  });
}


















