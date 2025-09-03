
document.addEventListener('turbo:load', () => {
  const form = document.getElementById("charge-form");
  if (!form) return; 


  const publicKey = document.querySelector("meta[name='payjp-public-key']").content;
  Payjp.setPublicKey(publicKey);  

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formData = new FormData(form);

   
    const card = {
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`, 
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const tokenInput = document.createElement("input");
        tokenInput.setAttribute("type", "hidden");
        tokenInput.setAttribute("name", "token");
        tokenInput.setAttribute("value", token);
        form.appendChild(tokenInput);

        document.getElementById("number-form").remove();
        document.getElementById("cvc-form").remove();
        document.getElementById("expiry-form").remove();

        form.submit();  
      } else {
        alert("カード情報が正しくありません");
      }
    });
  });
});
