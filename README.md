# Rusty's Mini Golf

## Legend

* 🖱️ - Step is performed via GUI
* ⌨️ - Step is performed via command line, using apps such as _PowerShell_ (Windows) or _Terminal_ (macOS)

## Requirements

### Windows

#### Rust & Dependencies

* 🖱️ Install _"Desktop development with C++"_ via [_Visual Studio Installer_](https://visualstudio.microsoft.com/downloads/)
* 🖱️+⌨️ Install `rust` & `cargo` using the [official instructions](https://www.rust-lang.org/tools/install)
* 🖱️+⌨️ Install `wasm-pack` using the [quick start guide](https://rustwasm.github.io/wasm-pack/book/quickstart.html)
* ⌨️ Set PowerShell execution policy by running `Set-ExecutionPolicy Unrestricted`

#### Local Web Server

* 🖱️ Install _Node.js_ (preferably LTS) from the [official website](https://nodejs.org/en/)
* ⌨️ Install the `http-server` package globally by running `npm install -g http-server`

---

### macOS

#### Rust & Dependencies

* ⌨️ Install _Homebrew_ using the [official instructions](https://brew.sh/)
* ⌨️ Install `rustup-init` via _Homebrew_ by running `brew install rustup-init`
* ⌨️ Install `wasm-pack` by running `cargo install wasm-pack`

#### Local Web Server

* ⌨️ Install _Node.js_ via _Homebrew_ by running `brew install node`
* ⌨️ Install the `http-server` package globally by running `npm install -g http-server`

## Running the Game Locally

1. ⌨️ Build the application using the `Build.ps1` PowerShell script from the command line
2. ⌨️ From the root directory of the repository, run `http-server`
3. ⌨️ Navigate to `http://localhost:8080/web/index.html` in your web browser
4. ⌨️ When testing new features, refresh the page using Ctrl + F5 to clear the cache.
