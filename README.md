# tiny-vim

## What is this?

`tiny-vim` provides a way to get a minimal, static `vim` binary in environments where a text editor is not installed and you don't have the permissions (e.g., root) to install one. This is common in restricted environments like minimal Docker containers or locked-down systems.

The goal is to provide a quick and easy way to get a functional `vim` for quick edits without needing system-wide installation.

The provided `vim` binaries are built with the `tiny` feature set and compressed with UPX to achieve a final size of under 1 MB. This ensures a fast download and minimal footprint.

## How to use it

The script is designed to be sourced directly from this repository into your current shell session. It will download a pre-compiled, statically linked `vim` binary suitable for your system's architecture, make it executable, and create a temporary `vim` alias for you to use.

You can use either `curl` or `wget` to run the script.

### Using `curl`

```shell
source <(curl -sL https://raw.githubusercontent.com/T3rm1/tiny-vim/master/vim.sh)
```

### Using `wget`

```shell
source <(wget -qO- https://raw.githubusercontent.com/T3rm1/tiny-vim/master/vim.sh)
```

After running one of the commands above, `vim` will be available in your current shell session.

### Important Notes

*   The `vim` alias is **temporary** and only exists in the shell session where you sourced the script.
*   The script will download the `vim` binary to a temporary file that will be cleaned up when your system reboots.
*   If you want to make the alias permanent, you can add it to your shell's startup file (e.g., `~/.bashrc`, `~/.zshrc`), but be aware of the temporary nature of the binary's location. The script will output an example command to do this.
