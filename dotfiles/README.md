# Shell Requirements

## Linux

```bash
sudo apt update
sudo apt install vim git eza bat curl

curl -sS https://starship.rs/install.sh | sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p ~/.local/bin
cp -r ./~/.local/bin/* ~/.local/bin
chmod +x ~/.local/bin
```

`.local/bin` scripts partially taken from [Evan Hahn](https://evanhahn.com/scripts-i-wrote-that-i-use-all-the-time/).
