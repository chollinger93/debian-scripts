# Debian-scripts
Just a collection of scripts I use on my `Debian` servers. Technically run some on `Arch` and `CentOS`, but whot's counting?

## Structure

```
|-- backups
|   |-- aws_backup.sh
|   |-- backup.sh
|-- dotfiles
|-- media
|   |-- mp3_id3.sh
|   |-- youtube.sh
|-- util
    |-- create_random_files.sh
    |-- logging.sh
    |-- mount_drive.sh
    |-- package_installed.sh
```

## Backups
Scripts to backup things.

### `aws_backup.sh`
Backs up a server to Amazon AWS S3 using duplicity. Needs an AWS account w/ billing enabled, a valid gnupgp key, and duplicity installed.

Needs to be run as `root` and requires several variables to be set in the script.

### `backup.sh`
Backs up a GNU/Linux machine over smb, e.g. to a home server.

Similar to `aws_backup.sh`, only locally. Requires similar adjustments and software.

### `borg_backup.sh`
Customized script of the `borg` [docs](https://borgbackup.readthedocs.io/en/stable/quickstart.html#automating-backups) to backup a machine. This is an alternative to `duplicity` I use on some machines.

Setup:
```
sudo apt-get install borgbackup 
borg init user@server:22/path/to/backup -e=repokey
borg key export user@server:22/path/to/backup ~/borg.key
chmod 400 ~/borg.key
```

Run as `sudo`, as it's backup up pretty much the entire system.

## Util
Random utilities

### `create_random_files.sh`
Creates random files. Useful for testing e.g., user quotas, disk I/O, or HDFS clusters.

By default, writes to `~/testfiles`. Adjust the bash loop to control the number of files. Not parallelized - could do that with `&` or `awk` or something like that.

### `create_test_csv.sh`

Creates a testing CSV, e.g. for `pyspark`. Simple `bash` loop again.

Will ask you for a schema, either as `number` or `string` during run.

### `package_installed.sh`
Checks if a pacakge is installed.

Exports a function, used in the rest of these scripts. Feel free to just `grep` on `apt`, `pacman`, `yum`, ...

### `logging.sh`
Exports log functions as `log`, `logErr`, `logWarn`

Needs to be sourced.

### `mount_drive.sh`
Mounts an SMB drive using CIFS defaults - I don't add mount drives into `/etc/fstab`

### `venv.sh`
Attempts to determine whether a Python 3 virtual environment exist and creates one if not.

Needs to be sourced.

## Media
Media helpers

### `youtube.sh`
Downloads a video from YouTube and stores it as mp3.

Arguments: `youtube.sh URL ARTIST SONG`, structures files as such and sets id3 tags.

Because YT is being weird, I've added a 4th argument that expects a path to a valid MP3 file. That one only sets the ID3 tags and moves it accordingly.

Sample (I actually own the physical CD, this is just for demonstration)  -
```
scp hildebrandslied.mp3 christian@bigiron:/home/christian
./youtube.sh "https://www.youtube.com/watch?v=... "Hildebrandslied "/home/christian/hildebrandslied.mp3"
```

## Dotfiles
Various configurations

### `.bashrc`
My `.bashrc`. I use zsh, but the appended lines are almost identical.

This one wants to live in our `$HOME` directory. I guess you knew that.

### `.zshrc`
Same story for `zsh`

### `.oh-my-zsh`
Customized `robbyrussell` theme for [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with the current machine's name.

The theme is otherwise identical; however, if you don't use a custom name, it requires a `git add` and `git commit` before using `upgrade_oh_my_zsh`.

### `.config`
This directory contains config files for a lot of tools (e.g. `sublime`, `Thunar`, `GIMP`, `Nextcloud`, `VirtualBox`, `plasma`, `pulse`, `gtk`, `chromium`, `i3`), but in this repo, this is used for `neofetch`; it adds a timezone config for the US (EST), Central Europe, and India.

### `.jupyter`
A `custom.css` to use different fonts in `jupyter notebooks`. I use [Fira Code](https://github.com/tonsky/FiraCode), which you can get by running `sudo apt install fonts-firacode`.

### `Code`
Font settings for Visual Studio Code

### `.vimrc`
Some `vim` settings for line numbers, highlighting tabs

## Installation
```
git clone (url)
cd debian-scripts
chmod +x *.sh
```

For `.bashrc`:
```
cp ~/.bashrc ~/.bashrc.bkp
cp debian-scripts/dotfiles/.bashrc ~
source ~/.bashrc
```

## Usage
Read the code, set the +x flag, and execute

## Other
Proudly written with vim

## License
[MIT](./LICENSE.md)
 
