document.addEventListener("DOMContentLoaded", () => {
  const loginPanel = document.getElementById("loginForm");
  const signupPanel = document.getElementById("signupForm");
  const showSignup = () => {
    loginPanel.classList.remove("active");
    signupPanel.classList.add("active");
  };
  const showLogin = () => {
    signupPanel.classList.remove("active");
    loginPanel.classList.add("active");
  };
  document.getElementById("showSignup").addEventListener("click", showSignup);
  document.getElementById("showLogin").addEventListener("click", showLogin);
  if (document.body.dataset.showSignup === "true") showSignup();

  const password = document.getElementById("signupPassword");
  const confirmation = document.getElementById("confirmPassword");
  document.getElementById("signup").addEventListener("submit", event => {
    if (password.value !== confirmation.value) {
      event.preventDefault();
      confirmation.setCustomValidity("The passwords do not match.");
      confirmation.reportValidity();
    }
  });
  confirmation.addEventListener("input", () => confirmation.setCustomValidity(""));
});
