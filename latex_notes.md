# LATEX NOTES

## REF
> [latexmk+vimtex](
    https://macplay.github.io/posts/shi-yong-latexmk-bian-yi-tex-wen-jian/#latexmkrc)

## ENV
- **Editor**: vim + plugins([vimtex](https://github.com/lervag/vimtex) + [ultisnip]())
- **Compiling Tools**: 

    if you want to compile `.tex` file, one way is using many compiler in `texlive`,
    which is tedious, another way is simply running `latexmk`  the correct number of
    times to resolve cross references, which means `latexmk` can help you manage
    the compilation process.

    > 1. [latexmk](http://personal.psu.edu/jcc8//software/latexmk-jcc/)
    > 2. [texlive](http://tug.org/texlive/acquire-netinstall.html)
- **pdfviewer**: [zathura](https://pwmt.org/projects/zathura/)

## INSTALL texlive
1. [quick install](http://tug.org/texlive/quickinstall.html)
    >I choose to use texlive*.iso 
    ```bash
    sudo mkdir /media/iso
    sudo mount texlive*.iso /media/iso/
    cd /media/iso/
    sudo perl install-tl
    ```

## INSTALL LATEXMK
1. download [latexmk](http://personal.psu.edu/jcc8//software/latexmk-jcc/latexmk-467.zip)
2. follow the `latexmk/INSTALL` instructions<br>
    create configuration file(any one of the 6 files described in the above`INSTALL` file)
    >path/to/my_config = `$HOME/.latexmkrc`

## INSTALL zathura
```bash
sudo apt-get install zathura
sudo apt-get install xdotool
```

## CONFIG vimtex
1. update vimrc file
