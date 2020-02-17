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

    
