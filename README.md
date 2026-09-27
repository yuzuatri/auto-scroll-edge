# Simple Auto Scroll

A simple Microsoft Edge extension that scrolls webpages at your chosen speed.

## Use

1. Open the extension on a webpage.
2. Choose a speed, then click **Start**.
3. Click **Stop** to stop scrolling.

Opening the popup or editing the speed while stopped won't start scrolling.
While scrolling, speed changes apply immediately. Closing the popup keeps
scrolling; reloading or leaving the page stops it.

Speed is measured in pixels per 30 milliseconds. Leave it blank for the default
speed of 2, or use a negative value to scroll upward.

## Install locally

Open `edge://extensions`, enable **Developer mode**, click **Load unpacked**, and
select this folder. Refresh any webpages already open before using the extension.
Edge settings pages and other protected pages aren't supported.

## Package for publishing

Run in PowerShell from this folder:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\package-edge.ps1
```

Upload `dist/auto-scroll-edge-1.0.1.zip` to Microsoft Edge Add-ons through Partner Center.

## Privacy

No personal data collection, analytics, or network requests.

## License

MIT. See `LICENSE`.
