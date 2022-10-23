# variants_text_tree

A small Perl script to produce a minimalistic text tree of SARS-CoV-2 subvariants from a JSON file as seen in 
https://github.com/MDU-PHL/pango-watch/blob/main/tree/data.json

The output allows one to have a small text file to do a text search for some existing subvariant or alias.

---

Searching a subvariant, if the searched text is found, that subvariant exists, and its context is seen.

Searching an alias, if the searched alias is found, that alias exists, and its context is seen.

The childless subvariants which have the sequential names (every last number is one bigger than the previous)
are in the same line, the gaps start a new line.

Every list of children starts a new line.

---

For those who always wanted to know the answers to these questions by a simple search through
a minimalistic text file with that information.

----

An example of a part of the output:

    B.1.1.529.2.75.3 (BA.2.75.3),
    [ B.1.1.529.2.75.3.1 (BM.1),
    [ B.1.1.529.2.75.3.1.1 (BM.1.1),
    [ B.1.1.529.2.75.3.1.1.1 (BM.1.1.1),
    [ B.1.1.529.2.75.3.1.1.1.1 (CJ.1),
    ]

    B.1.1.529.2.75.3.1.1.2 (BM.1.1.2), B.1.1.529.2.75.3.1.1.3 (BM.1.1.3),
    ]

    ]

    B.1.1.529.2.75.3.2 (BM.2),
    [ B.1.1.529.2.75.3.2.1 (BM.2.1), B.1.1.529.2.75.3.2.2 (BM.2.2), B.1.1.529.2.75.3.2.3 (BM.2.3),
    ]

    B.1.1.529.2.75.3.3 (BM.3),
    B.1.1.529.2.75.3.4 (BM.4),
    [ B.1.1.529.2.75.3.4.1 (BM.4.1),
    [ B.1.1.529.2.75.3.4.1.1 (BM.4.1.1),
    [ B.1.1.529.2.75.3.4.1.1.1 (CH.1),
    [ B.1.1.529.2.75.3.4.1.1.1.1 (CH.1.1),
    ]

---

Converting a newer version of the data.json file (for those who aren't familiar with command line):

- Perl has to be installed on your system.
- Keep pretty-tree.pl in some folder, put the newer data.json in the same folder
- Open the command prompt in that folder and type
    pretty-tree.pl >my-new-min-tree.txt
- The new minimalistic text tree should be in my-new-min-tree.txt
