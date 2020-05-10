# Bash command line shortcuts
## Ctrl+
- Tab ↹ : Autocompletes from the cursor position.
- **Ctrl+a : Moves the cursor to the line start (equivalent to the key Home).**
- **Ctrl+e : (end) moves the cursor to the line end (equivalent to the key End).**
- **Ctrl+b : Moves the cursor back one character (equivalent to the key ←).**
- **Ctrl+f : Moves the cursor forward one character (equivalent to the key →).**
- **Ctrl+w : Clears the word before the cursor and copies it into the clipboard.**
- **Ctrl+t : Transpose the previous two characters.**
- **Ctrl+k : Clears the line content after the cursor and copies it into the clipboard.**
- **Ctrl+u : Clears the line content before the cursor and copies it into the clipboard.**

- **Ctrl+y : (yank) adds the clipboard content from the cursor position.**
- **Ctrl+_ : Incremental undo, separately remembered for each line.**


- Ctrl+l : Clears the screen content (equivalent to the command clear).
- Ctrl+c : Sends the signal SIGINT to the current task, which aborts and closes it.
- Ctrl+d : Sends an EOF marker, which (unless disabled by an option) closes the 
           current shell (equivalent to the command exit). (Only if there is no 
           text on the current line) If there is text on the current line, deletes
           the current character (then equivalent to the key Delete).
- Ctrl+g : Abort the research and restore the original line.
- Ctrl+h : Deletes the previous character (same as backspace).
- Ctrl+i : Equivalent to the tab key.
- Ctrl+j : Equivalent to the enter key.
- Ctrl+n : (next) recalls the next command (equivalent to the key ↓).
- Ctrl+o : Executes the found command from history, and fetch the next line 
           relative to the current line from the history for editing.
- Ctrl+p : (previous) recalls the prior command (equivalent to the key ↑).
- Ctrl+r : (reverse search) recalls the last command including the specified 
           character(s). A second Ctrl+r recalls the next anterior command that 
           corresponds to the search
- Ctrl+s : Go back to the next more recent command of the research (beware to not 
           execute it from a terminal because this command also launches its XOFF). 
           If you changed that XOFF setting, use Ctrl+q to return.
- Ctrl+v : If the next input is also a control sequence, type it literally 
           (e. g. * Ctrl+v Ctrl+h types "^H", a literal backspace.)
- Ctrl+x Ctrl+e : Edits the current line in the $EDITOR program, or vi if undefined.
- Ctrl+x Ctrl+r : Read in the contents of the inputrc file, and incorporate any 
                  bindings or variable assignments found there.
- Ctrl+x Ctrl+u : Incremental undo, separately remembered for each line.
- Ctrl+x Ctrl+v : Display version information about the current instance of Bash.
- Ctrl+x Ctrl+x : Alternates the cursor with its old position. (C-x, because x 
                  has a crossing shape).
- Ctrl+z : Sends the signal SIGTSTP to the current task, which suspends it. To 
           execute it in background one can enter bg. To bring it back from 
           background or suspension fg ['process name or job id'] (foreground) can be issued.


## Alt+
- Alt+b : (backward) moves the cursor backward one word.
- Alt+f : (forward) moves the cursor forward one word.

- Alt+d : Cuts the word after the cursor.

- Alt+c : Capitalizes the character under the cursor and moves to the end of the word.
- Alt+l : Lowers the case of every character from the cursor's position to the 
- Alt+u : Capitalizes every character from the cursor's position to the end of the current word.
          end of the current word.
- Alt+r : Cancels the changes and puts back the line as it was in the history.

- Alt+. : Insert the last argument to the previous command (the last word of the 
          previous history entry).




# Bash Shell Script
Anything that can be done in the command line 
can be put in a script file for reuse

## Follow these steps to create a script:
1. Create a new file called script_name.sh
    ```bash
    vim script_name.sh
    ```
2. Make the script executable by running `chmod +x script_name.sh`

3. Add the code:
    ```
    #! bin/bash
    echo "Hello World!"
    ```

    Line 1:The first line of the script must start with the character sequence __`#!`__ , 
    referred to as shebang1. The shebang instructs the operating system to run __`/bin/bash`__ , 
    the Bash shell, passing it the script's path as an argument.

    E.g. /bin/bash script_name.sh

    Line 2:Uses the `echo` command to write Hello World to the standard output

4. Execute the script_name.sh script from the commond line using one of the following:

    - ./script_name.sh --most commonly used, and recommended
    - /bin/bash script_name.sh
    - bash script_name.sh --assuming /bin in your `$PATH`
    - sh script_name.sh

    
# Mount Command
1. List information about block device
   ```bash
   lsblk -o name,size,uuid,fstype
   ``` 

2. Modify the /etc/fstab file, add the content below at the end of the file
    ```
    # /media/windows/ was on /dev/sda2 during installation
    UUID=CCBA2722BA270912                     /media/windows       ntfs    uid=1000,gid=1000,fmask=007,dmask=007   0       0
    ```
    You only need to change the UUID and `/media/windows`
