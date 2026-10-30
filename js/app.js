document.addEventListener("DOMContentLoaded", () => {
  const soundBtn = document.getElementById("sound-toggle");
  const sfx = window.stnatrixSFX;

  function updateSoundButtonLabel() {
    if (!soundBtn || !sfx) return;
    const isMuted = sfx.isMuted();
    soundBtn.textContent = `Sound: ${isMuted ? "Off" : "On"}`;
  }

  if (soundBtn && sfx) {
    updateSoundButtonLabel();
    soundBtn.addEventListener("click", () => {
      sfx.toggleMute();
      updateSoundButtonLabel();
      sfx.playClick();
    });
  }

  const clickableElements = document.querySelectorAll(".project-card, .btn-primary, .btn-secondary, .btn-icon, .footer-link");
  clickableElements.forEach((el) => {
    el.addEventListener("click", () => {
      if (sfx) {
        sfx.playClick();
      }
    });
  });
});
