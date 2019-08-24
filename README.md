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

## Util
Random utilities

### `create_random_files.sh`
Creates random files. Useful for testing e.g., user quotas, disk I/O, or HDFS clusters.

By default, writes to `~/testfiles`. Adjust the bash loop to control the number of files. Not parallelized - could do that with `&` or `awk` or something like that.

### `package_installed.sh`
Checks if a pacakge is installed.

Exports a function, used in the rest of these scripts. Feel free to just `grep` on `apt`, `pacman`, `yum`, ...

### `logging.sh`
Exports log functions as `log`, `logErr`, `logWarn`

### `mount_drive.sh`
Mounts an SMB drive using CIFS defaults - I don't add mount drives into `/etc/fstab`

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

## `.zshrc`
Same story for `zsh`

## `.oh-my-zsh`
Customized `robbyrussell` theme for [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with the current machine's name.

The theme is otherwise identical; however, if you don't use a custom name, it requires a `git add` and `git commit` before using `upgrade_oh_my_zsh`.

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
 
