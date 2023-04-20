# Initial RAM disk for FreeBSD ARM64

This script generates an initial RAM disk for embedded FreeBSD ARM64 target.

It is a simplification of [mfsBSD](http://mfsbsd.vx.sk) project. Here we don't do any GPT, EFI or ISO-related work, because our goal is to create a disk image that could be bundled with kernel and dtb into a single U-boot FIT image/

## Building

Currently, a FreeBSD base system is required, because BSD-specific disk management tools are used:

```
sudo ./mkufsroot
```

Perhaps, we can [use ext2](https://pub.nethence.com/xen/guest-freebsd-ext2fs) and [e2tools](https://e2tools.github.io/) to make it Linux-compatible?

## Example

Make a FIT U-boot image with kernel, dts and mfsroot image created by this script:

```
sudo mkimage -f auto -A arm64 -O linux -T kernel -C none -e 0x10000000 -a 0x10000000 \
    -c "RK3328 FreeBSD firmware" -d ./kernel.bin \
    -b ./rk3328-rock64.dtb -i ./mfsroot kernel.itb
```

Boot `kernel.itb`:

```
dhcp
tftp $kernel_addr_r kernel.itb
bootm $kernel_addr_r
```

