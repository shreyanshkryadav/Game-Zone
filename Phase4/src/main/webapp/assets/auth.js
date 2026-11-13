document.addEventListener("DOMContentLoaded", () => {
  const signupForm = document.getElementById("signup");
  const password = document.getElementById("signupPassword");
  const confirmation = document.getElementById("confirmPassword");

  if (!signupForm || !password || !confirmation) return;

  signupForm.addEventListener("submit", event => {
    if (password.value !== confirmation.value) {
      event.preventDefault();
      confirmation.setCustomValidity("The passwords do not match.");
      confirmation.reportValidity();
      return;
    }
    confirmation.setCustomValidity("");
  });

  confirmation.addEventListener("input", () => confirmation.setCustomValidity(""));
});
