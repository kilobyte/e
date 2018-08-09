All or almost all Unix editors support the syntax of "editor +42 file", to
open the given file and start with the cursor at line 42.  Alas, the syntax
programs that *output* such data use is different: either
"file:42: Something" or "file:42:1: Something", :1 being a column number.

This wrapper will recognize such references and call your $EDITOR using the +
notation.  Thus, once you see an error message, you can copy&paste the
offending first word of it without having to think.  Especially if your
mouse selection is configured to allow ':', it's a single triple-click
(L+L+M), and still pretty handy if not.

If your editor allows multi-open, "e" can also handle pipelines such as:
 * `git grep MEOW|e -:`
 * `make 2>&1 >/dev/null|grep error:|e -::`

Also, because of its short name, it reduces the typing needed to start the
editor by half if you use vi, by 80% if emacs or jstar — and that's by
far the most frequent command an Unix user does.
