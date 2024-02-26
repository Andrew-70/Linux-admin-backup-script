# Rsync Synchronization Script
## Features
- Root permission check for secure operation.
- Usage instructions for clarity and ease of use.
- Options for host-to-remote (A) and remote-to-host (B) synchronization.
- Support for rsync's `--delete` option to mirror source and destination directories.

## Prerequisites
- Root access on the system where the script is executed.
- Rsync installed on both source and destination systems.

## Usage
Before running the script, ensure you have root permissions. The script supports multiple flags:
1. Path to the source directory or file.
2. Destination path in the format `user@host:path`.
3. Synchronization direction (`A` for host to remote, `B` for remote to host).
4. Additional rsync options (optional), e.g., `d` for `--delete`.

**Example command:**

```bash
./script.sh /path/to/source/ user@192.168.1.x:/path/to/destination/ A d
Ensure to replace /path/to/source/, user@192.168.1.x:/path/to/destination/, and flags with your actual data.

Notes

Include a trailing slash / at the end of the source path if you intend to transfer files within the directory without transferring the directory itself.
For detailed rsync options, consult the rsync man page (man rsync).
