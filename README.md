# Transmission Daemon - Move File On Completion script

This completion script moves your completed downloads to separate directories based on name of the tracker it has been downloaded from

## To install

1. Copy all files to your file system, e.g.: `/etc/transmission-daemon/`

2. Create a file in the same directory with name `auth.conf`

```bash:auth.conf
export TR_AUTH=username:password
```

3. Run below command to set file permission. Make sure files are owned by the user executing the transmission-daemon.
```
$ chmod 0600 auth.conf
```

3. Edit file `on-completion-dirs.conf`

```
tracker-pattern-1:file-location-1
.
tracker-pattern-n:file-location-n
```

4. Edit your settings.json, enable on-completion scripts and add the completion script to property script-torrent-done-filename.

e.g.:

```json:settings.json
.
    "script-torrent-done-enabled": true,
    "script-torrent-done-filename": "/etc/transmission-daemon/on-completion.sh",
.
```

5. Reload configuration from `settings.json`

```
$ killall -HUP transmission-da
```

## Move already downloaded files to the correct location

1. Run `move-existing.sh` which will move all downloaded files according the rules you've set up during installation

## List file locations

1. Run `list-locations.sh` which will show all files, IDs, Locations and Tracker names


