------------- CUSTOM COMMANDS HELP SECTION ------------

$ cmdhelp
  > displays this help section

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

$ procres
  > view last command exit code (0 = success, 1 = failure)

$ vin <file>
  > open file in vi with lines numbers

$ histcmd <expr>
  > searches <expr> in history and command archives (regexp extended)
  > pipe results to less for more flexibility

$ histsave
  > saves current history to a new file in command archives
  > clears current history

$ histprune
  > prunes (removes duplicate entries, sorts and formats) all unpruned files in the command archives

$ prevcmd
  > list 25 last shell commands

$ nscript <file>
  > creates a new bash script and edits it

$ findnme <directory> <depth> <name>
  > searches from starting point <directory>, <depth> directories depth for file name <name>

$ findrgx <directory> <depth> <expr>
  > searches from starting point <directory>, <depth> directories depth for paths matching <expr>

$ ftype <directory> <expr>
  > list files matching <expr> in target directory (regexp extended, no recursion) 

$ arbo <path> <expr>
  > displays pruned file system tree starting from <path> using less + color 
  > if wildcard pattern <expr> is present, shows only matching file names (shell wildcards only)

$ pkfind <expr>
  > list packages matching <expr> in apt repositories

$ pdetail <pkgname>
  > list details about single package

$ tab2space <path>
  > replaces all tabulations by the default indentation value (4 spaces) in file <path>

$ varenv <expr>
  > searches <expr> in environment variables

$ visudo
  > execute visudo with vim

$ showfs <device>
  > display filesystems informations for block device <device> (all if not specified)

$ showdv <device>
  > display details for disk/block device <device> (all if not specified)

$ showpt <device>
  > display partitioning details for disk/block device <device> (required)

-------------------------------------------------------
