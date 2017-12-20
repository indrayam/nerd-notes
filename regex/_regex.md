# regex scratchpad

I will use `(space)` to actually refer to a space

A regular expression is a pattern of text that consists of literals (ordinary characters) and metacharacters (? or *)

#### Metacharacters
`.` Matches any character, except newline. If re.DOTALL or re.S is set, then . also includes newline

`*` Match 0 or more repetitions of the preceding RE

`+` Match 1 or more repetitions of the preceding RE

`?` Match 0 or 1 repetitions of the preceding RE

`*?`, `+?`, `??` If you wanted *, + and ? qualifiers to be non-greedy

`^` Matches the start of the string. If re.M is set, it matches the start of every new line

`$` Matches the end of the string. If re.M is set, it matches just before the end of every new line

`\` Escape special chars or signals a special sequence
    - `\1`, `\2` matches contents of the group with the same number

`(` Start of a group

`)` End of a Group

`[ ]` Indicates a set of characters
    - Characters can be listed individually `[amk]`
    - Ranges of characters can be listed like `[a-z]` or `[a-zA-Z0-9]`
    - Special characters like `*`, `?`, `)` lose their meaning inside `[` and `]`. So `[(+*]` will match any of the literal chars: `(`, `+`, `*`
    - `[^a-z]` inverts the meaning of the range of characters 

`{m}` Specifies that exactly m copies of the previous RE should be matched
    - `{m, n}` Causes the resulting RE to match from m to n repetitions of the previous RE
    - `{m, n}?` Non-greedy version
    - `{m, }` No upper limit
    - `{ , n}` Lower limit is set to zero

`|` `A|B`, where A and B can be arbitrary REs, creates a regular expression that will match either A or B

`(?:...)` Matches the RE inside the parentheses but discards the matched substring

`(?P<name>…)` Matches the RE inside the parentheses and creates a named group. The Group name must be a valid Python identifier

`(?P=name)` Matches the same text that was matched by an earlier named group

`(?#...)` A comment. The contents of the parentheses are ignored

`(?=...)` Matches the preceding expression if and only if it is followed by the RE pattern enclosed in `(?=…)`

`(?!...)` Matches the preceding expression if and only if it is NOT followed by the RE pattern enclosed in `(?!…)`

`(?<=…)` Matches the following expression if it’s preceded by a match of the pattern in parentheses. For example: `r'(<=abc)def'` matches `def` only if it’s preceded by `abc`

`(?<!…)` Matches the following expression if it’s NOT preceded by a match of the pattern in parentheses. For example: `r'(<!abc)def'` matches `def` only if it’s NOT preceded by `abc`

#### Character Classes

`.` Matches any character, except newline. If re.DOTALL or re.S is set, then . also includes newline

`\A` Matches only at the start of the string

`\Z` Matches only at the end of the string

`\b` Matches the empty string at the beginning or end of a “word"

`\d` Matches any decimal digit. Same as r'[0-9]'

`\D` Matches any non-digit character. Same as r'[^0-9]'

`\s` Matches any whitespace character. Same as r'[(space)\t\n\r\f\v]'

`\S` Matches any non-whitespace character. Same as r'[^(space)\t\n\r\f\v]'

`\w` Matches any alphanumeric character. Same as [a-zA-Z0-9_]

`\W` Matches any character not contained in the set defined by \w. Same as Same as [^a-zA-Z0-9_]

`\\` Matches a literal backlash

#### Quantifiers

`*` Match 0 or more repetitions of the preceding RE {0, }

`+` Match 1 or more repetitions of the preceding RE {1, }

`?` Match 0 or 1 repetitions of the preceding RE { ,1}

`{m}` Specifies that exactly m copies of the previous RE should be matched
    - `{m, n}` Causes the resulting RE to match from m to n repetitions of the previous RE
    - `{m, n}?` Non-greedy version
    - `{m, }` No upper limit
    - `{ , n}` Lower limit is set to zero
