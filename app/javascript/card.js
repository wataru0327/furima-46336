document.addEventListener("turbo:load", setupPayjpForm);

function setupPayjpForm() {
  const form = document.getElementById("charge-form");
  if (!form) return;

  // mount先を毎回リセット
  ["card-number", "card-exp", "card-cvc"].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.innerHTML = "";
  });

  if (typeof Payjp === "undefined") return;

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
      console.error("Payjp Error:", error); 
      showError("クレジットカード情報を正しく入力してください");
      return;
    }

    const tokenObj = document.createElement("input");
    tokenObj.type = "hidden";
    tokenObj.name = "token";
    tokenObj.value = id;
    form.appendChild(tokenObj);

    form.submit();
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













