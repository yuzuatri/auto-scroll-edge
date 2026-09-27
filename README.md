# Auto Scroll for Microsoft Edge

A small Manifest V3 extension that automatically scrolls the current page at a
configurable speed. Adapted from https://github.com/yuzuatri/auto-scroll.

## Install locally

1. Open `edge://extensions` in Microsoft Edge.
2. Turn on **Developer mode**.
3. Click **Load unpacked** and select this folder (the one containing `manifest.json`).
4. Refresh any pages that were open before installation.
5. Open a long webpage, then open **Auto Scroll** from Edge's Extensions menu.
6. Enter a speed and click **start**. Click **stop** to stop scrolling.

Speed is the number of pixels scrolled every 30 milliseconds; the default is 2.
Negative values scroll upward. As in the original extension, changing the speed
also starts scrolling. Scrolling continues when the popup closes, until stopped
or the page navigates/reloads.

Browser pages such as `edge://settings`, extension stores, and other protected
pages cannot be scrolled by this extension. Local files require **Allow access to
file URLs** in the extension's details. If buttons do nothing on a normal webpage,
refresh it and check that Edge has allowed the extension access to that site.

## Build the submission ZIP

Run from this directory in PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\package-edge.ps1
```

The package is written to `dist/auto-scroll-edge-1.0.zip`. It includes the manifest
at the archive root, the popup, runtime scripts, icons, and license. Development
files and Git history are excluded. No dependencies or compilation are needed.

## Publish

Register for the Microsoft Edge program in Partner Center, create an extension
submission, and upload the ZIP. Complete the store listing and privacy disclosures,
add the required store images, then submit for Microsoft's review.

- [Register as an Edge extension developer](https://learn.microsoft.com/en-us/microsoft-edge/extensions/publish/create-dev-account)
- [Publish an Edge extension](https://learn.microsoft.com/en-us/microsoft-edge/extensions/publish/publish-extension)

The extension itself does not collect, store, or transmit personal data. Its
content script runs on permitted pages solely to receive scroll commands and
scroll the page. There are no analytics, remote scripts, or network requests.

## Port notes and verification

The original `chrome.tabs` and `chrome.runtime` calls work in Edge and retain
their `chrome` namespace. The manifest already uses Manifest V3 and has no
Chrome Web Store update URL. This port updates the browser description and popup
title while preserving the original scrolling behavior and permissions.

Before submitting, load the extension in Edge and check start, stop, changing
speed, scrolling upward, closing/reopening the popup, and separate tabs. Source
and package checks do not replace this browser smoke test.

Licensed under the MIT License; see `LICENSE`.
