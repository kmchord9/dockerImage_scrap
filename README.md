# dockerImage_scrap

seleniumのライブラリにてchromeが動作する環境を作るdockerfileです。

google-chromeは構築した時のstableのバージョンがインストールされています
```
google-chrome --version
Google Chrome 87.0.4280.66
```

chromedriverはgoogle-chromeに対応する必要があるので
```
chromedriver --version
ChromeDriver 87.0.4280.20 (c99e81631faa0b2a448e658c0dbd8311fb04ddbd-refs/branch-heads/4280@{#355})
```

