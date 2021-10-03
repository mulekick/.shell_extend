------------ CUSTOM COMMANDS HELP SECTION -----------

$ cmdhelp
  > displays this help section

------------ FILES ------------

$ content <path>
  > list files and directories with details

$ makedir <path1> <path2> ...
  > create directory hierarchies (more than 1 argument, verbose)

$ remsafe <path1> <path2> ...
  > safe recursive removal of files and directories (more than 1 argument, verbose)

$ copyall <source> <target>
  > safe recursive copy of files and directories (verbose)

$ moveall <source> <target>
  > safe moving of files/directories

$ fsearch <directory> <depth> [-r] <name|expr>
  > searches file system from starting point <directory>, <depth> directories depth for files name <name>
  > if used with the -r option, searches for file names matching regexp expression <expr>

$ fparse <directory> <depth> <expr>
  > searches file system from starting point <directory>, <depth> directories depth for all regular files
  > outputs every file line matching regexp expression <expr>

$ ftype <directory> <expr>
  > list types of files matching regexp expression <expr> in target directory (no recursion)

$ arbo <path> <expr>
  > displays pruned file system tree starting from <path> using less + color 
  > if shell wildcard pattern <expr> is present, shows only matching files names

------------ PROCESSES ------------

$ procres
  > view last command exit code (0 = success, 1 = failure)

------------ SHELL ------------

$ varenv <expr>
  > searches <expr> in environment variables

------------ HISTORY ------------

$ prevcmd
  > list 25 last shell commands

$ histcmd <expr>
  > searches commands matching regexp expression <expr> in history and command archives
  > pipe results to less for more flexibility

$ histsave
  > saves current history to a new file in command archives
  > clears current history

$ histprune
  > prunes (removes duplicate entries, sorts and formats) all unpruned files in the command archives

------------ UTILITIES ------------

$ vin <file>
  > open file in vi with lines numbers

$ nscript <file>
  > creates a new bash script and edits it

$ tab2space <path>
  > replaces all tabulations by the default indentation value (4 spaces) in file <path>

$ visudo
  > execute visudo with vim

------------ APT/DPKG ------------

$ pkfind <expr>
  > list packages matching regular expression <expr> in apt repositories

$ pdetail <pkgname>
  > list details about package <pkgname>

$ pstatus <expr>
  > query dpkg database for installation status of packages matching shell wildcards pattern <expr>

$ aptsrc
  > list all configured sources

------------ FILE SYSTEM ------------

$ showfs <device>
  > display filesystems informations for block device <device> (all if not specified)

$ showdv <device>
  > display details for disk/block device <device> (all if not specified)

$ showpt <device>
  > display partitioning details for disk/block device <device> (required)

-----------------------------------------------------
