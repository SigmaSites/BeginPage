<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8" />
  <title>beginnpage.de</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      min-height: 100vh;
      color: #fff;
    }

    .overlay {
      background: rgba(0,0,0,0.6);
      min-height: 100vh;
      padding: 20px;
    }

    h1 {
      margin-top: 0;
    }

    .box {
      background: rgba(255,255,255,0.1);
      padding: 15px;
      border-radius: 8px;
      max-width: 500px;
      margin-bottom: 20px;
    }

    input, button {
      width: 100%;
      padding: 10px;
      margin-top: 8px;
      border-radius: 4px;
      border: none;
      font-size: 14px;
    }

    button {
      background: #2196f3;
      color: white;
      cursor: pointer;
    }

    ul {
      list-style: none;
      padding: 0;
    }

    li {
      background: rgba(0,0,0,0.4);
      padding: 8px;
      margin-top: 6px;
      border-radius: 4px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    li a {
      color: #90caf9;
      text-decoration: none;
      word-break: break-all;
    }

    .delete {
      background: #e53935;
      border: none;
      color: white;
      padding: 4px 8px;
      cursor: pointer;
      border-radius: 4px;
    }
  </style>
</head>
<body>
  <div class="overlay">
    <h1>beginnpage.de</h1>

    <div class="box">
      <h2>Adresse hinzufügen</h2>
      <input type="text" id="urlInput" placeholder="https://example.de" />
      <button onclick="addUrl()">Hinzufügen</button>
      <ul id="urlList"></ul>
    </div>

    <div class="box">
      <h2>Hintergrundbild festlegen</h2>
      <input type="file" accept="image/*" onchange="setBackground(event)" />
      <button onclick="resetBackground()">Hintergrund zurücksetzen</button>
    </div>
  </div>

  <script>
    const urlInput = document.getElementById('urlInput');
    const urlList = document.getElementById('urlList');

    function loadUrls() {
      const urls = JSON.parse(localStorage.getItem('urls') || '[]');
      urlList.innerHTML = '';
      urls.forEach((url, index) => {
        const li = document.createElement('li');
        li.innerHTML = `<a href="${url}" target="_blank">${url}</a>`;
        const del = document.createElement('button');
        del.textContent = 'X';
        del.className = 'delete';
        del.onclick = () => deleteUrl(index);
        li.appendChild(del);
        urlList.appendChild(li);
      });
    }

    function addUrl() {
      const url = urlInput.value.trim();
      if (!url) return;
      const urls = JSON.parse(localStorage.getItem('urls') || '[]');
      urls.push(url);
      localStorage.setItem('urls', JSON.stringify(urls));
      urlInput.value = '';
      loadUrls();
    }

    function deleteUrl(index) {
      const urls = JSON.parse(localStorage.getItem('urls') || '[]');
      urls.splice(index, 1);
      localStorage.setItem('urls', JSON.stringify(urls));
      loadUrls();
    }

    function setBackground(event) {
      const file = event.target.files[0];
      if (!file) return;
      const reader = new FileReader();
      reader.onload = () => {
        document.body.style.backgroundImage = `url(${reader.result})`;
        localStorage.setItem('background', reader.result);
      };
      reader.readAsDataURL(file);
    }

    function loadBackground() {
      const bg = localStorage.getItem('background');
      if (bg) document.body.style.backgroundImage = `url(${bg})`;
    }

    function resetBackground() {
      localStorage.removeItem('background');
      document.body.style.backgroundImage = '';
    }

    loadUrls();
    loadBackground();
  </script>
</body>
</html>
