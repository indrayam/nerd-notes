# Mounting block storage devices

When you create additional EBS volumes at the time of instance launch (or attach them later), they are not automatically mounted to the file system. Only the root volume is automatically mounted. You’ll need to manually mount the additional EBS volumes. 

Here’s how you can verify and mount the new EBS volumes:

## Step 1: Verify Attached Volumes
Run the following command to list all block devices attached to your instance. Verify if the new volumes are attached. In AWS, chances are they are not if you just added it during the creation of the instance

```bash
# This command displays all the attached volumes and their mount points.
# Look for the unmounted EBS volumes (e.g., /dev/xvdb, /dev/xvdc).
lsblk
```

## Step 2: Check if the Volumes are Formatted
Run the following command to check if the volumes are already formatted:

```bash
# Replace /dev/xvdb with the device names of your volumes.
# If the output shows data, the volumes are not formatted yet.
# If they’re already formatted, you can skip Step 3.

sudo file -s /dev/xvdb
```

## Step 3: Format the Volumes (if needed)

Format the unformatted volumes with a file system (e.g., `ext4`):

```bash
sudo mkfs.ext4 /dev/xvdb

```

## Step 4: Create Mount Points

```bash
sudo mkdir /mnt/volume1
```

## Step 5: Mount the Volumes

```bash
sudo mount /dev/xvdb /mnt/volume1
```

## Step 6: Verify the Mount Points

```bash
df -kH
```

## Step 7: Make the Mount Permanent

1. To ensure the volumes are mounted after a reboot, edit the `/etc/fstab` file:

```bash
sudo vim /etc/fstab
```

2. Add entries for the new volumes:

```bash
# Append it to the end of the file (as shown below)
/dev/xvdb /mnt/volume1 ext4 defaults 0 0
```

3. Save and exit

4. Test the `fstab` file to ensure no errors:

```bash
sudo mount -a
```





