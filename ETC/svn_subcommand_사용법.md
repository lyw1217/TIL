# SVN 명령어(subcommand) 사용법 (리눅스, CLI 환경)

## 사용법

    usage: svn <subcommand> [options] [args]

쉘에서, 목적에 맞는 `subcommand`를 입력하고 `options`와 `args`가 필요하다면 이어서 입력한다.

(`options`, `args` 는 생략 가능하다.)

## subcommand 종류 및 options

[여기](https://svnbook.red-bean.com/en/1.7/index.html)에서 SVN이 지원하는 모든 subcommand 및 options를 확인할 수 있다.

이 문서에서는 자주 사용하는 일부 subcommand만 작성하였다.

### svn add

svn add — Add files, directories, or symbolic links.

Synopsis
svn add PATH...

Description
Schedule files, directories, or symbolic links in your working copy for addition to the repository. They will be uploaded and added to the repository on your next commit. If you add something and change your mind before committing, you can unschedule the addition using svn revert.

Options
--auto-props
--depth ARG
--force
--no-auto-props
--no-ignore
--parents
--quiet (-q)
--targets FILENAME

### svn blame (praise, annotate, ann)

svn blame (praise, annotate, ann) — Show author and revision information inline for the specified files or URLs.

Synopsis
svn blame TARGET[@REV]...

Description
Show author and revision information inline for the specified files or URLs. Each line of text is annotated at the beginning with the author (username) and the revision number for the last change to that line.

Options
--extensions (-x) ARG
--force
--incremental
--revision (-r) REV
--use-merge-history (-g)
--verbose (-v)
--xml

### svn cat

svn cat — Output the contents of the specified files or URLs.

Synopsis
svn cat TARGET[@REV]...

Description
Output the contents of the specified files or URLs. For listing the contents of directories, see svn list later in this chapter.

Options
--revision (-r) REV

### svn changelist (cl)

svn changelist (cl) — Associate (or deassociate) local paths with a changelist.

Synopsis
changelist CLNAME TARGET...

changelist --remove TARGET...

Description
Used for dividing files in a working copy into a changelist (logical named grouping) in order to allow users to easily work on multiple file collections within a single working copy.

Options
--changelist (--cl) ARG
--depth ARG
--quiet (-q)
--recursive (-R)
--remove
--targets FILENAME

## svn checkout (co)

svn checkout (co) — Check out a working copy from a repository.

Synopsis
svn checkout URL[@REV]... [PATH]

Description
Check out a working copy from a repository. If PATH is omitted, the basename of the URL will be used as the destination. If multiple URLs are given, each will be checked out into a subdirectory of PATH, with the name of the subdirectory being the basename of the URL.

Options
--depth ARG
--force
--ignore-externals
--quiet (-q)
--revision (-r) REV

## svn cleanup

svn cleanup — Recursively clean up the working copy

Synopsis
svn cleanup [PATH...]

Description
Recursively clean up the working copy, removing working copy locks and resuming unfinished operations. If you ever get a working copy locked error, run this command to remove stale locks and get your working copy into a usable state again.

If, for some reason, an svn update fails due to a problem running an external diff program (e.g., user input or network failure), pass the --diff3-cmd to allow the cleanup process to complete any required merging using your external diff program. You can also specify any configuration directory with the --config-dir option, but you should need these options extremely infrequently.

Options
--diff3-cmd CMD

## svn commit (ci)

svn commit (ci) — Send changes from your working copy to the repository.

Synopsis
svn commit [PATH...]

Description
Send changes from your working copy to the repository. If you do not supply a log message with your commit by using either the --file (-F) or --message (-m) option, svn will launch your editor for you to compose a commit message. See the editor-cmd list entry in the section called “Config”.

svn commit will send any lock tokens that it finds and will release locks on all PATHs committed (recursively) unless --no-unlock is passed.

[Tip]
If you begin a commit and Subversion launches your editor to compose the commit message, you can still abort without committing your changes. If you want to cancel your commit, just quit your editor without saving your commit message and Subversion will prompt you to either abort the commit, continue with no message, or edit the message again.

Options
--changelist (--cl) ARG
--depth ARG
--editor-cmd CMD
--encoding ENC
--file (-F) FILENAME
--force-log
--keep-changelists
--message (-m) MESSAGE
--no-unlock
--quiet (-q)
--targets FILENAME
--with-revprop ARG

## svn copy (cp)

svn copy (cp) — Copy a file or directory in a working copy or in the repository.

Synopsis
svn copy SRC[@REV]... DST

Description
Copy one or more files in a working copy or in the repository. SRC and DST can each be either a working copy (WC) path or URL. When copying multiple sources, add the copies as immediate children of DST (which, of course, must be a directory).

WC → WC
Copy and schedule an item for addition (with history).

WC → URL
Immediately commit a copy of WC to URL.

URL → WC
Check out URL into WC and schedule it for addition.

URL → URL
Complete server-side copy. This is usually used to branch and tag.

If no peg revision (i.e., @REV) is supplied, by default the BASE revision will be used for files copied from the working copy, while the HEAD revision will be used for files copied from a URL.

[Note]
You can only copy files within a single repository. Subversion does not support cross-repository copying.

Options
--editor-cmd CMD
--encoding ENC
--file (-F) FILENAME
--force-log
--ignore-externals
--message (-m) MESSAGE
--parents
--quiet (-q)
--revision (-r) REV
--with-revprop ARG

## svn delete (del, remove, rm)

svn delete (del, remove, rm) — Delete an item from a working copy or the repository.

Synopsis
svn delete PATH...

svn delete URL...

Description
Items specified by PATH are scheduled for deletion upon the next commit. Files (and directories that have not been committed) are immediately removed from the working copy unless the --keep-local option is given. The command will not remove any unversioned or modified items; use the --force option to override this behavior.

Items specified by URL are deleted from the repository via an immediate commit. Multiple URLs are committed atomically.

Options
--editor-cmd CMD
--encoding ENC
--file (-F) FILENAME
--force
--force-log
--keep-local
--message (-m) MESSAGE
--quiet (-q)
--targets FILENAME
--with-revprop ARG

## svn diff (di)

svn diff (di) — This displays the differences between two revisions or paths.

Synopsis
diff [-c M | -r N[:M]] [TARGET[@REV]...]

diff [-r N[:M]] --old=OLD-TGT[@OLDREV] [--new=NEW-TGT[@NEWREV]] [PATH...]

diff OLD-URL[@OLDREV] NEW-URL[@NEWREV]

Description
Display the differences between two paths. You can use svn diff in the following ways:

Use just svn diff to display local modifications in a working copy.

Display the changes made to TARGETs as they are seen in REV between two revisions. TARGETs may be all working copy paths or all URLs. If TARGETs are working copy paths, N defaults to BASE and M to the working copy; if TARGETs are URLs, N must be specified and M defaults to HEAD. The -c M option is equivalent to -r N:M where N = M-1. Using -c -M does the reverse: -r M:N where N = M-1.

Display the differences between OLD-TGT as it was seen in OLDREV and NEW-TGT as it was seen in NEWREV. PATHs, if given, are relative to OLD-TGT and NEW-TGT and restrict the output to differences for those paths. OLD-TGT and NEW-TGT may be working copy paths or URL[@REV]. NEW-TGT defaults to OLD-TGT if not specified. -r N makes OLDREV default to N; -r N:M makes OLDREV default to N and NEWREV default to M.

svn diff OLD-URL[@OLDREV] NEW-URL[@NEWREV] is shorthand for svn diff --old=OLD-URL[@OLDREV] --new=NEW-URL[@NEWREV].

svn diff -r N:M URL is shorthand for svn diff -r N:M --old=URL --new=URL.

svn diff [-r N[:M]] URL1[@N] URL2[@M] is shorthand for svn diff [-r N[:M]] --old=URL1 --new=URL2.

If TARGET is a URL, then revs N and M can be given either via the --revision (-r) option or by using the “@” notation as described earlier.

If TARGET is a working copy path, the default behavior (when no --revision (-r) option is provided) is to display the differences between the base and working copies of TARGET. If a --revision (-r) option is specified in this scenario, though, it means:

--revision N:M
The server compares TARGET@N and TARGET@M.

--revision N
The client compares TARGET@N against the working copy.

If the alternate syntax is used, the server compares URL1 and URL2 at revisions N and M, respectively. If either N or M is omitted, a value of HEAD is assumed.

By default, svn diff ignores the ancestry of files and merely compares the contents of the two files being compared. If you use --notice-ancestry, the ancestry of the paths in question will be taken into consideration when comparing revisions (i.e., if you run svn diff on two files with identical contents but different ancestry, you will see the entire contents of the file as having been removed and added again).

Options
--change (-c) ARG
--changelist (--cl) ARG
--depth ARG
--diff-cmd CMD
--extensions (-x) ARG
--force
--git
--internal-diff
--new ARG
--no-diff-deleted
--notice-ancestry
--old ARG
--revision (-r) REV
--show-copies-as-adds
--summarize
--xml

## svn export

svn export — Export a clean directory tree.

Synopsis
svn export [-r REV] URL[@PEGREV] [PATH]

svn export [-r REV] PATH1[@PEGREV] [PATH2]

Description
The first form exports a clean directory tree from the repository specified by URL—at revision REV if it is given; otherwise, at HEAD, into PATH. If PATH is omitted, the last component of the URL is used for the local directory name.

The second form exports a clean directory tree from the working copy specified by PATH1 into PATH2. All local changes will be preserved, but files not under version control will not be copied.

Options
--depth ARG
--force
--ignore-externals
--ignore-keywords
--native-eol ARG
--quiet (-q)
--revision (-r) REV

## svn import

svn import — Commit an unversioned file or tree into the repository.

Synopsis
svn import [PATH] URL

Description
Recursively commit a copy of PATH to URL. If PATH is omitted, “.” is assumed. Parent directories are created in the repository as necessary. Unversionable items such as device files and pipes are ignored even if --force is specified.

Options
--auto-props
--depth ARG
--editor-cmd CMD
--encoding ENC
--file (-F) FILENAME
--force
--force-log
--message (-m) MESSAGE
--no-auto-props
--no-ignore
--quiet (-q)
--with-revprop ARG

## svn info

svn info — Display information about a local or remote item.

Synopsis
svn info [TARGET[@REV]...]

Description
Print information about the working copy paths or URLs specified. The information displayed for each path may include (as pertinent to the object at that path):

information about the repository in which the object is versioned

the most recent commit made to the specified version of the object

any user-level locks held on the object

local scheduling information (added, deleted, copied, etc.)

local conflict information

Options
--changelist (--cl) ARG
--depth ARG
--incremental
--recursive (-R)
--revision (-r) REV
--targets FILENAME
--xml

## svn list (ls)

svn list (ls) — List directory entries in the repository.

Synopsis
svn list [TARGET[@REV]...]

Description
List each TARGET file and the contents of each TARGET directory as they exist in the repository. If TARGET is a working copy path, the corresponding repository URL will be used.

The default TARGET is “.”, meaning the repository URL of the current working copy directory.

With --verbose (-v), svn list shows the following fields for each item:

Revision number of the last commit

Author of the last commit

If locked, the letter “O” (see the preceding section on svn info for details).

Size (in bytes)

Date and time of the last commit

With --xml, output is in XML format (with a header and an enclosing document element unless --incremental is also specified). All of the information is present; the --verbose (-v) option is not accepted.

Options
--depth ARG
--incremental
--recursive (-R)
--revision (-r) REV
--verbose (-v)
--xml

## svn log

svn log — Display commit log messages.

Synopsis
svn log [PATH]

svn log URL[@REV] [PATH...]

Description
Shows log messages from the repository. If no arguments are supplied, svn log shows the log messages for all files and directories inside (and including) the current working directory of your working copy. You can refine the results by specifying a path, one or more revisions, or any combination of the two. The default revision range for a local path is BASE:1.

If you specify a URL alone, it prints log messages for everything the URL contains. If you add paths past the URL, only messages for those paths under that URL will be printed. The default revision range for a URL is HEAD:1.

With --verbose (-v), svn log will also print all affected paths with each log message. With --quiet (-q), svn log will not print the log message body itself, this is compatible with --verbose (-v).

Each log message is printed just once, even if more than one of the affected paths for that revision were explicitly requested. Logs follow copy history by default. Use --stop-on-copy to disable this behavior, which can be useful for determining branch points.

Options
--change (-c) ARG
--depth ARG
--diff
--diff-cmd CMD
--extensions (-x) ARG
--incremental
--internal-diff
--limit (-l) NUM
--quiet (-q)
--revision (-r) REV
--stop-on-copy
--targets FILENAME
--use-merge-history (-g)
--verbose (-v)
--with-all-revprops
--with-no-revprops
--with-revprop ARG
--xml

## svn merge

svn merge — Apply the differences between two sources to a working copy path.

Synopsis
svn merge [-c M[,N...] | -r N:M ...] SOURCE[@REV] [TARGET_WCPATH]

svn merge --reintegrate SOURCE[@REV] [TARGET_WCPATH]

svn merge SOURCE1[@N] SOURCE2[@M] [TARGET_WCPATH]

Description
In all three forms TARGET_WCPATH is the working copy path that will receive the differences. If TARGET_WCPATH is omitted, the changes are applied to the current working directory, unless the sources have identical basenames that match a file within the current working directory. In this case, the differences will be applied to that file.

In the first two forms, SOURCE can be either a URL or a working copy path (in which case its corresponding URL is used). If the peg revision REV is not specified, then HEAD is assumed. In the third form the same rules apply for SOURCE1, SOURCE2, M, and N with the only difference being that if either source is a working copy path, then the peg revisions must be explicitly stated.

Sync and Cherrypick Merges

The first form, when used without either the -c or -r options, is called a “sync” merge and -r 1:REV is implied. This variant is used to merge all eligible changes to a branch from its immediate ancestor branch, see the section called “Keeping a Branch in Sync”.

When the first form is used with the -c or -r options, this is called a “cherrypick” merge and is used to merge an explicitly defined set of changes from one branch to another, see the section called “Cherrypicking”

[Tip]
Multiple -c and/or -r instances may be specified, and mixing of forward and reverse ranges is allowed— the ranges are internally compacted to their minimum representation before merging begins (which may result in a no-op merge or conflicts that cause the merge to stop before merging all of the requested revisions).

In both variants of the first form, SOURCE in revision REV is compared as it existed between revisions N and M for each revision range provided.

Reintegrate Merges

The second form is called a “reintegrate merge” and is used to bring changes from a feature branch (SOURCE) back into the feature branch's immediate ancestor branch (TARGET_WCPATH).

[Tip]
Reintegrate merges support only this specialized use case and as such have a number of special requirements and limitations that the other two merge forms do not posses. See the section called “Keeping a Branch in Sync”, the section called “Reintegrating a Branch”, the section called “Keeping a Reintegrated Branch Alive”, and the section called “Feature Branches”.

2-URL Merges

In the third form, called a “2-URL Merge”, the difference between SOURCE1 at revision N and SOURCE2 at revision M is generated and applied to TARGET_WCPATH. The revisions default to HEAD if omitted.

If Merge Tracking is active, then Subversion will internally track metadata (i.e. the svn:mergeinfo property) about merge operations when the two merge sources are ancestrally related—if the first source is an ancestor of the second or vice versa—this is guaranteed to be the case when using the first two forms. Subversion will also take preexisting merge metadata on the working copy target into account when determining what revisions to merge and in an effort to avoid repeat merges and needless conflicts it may only merge a subset of the requested ranges.

[Tip]
Merge Tracking can be disabled by using the --ignore-ancestry option.

Unlike svn diff, the merge command takes the ancestry of a file into consideration when performing a merge operation. This is very important when you're merging changes from one branch into another and you've renamed a file on one branch but not the other.

Options
--accept ACTION
--allow-mixed-revisions
--change (-c) ARG
--depth ARG
--diff3-cmd CMD
--dry-run
--extensions (-x) ARG
--force
--ignore-ancestry
--quiet (-q)
--record-only
--reintegrate
--revision (-r) REV

## svn mergeinfo

svn mergeinfo — Query merge-related information. See the section called “Mergeinfo and Previews” for details.

Synopsis
svn mergeinfo SOURCE_URL[@REV] [TARGET[@REV]]

Description
Query information related to merges (or potential merges) between SOURCE-URL and TARGET. If the --show-revs option is not provided, display revisions which have been merged from SOURCE-URL to TARGET. Otherwise, display either merged or eligible revisions as specified by the --show-revs option.

Options
--depth ARG
--recursive (-R)
--revision (-r) REV
--show-revs ARG

## svn mkdir

svn mkdir — Create a new directory under version control.

Synopsis
svn mkdir PATH...

svn mkdir URL...

Description
Create a directory with a name given by the final component of the PATH or URL. A directory specified by a working copy PATH is scheduled for addition in the working copy. A directory specified by a URL is created in the repository via an immediate commit. Multiple directory URLs are committed atomically. In both cases, all the intermediate directories must already exist unless the --parents option is used.

Options
--editor-cmd CMD
--encoding ENC
--file (-F) FILENAME
--force-log
--message (-m) MESSAGE
--parents
--quiet (-q)
--with-revprop ARG

## svn move (mv)

svn move (mv) — Move a file or directory.

Synopsis
svn move SRC... DST

Description
This command moves files or directories in your working copy or in the repository.

[Tip]
This command is equivalent to an svn copy followed by svn delete.

When moving multiple sources, they will be added as children of DST, which must be a directory.

[Note]
Subversion does not support moving between working copies and URLs. In addition, you can only move files within a single repository—Subversion does not support cross-repository moving. Subversion supports the following types of moves within a single repository:

WC → WC
Move and schedule a file or directory for addition (with history).

URL → URL
Complete server-side rename.

Options
--editor-cmd CMD
--encoding ENC
--file (-F) FILENAME
--force
--force-log
--message (-m) MESSAGE
--parents
--quiet (-q)
--revision (-r) REV
--with-revprop ARG

## svn relocate

svn relocate — Relocate the working copy to point to a different repository root URL.

Synopsis
svn relocate FROM-PREFIX TO-PREFIX [PATH...]

svn relocate TO-URL [PATH]

Description
Sometimes an administrator might change the location (or apparent location, from the client's perspective) of a repository. The content of the repository doesn't change, but the repository's root URL does. The hostname may change because the repository is now being served from a different computer. Or, perhaps the URL scheme changes because the repository is now being served via SSL (using https://) instead of over plain HTTP. There are many different reasons for these types of repository relocations. But ideally, a “change of address” for a repository shouldn't suddently cause all the working copies which point to that repository to become forever unusable. And fortunately, that's not the case. Rather than force users to check out a new working copy when a repository is relocated, Subversion provides the svn relocate command, which “rewrites” the working copy's administrative metadata to refer to the new repository location.

The first svn relocate syntax allows you to update one or more working copies by what essentially amounts to a find-and-replace within the repository root URLs recorded in those working copies. Subversion will replace the initial substring FROM-PREFIX with the string TO-PREFIX in those URLs. These initial URL substrings can be as long or as short as is necessary to differentiate between them. Obviously, to use this syntax form, you need to know both the current root URL of the repository to which the working copy is pointing, and the new URL of that repository. (You can use svn info to determine the former.)

The second syntax does not require that you know the current repository root URL with which the working copy is associated at all—only the new repository URL (TO-URL) to which it should be pointing. In this syntax form, only one working copy may be relocated at a time.

[Warning]
Users often get confused about the difference between svn switch and svn relocate. Here's the rule of thumb:

If the working copy needs to reflect a new directory within the repository, use svn switch.

If the working copy still reflects the same repository directory, but the location of the repository itself has changed, use svn relocate.

Options
--ignore-externals

## svn resolve

svn resolve — Resolve conflicts on working copy files or directories.

Synopsis
svn resolve PATH...

Description
Resolve “conflicted” state on working copy files or directories. This routine does not semantically resolve conflict markers; however, it replaces PATH with the version specified by the --accept argument and then removes conflict-related artifact files. This allows PATH to be committed again—that is, it tells Subversion that the conflicts have been “resolved.”

See the section called “Resolve Any Conflicts” for an in-depth look at resolving conflicts.

Options
--accept ACTION
--depth ARG
--quiet (-q)
--recursive (-R)
--targets FILENAME

## svn resolved

svn resolved — Deprecated. Remove “conflicted” state on working copy files or directories.

Synopsis
svn resolved PATH...

Description
This command has been deprecated in favor of running svn resolve --accept working PATH. See svn resolve in the preceding section for details.

Remove “conflicted” state on working copy files or directories. This routine does not semantically resolve conflict markers; it merely removes conflict-related artifact files and allows PATH to be committed again; that is, it tells Subversion that the conflicts have been “resolved.” See the section called “Resolve Any Conflicts” for an in-depth look at resolving conflicts.

Options
--depth ARG
--quiet (-q)
--recursive (-R)
--targets FILENAME

## svn revert

svn revert — Undo all local edits.

Synopsis
svn revert PATH...

Description
Reverts any local changes to a file or directory and resolves any conflicted states. svn revert will revert not only the contents of an item in your working copy, but also any property changes. Finally, you can use it to undo any scheduling operations that you may have performed (e.g., files scheduled for addition or deletion can be “unscheduled”).

Options
--changelist (--cl) ARG
--depth ARG
--quiet (-q)
--recursive (-R)
--targets FILENAME

## svn status (stat, st)

svn status (stat, st) — Print the status of working copy files and directories.

Synopsis
svn status [PATH...]

Description
Print the status of working copy files and directories. With no arguments, it prints only locally modified items (no repository access). With --show-updates (-u), it adds working revision and server out-of-date information. With --verbose (-v), it prints full revision information on every item. With --quiet (-q), it prints only summary information about locally modified items.

The first seven columns in the output are each one character wide, and each column gives you information about a different aspect of each working copy item.

The first column indicates that an item was added, deleted, or otherwise changed:

' '
No modifications.

'A'
Item is scheduled for addition.

'D'
Item is scheduled for deletion.

'M'
Item has been modified.

'R'
Item has been replaced in your working copy. This means the file was scheduled for deletion, and then a new file with the same name was scheduled for addition in its place.

'C'
The contents (as opposed to the properties) of the item conflict with updates received from the repository.

'X'
Item is present because of an externals definition.

'I'
Item is being ignored (e.g., with the svn:ignore property).

'?'
Item is not under version control.

'!'
Item is missing (e.g., you moved or deleted it without using svn). This also indicates that a directory is incomplete (a checkout or update was interrupted).

'~'
Item is versioned as one kind of object (file, directory, link), but has been replaced by a different kind of object.

The second column tells the status of a file's or directory's properties:

' '
No modifications.

'M'
Properties for this item have been modified.

'C'
Properties for this item are in conflict with property updates received from the repository.

The third column is populated only if the working copy directory is locked (see the section called “Sometimes You Just Need to Clean Up”):

' '
Item is not locked.

'L'
Item is locked.

The fourth column is populated only if the item is scheduled for addition-with-history:

' '
No history scheduled with commit.

'+'
History scheduled with commit.

The fifth column is populated only if the item is switched relative to its parent (see the section called “Traversing Branches”):

' '
Item is a child of its parent directory.

'S'
Item is switched.

The sixth column is populated with lock information:

' '
When --show-updates (-u) is used, this means the file is not locked. If --show-updates (-u) is not used, this merely means that the file is not locked in this working copy.

'K'
File is locked in this working copy.

'O'
File is locked either by another user or in another working copy. This appears only when --show-updates (-u) is used.

'T'
File was locked in this working copy, but the lock has been “stolen” and is invalid. The file is currently locked in the repository. This appears only when --show-updates (-u) is used.

'B'
File was locked in this working copy, but the lock has been “broken” and is invalid. The file is no longer locked. This appears only when --show-updates (-u) is used.

The seventh column is populated only if the item is the victim of a tree conflict:

' '
Item is not the victim of a tree conflict.

'C'
Item is the victim of a tree conflict.

The eighth column is always blank.

The out-of-date information appears in the ninth column (only if you pass the --show-updates (-u) option):

' '
The item in your working copy is up to date.

'*'
A newer revision of the item exists on the server.

The remaining fields are variable width and delimited by spaces. The working revision is the next field if the --show-updates (-u) or --verbose (-v) option is passed.

If the --verbose (-v) option is passed, the last committed revision and last committed author are displayed next.

The working copy path is always the final field, so it can include spaces.

Options
--changelist (--cl) ARG
--depth ARG
--ignore-externals
--incremental
--no-ignore
--quiet (-q)
--show-updates (-u)
--verbose (-v)
--xml

## svn switch (sw)

svn switch (sw) — Update working copy to a different URL.

Synopsis
svn switch URL[@PEGREV] [PATH]

switch --relocate FROM TO [PATH...]

Description
The first variant of this subcommand (without the --relocate option) updates your working copy to point to a new URL. This is the Subversion way to make a working copy begin tracking a new branch. If specified, PEGREV determines in which revision the target is first looked up. See the section called “Traversing Branches” for an in-depth look at switching.

[Note]
Beginning with Subversion 1.7, the svn switch command will demand by default that the URL to which you are switching your working copy shares a common ancestry with item that the working copy currently reflects. You can override this behavior by specifying the --ignore-ancestry option.

If --force is used, unversioned obstructing paths in the working copy do not automatically cause a failure if the switch attempts to add the same path. If the obstructing path is the same type (file or directory) as the corresponding path in the repository, it becomes versioned but its contents are left untouched in the working copy. This means that an obstructing directory's unversioned children may also obstruct and become versioned. For files, any content differences between the obstruction and the repository are treated like a local modification to the working copy. All properties from the repository are applied to the obstructing path.

As with most subcommands, you can limit the scope of the switch operation to a particular tree depth using the --depth option. Alternatively, you can use the --set-depth option to set a new “sticky” working copy depth on the switch target.

The --relocate option is deprecated as of Subversion 1.7. Use svn relocate (described in svn relocate) to perform working copy relocation instead.

Options
--accept ACTION
--depth ARG
--diff3-cmd CMD
--force
--ignore-ancestry
--ignore-externals
--quiet (-q)
--relocate
--revision (-r) REV
--set-depth ARG

## svn update (up)

svn update (up) — Update your working copy.

Synopsis
svn update [PATH...]

Description
svn update brings changes from the repository into your working copy. If no revision is given, it brings your working copy up to date with the HEAD revision. Otherwise, it synchronizes the working copy to the revision given by the --revision (-r) option. As part of the synchronization, svn update also removes any stale locks (see the section called “Sometimes You Just Need to Clean Up”) found in the working copy.

For each updated item, it prints a line that starts with a character reporting the action taken. These characters have the following meaning:

A
Added

B
Broken lock (third column only)

D
Deleted

U
Updated

C
Conflicted

G
Merged

E
Existed

A character in the first column signifies an update to the actual file, whereas updates to the file's properties are shown in the second column. Lock information is printed in the third column.

As with most subcommands, you can limit the scope of the update operation to a particular tree depth using the --depth option. Alternatively, you can use the --set-depth option to set a new “sticky” working copy depth on the update target.

Options
--accept ACTION
--changelist (--cl) ARG
--depth ARG
--diff3-cmd CMD
--editor-cmd CMD
--force
--ignore-externals
--parents
--quiet (-q)
--revision (-r) REV
--set-depth ARG

## svn upgrade

svn upgrade — Upgrade the metadata storage format for a working copy.

Synopsis
svn upgrade [PATH...]

Description
As new versions of Subversion are released, the format used for the working copy metadata changes to accomodate new features or fix bugs. Older versions of Subversion would automatically upgrade working copies to the new format the first time the working copy was used by the new version of the software. Beginning with Subversion 1.7, working copy upgrades must be explicitly performed at the user's request. svn upgrade is the subcommand used to trigger that upgrade process.

Options
--quiet (-q)

## 참고 자료

[Version Control with Subversion For Subversion 1.7](https://svnbook.red-bean.com/en/1.7/index.html)