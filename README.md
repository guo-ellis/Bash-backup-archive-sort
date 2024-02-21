The setup.sh script is designed to perform three distinct tasks based on the first command-line argument provided by the user: backup, archive, and sortedcopy.

**Backup Task:**
When invoked with the argument backup, the script first checks for the presence of .txt files in the current directory.
If .txt files are found, it creates a backup directory, copies all .txt files into it, and creates a date.txt file within the backup directory, recording the current date and time of the backup.

**Archive Task:**
When invoked with the argument archive, the script requires an additional argument specifying the file format to be archived.
It then creates a compressed archive file (.tgz) containing all files with the specified format in the current directory.
The archive file is named with the current date appended to archive-, and the script displays the list of files archived.

**Sorted Copy Task:**
When invoked with the argument sortedcopy, the script requires two additional arguments: the source directory and the target directory.
It verifies the existence of the source directory and whether it is indeed a directory.
If the target directory already exists, it prompts the user for confirmation to overwrite it.
It then creates the target directory and copies files from the source directory into it, renaming each file with a prefix indicating its position in reverse alphabetical order.
Finally, it displays a success message after copying all files.
