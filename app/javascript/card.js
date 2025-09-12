document.addEventListener("turbo:load", setupPayjpForm);
document.addEventListener("DOMContentLoaded", setupPayjpForm);

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

  // カード入力欄の初期化
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

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    try {
      // ✅ 正しく { token, error } を受け取る
      const { error, token } = await payjp.createToken(numberElement);

      if (error) {
        console.error("Payjp Error:", error);
        showError("クレジットカード情報を正しく入力してください");
        return;
      }

      console.log("Payjp Token:", token);

      // ✅ token.id を hidden フィールドに追加
      const tokenObj = document.createElement("input");
      tokenObj.type = "hidden";
      tokenObj.name = "token";
      tokenObj.value = token.id;
      form.appendChild(tokenObj);

      form.submit();
    } catch (e) {
      console.error("Token creation failed:", e);
      showError("通信エラーが発生しました。時間をおいて再度お試しください。");
    }
  });
}

function showError(message) {
  let errorBox = document.querySelector(".error-alert ul");

  if (!errorBox) {
    const alertDiv = document.createElement("div");
    alertDiv.classList.add("error-alert");
    const ul = document.createElement("ul");
    alertDiv.appendChild(ul);
    document.querySelector(".transaction-main").prepend(alertDiv);
    errorBox = ul;
  }

  const li = document.createElement("li");
  li.classList.add("error-message");
  li.innerText = message;
  errorBox.appendChild(li);
}














