-----------------------------------------------------------------
------------------ CUSTOM COMMANDS HELP SECTION -----------------
---------- THOSE COMMANDS DO NOT WORK WHEN USED WITH SUDO -------
-----------------------------------------------------------------

$ cmdhelp
  > displays this help section

----------------------------- FILES -----------------------------

$ content <path>
  > list files and directories with details

$ makedir <path1> <path2> ...
  > create directory hierarchies (more than 1 argument, verbose)

$ remsafe <path1> <path2> ...
  > safe recursive removal of files and directories (more than 1 argument, verbose)

$ copyall <source> <target>
  > safe recursive copy of files and directories (verbose)

$ moveall <source> <target>
  > safe moving of files and directories

$ fsize <file|directory> <file|directory> ...
  > prints total disk usage for files and directories (including inodes)

$ ftotal <file|directory> <file|directory> ...
  > prints total number of files for files and directories (recursive)

$ fsearch <directory> <depth> [-r] <name|expr>
  > searches file system from starting point <directory>, <depth> directories depth for files name <name>
  > if used with the -r option, searches for file names matching regexp expression <expr>
  > <expr> has to be double quoted to prevent shell expansion and yield proper results

$ fparse <directory> <depth> <expr>
  > searches file system from starting point <directory>, <depth> directories depth for all regular files
  > outputs every file line matching regexp expression <expr>
  > <expr> has to be double quoted to prevent shell expansion and yield proper results

$ ftype <directory> <expr>
  > list types of files matching regexp expression <expr> in target directory (no recursion)
  > <expr> has to be double quoted to prevent shell expansion and yield proper results

$ arbo <path> <expr>
  > displays pruned file system tree starting from <path> using less + color 
  > if shell wildcard pattern <expr> is present, displays only matching files names

----------------------- PROCESSES -------------------------------

$ procres
  > view last command exit code (0 = success, 1 = failure)

$ myps
  > prints all logged in user's processes

------------------------- SHELL ---------------------------------

$ varenv <expr>
  > searches <expr> in environment variables

----------------------- HISTORY ---------------------------------

$ prevcmd
  > list 25 last shell commands

$ histcmd <expr>
  > searches commands matching regexp expression <expr> in history and command archives
  > <expr> has to be double quoted to prevent shell expansion and yield proper results
  > you can also pipe results to less for more comfort

$ histsave
  > saves current history to a new file in command archives
  > clears current history and restarts shell

$ histprune
  > prunes (removes duplicate entries, sorts and formats) all unpruned files in command archives

---------------------- UTILITIES --------------------------------

$ vin <file>
  > open file in vi with lines numbers

$ visudo
  > execute visudo with vim

$ nscript <file>
  > creates a new bash script and edits it

$ tab2space <path>
  > replaces all tabulations by the default indentation value (4 spaces) in file <path>

---------------------- APT/DPKG ---------------------------------

$ aptsrc
  > list all configured sources

$ pkfind <expr>
  > list packages matching regular expression <expr> in apt repositories
  > <expr> has to be double quoted to prevent shell expansion and yield proper results

$ pdetail <pkgname>
  > list details about package <pkgname>

$ pstatus <expr>
  > query dpkg database for installation status of packages matching shell wildcards pattern <expr>

--------------------- FILE SYSTEM -------------------------------

$ blockdev <disk>
  > display informations and partitions list for disk <disk> (all if not specified)

$ parttable <disk>
  > display partition table for disk <disk> (required)

$ partdetail <partition>
  > display partition details for partition <partition> (required)

-----------------------------------------------------------------