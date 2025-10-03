document.addEventListener("turbo:load", setupPayjpForm);

function setupPayjpForm() {
  const form = document.getElementById("charge-form");
  if (!form) return;

  if (typeof Payjp === "undefined") {
    console.error("Payjp is not loaded");
    return;
  }

  // フォームをリセット（複数回バインド防止）
  const newForm = form.cloneNode(true);
  form.parentNode.replaceChild(newForm, form);

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

  // フォーム送信時の処理
  newForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    try {
      // トークン作成を試みる
      const result = await payjp.createToken(numberElement);

      if (result.id) {
        // トークンが生成された場合のみ hidden に追加
        const tokenObj = document.createElement("input");
        tokenObj.type = "hidden";
        tokenObj.name = "token";
        tokenObj.value = result.id;
        newForm.appendChild(tokenObj);
      }
    } catch (e) {
      console.error("Token creation failed:", e);
      // 何もせずそのまま Rails 側に任せる
    }

    // ✅ 成功でも失敗でも最後に必ず submit → Rails がバリデーション実行
    newForm.submit();
  });
}


















