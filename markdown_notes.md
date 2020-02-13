# REFERENCES
1. [markdown cheet sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
2. [TODO]()

HEADERS (two styles)
==

Setext-style
--

| HEAD LEVEL            | SYNTAX                        |
|-----------------------|-------------------------------|
| A first level header  | underline with equal signs(=) |
| A second level header | underline with hyphens(-)     |

## atx-style
| HEAD LEVEL | SYNTAX                                             |
|------------|----------------------------------------------------|
| 1-6 level  | put 1-6 hash marks(#) at the beginning of the line |


#
# BLOCKQUOTE
> This is a blockquote.
> 
> This is the second paragraph in the blockquote.
>
> ## This is an H2 in a blockquote


#
# PHRASE EMPHASIS
|                     | Discription | SYNTAX                                                            |
|---------------------|-------------|-------------------------------------------------------------------|
| *are emphasized*.   | *斜体*      | surround the empasized word with asterisk(*) or underscore(_)     |
| **are emphasized**. | **粗体**    | surround the empasized word with asterisks(**) or underscores(__) |

#
# LISTS
| List(unordered)   | SYNTAX                                   |
| ----------------- | ---------------------------------------- |
| * Candy           | put one asterisk right before the item   |
| + Gum             | put one plus right before the item       |
| - Booze           | put one hyphen right before the item     |
* Candy
  + Gum
    - Booze

__List(ordered)__
1. red

    dasda
2. green

    ifjoaj
3. yellow

    mkladjisj
1. blue

    dsjajio

-   A list item.

    With multiple paragraphs.
-   Another item in the list.

#
# LINKS
Markdown supports two styles for creating links: inline and reference. With both styles, you use square brackets to delimit the text you want to turn into a link.

1. Inline-style links use parentheses immediately after the link text. For example:
```markdown
This is an [example link](http://example.com/).
This is an [example link](http://example.com/ "With a title") with title.
```
- This is an [example link](http://example.com/).
- This is an [example link](http://example.com/ "With a title") with title.

2. Reference-style links allow you to refer to your links by names, which you define elsewhere in
   your document.
```markdown
I get 10 times more traffic from [Google][1] than from [Yahoo][2] or [MSN][3].
[1]: http://google.com/        "Google"
[2]: http://search.yahoo.com/  "Yahoo Search"
[3]: http://search.msn.com/    "MSN Search"
```
- I get 10 times more traffic from [Google][1] than from
[Yahoo][2] or [MSN][3].

[1]: http://google.com/        "Google"
[2]: http://search.yahoo.com/  "Yahoo Search"
[3]: http://search.msn.com/    "MSN Search"


#
# IMAGES
Image syntax is very much like link syntax.

1. Inline (titles are optional):
```markdown
![git](/home/xinyu/Pictures/git_chart.png "Git")
```
![git](/home/xinyu/Pictures/git_chart.png "Git")

2. Reference-style:
```markdown
![vim][4] 
[4]: /home/xinyu/Pictures/vim_keyboard.png "VIM"
```
![vim](/home/xinyu/Pictures/vim_keyboard.png "VIM")


#
# CODE AND SYNTAX HIGHLIGHTING
1. Inline code
```
Inline `code` has `back-ticks around` it.
```
Inline `code` has `back-ticks around` it.

2. Blocks of code
```
    ```python
    def add_one(number):
        return number + 1
    ```
```

```python
    def add_one(number):
        return number + 1
```

#
# TABLE

```markdown
Colons can be used to align columns.

| Tables        | Are           | Cool  |
|---------------|---------------|-------|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      | $12   |
| zebra stripes | are neat      | $1    |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the 
raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

```

| Tables        | Are           | Cool  |
|---------------|---------------|-------|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      | $12   |
| zebra stripes | are neat      | $1    |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the 
raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

#
# LINE BREAKS

```markdown
Here's a line for us to start with.

This line is separated from the one above by tow newlines, so it will be a 
separate paragraph.

This line is also a separate paragraph, but...
This line is only separated by a single newline, so it's a separate line in the *same paragraph*.
```
Here's a line for us to start with.

This line is separated from the one above by tow newlines, so it will be a 
separate paragraph.

This line is also a separate paragraph, but...
This line is only separated by a single newline, so it's a separate line in the *same paragraph*.

#
# YouTube VIDEOS
```markdown
1. pure markdown, losing the image sizing and border
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](http://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)

2. html format which can change the image size and border
<a href="http://www.youtube.com/watch?feature=player_embedded&v=KnAyziNnuI0
" target="_blank"><img src="http://img.youtube.com/vi/KnAyziNnuI0/0.jpg"
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>
```

1. pure markdown

[![MS python for beginner part 38](http://img.youtube.com/vi/KnAyziNnuI0/0.jpg)](http://www.youtube.com/watch?v=KnAyziNnuI0)

2. html format

<a href="http://www.youtube.com/watch?feature=player_embedded&v=KnAyziNnuI0
" target="_blank"><img src="http://img.youtube.com/vi/KnAyziNnuI0/0.jpg"
alt="MS python for beginners part 38" width="240" height="180" border="10" /></a>
