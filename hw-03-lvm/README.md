# HW-03 LVM

Using [Vagrant stand](https://gitlab.com/otus_linux/stands-03-lvm) and add `lvm2`, `device-mapper`, `xfsdump` tools to provision section.

## HW Procces

1. Reduce `/` volume to 8Gb.
2. Add volume for `/var` with mirroring.
3. Add volume for `/home`.
4. Add volumes for `/home` snapshots.
5. Add auto mounting to `fstab`.
6. Recovery files from snapshot.

### Results of HW

```
[root@lvm vagrant]# lsblk
NAME                       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                          8:0    0   40G  0 disk
├─sda1                       8:1    0    1M  0 part
├─sda2                       8:2    0    1G  0 part /boot
└─sda3                       8:3    0   39G  0 part
  ├─VolGroup00-LogVol00    253:0    0    8G  0 lvm  /
  ├─VolGroup00-LogVol01    253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-LogVol_Home 253:2    0    2G  0 lvm  /home
sdb                          8:16   0   10G  0 disk
sdc                          8:32   0    2G  0 disk
├─vg_var-lv_var_rmeta_0    253:3    0    4M  0 lvm
│ └─vg_var-lv_var          253:7    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_0   253:4    0  952M  0 lvm
  └─vg_var-lv_var          253:7    0  952M  0 lvm  /var
sdd                          8:48   0    1G  0 disk
├─vg_var-lv_var_rmeta_1    253:5    0    4M  0 lvm
│ └─vg_var-lv_var          253:7    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_1   253:6    0  952M  0 lvm
  └─vg_var-lv_var          253:7    0  952M  0 lvm  /var
sde                          8:64   0    1G  0 disk
```

## Task with *

1. For experimenting with btrfs full recreating virtual machine with `vagrant destroy && vagrant up`.
2. Update kernel to `5.5.7-1.el7.elrepo.x86_64` for enable all btrfs features.
3. Create btrfs `sudo mkfs.btrfs /dev/sd{b,c,d,e} -L opt`.
4. Mount btrfs volume `mkdir /btrfs_volume && mount /dev/sdb /btrfs_volume/`.
5. Get ID of subvolume `btrfs subvolume list /btrfs_volume/opt/`.
6. Set default subvolume `btrfs subvolume set-default 259 /btrfs_volume/opt/`.
7. Mount btrfs subvolume to /opt witch caching option `mount -o space_cache=v2 /dev/sdb /opt`.
8. Create btrfs snapshot for opt `btrfs subvolume snapshot -r /opt/ /btrfs_volume/opt_snapshot`.

### Results of task with *

```
[root@lvm btrfs_volume]# btrfs subvolume show /opt
/opt
	Name: 			opt
	UUID: 			87fb57b1-2a3d-5048-9b5d-ca9f48b9c1fc
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		2020-03-05 03:14:12 +0000
	Subvolume ID: 		259
	Generation: 		13
	Gen at creation: 	10
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			-
	Snapshot(s):
				opt_snapshot
```

```
[root@lvm btrfs_volume]# btrfs subvolume show /btrfs_volume/opt_snapshot/
/btrfs_volume/opt_snapshot
	Name: 			opt_snapshot
	UUID: 			d93bbe21-9984-694d-a6fe-7219730d8aff
	Parent UUID: 		87fb57b1-2a3d-5048-9b5d-ca9f48b9c1fc
	Received UUID: 		-
	Creation time: 		2020-03-05 03:34:36 +0000
	Subvolume ID: 		260
	Generation: 		13
	Gen at creation: 	13
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			readonly
	Snapshot(s):
```
