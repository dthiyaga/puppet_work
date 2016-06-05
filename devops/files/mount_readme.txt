The three subdirectories here are for your convienience. You can add more
directories if you like, but you cannot alter any existing ones.

$mount: The mount name (/mnt/devops_X) may not be changed. Add a symlink
    elsewhere on the system if you want to access this slice via another name.
    Keeping that symlink in place is your responsibility.

$mount/public: This directory is world-writable and should not be used for any
    secure storage.

$mount/dba: This directory is readable and writable by the local 'dba' group.
    Ideal for database files.

$mount/root: This directory is only readable and writable by root.
