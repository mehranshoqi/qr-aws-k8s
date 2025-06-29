function generate() {
  const text = document.getElementById("text").value;
  fetch("https://api.dev.mehran.app/generate", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ text }),
  })
    .then((res) => res.blob())
    .then((blob) => {
      const url = URL.createObjectURL(blob);
      document.getElementById("qr").src = url;
    });
}
