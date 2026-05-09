`screenwriter` -- A LaTeX class for writing screenplays
=======================================================

  - **Author:** J. A. Corbal (jacorbal [at] gmail [dot] com)
  - **Last update:** Sat May  9 18:59:15 UTC 2026
  - **Version:**  1.0.1

License
-------

This work may be distributed and/or modified under the conditions of the
LaTeX Project Public License (LPPL), either version 1.3c of this license
or (at your option) any later version.  The latest version of the
license is available at: <https://www.latex-project.org/lppl.txt>

The project is maintained by the author (for now).

Overview
--------

The `screenwriter` class provides a LaTeX document class for writing
film and television screenplays.  It is based on John Pate's
`screenplay.cls`, but updated for current LaTeX distributions and
extended with a modular language system and better integration with
`babel`.

The class focuses on:

  - A standard screenplay layout (12pt typewriter, one column, US Letter
    or A4 paper).
  - Convenient macros for sluglines, dialogue, transitions, and cover
    pages.
  - Language‑dependent strings (such as “FADE IN”, “THE END”, “INT.”,
    “EXT.”) implemented via separate language definition files.

Files
-----
The distribution typically contains:

  - The main class file:
    - `screenwriter.cls`  

  - Language definition files providing localized versions of all
  internal strings used by the class (e.g., “FADE IN”, “THE END”,
  “TITLE OVER”, “(O.S.)”, &c.):

    - `screenwriter-lang-english.ldf`  
    - `screenwriter-lang-spanish.ldf`  
    - `screenwriter-lang-french.ldf`  
    - `screenwriter-lang-german.ldf`  
    - `screenwriter-lang-italian.ldf`  
    - `screenwriter-lang-portuguese.ldf`  
    - `screenwriter-lang-galician.ldf`  
    - `screenwriter-lang-catalan.ldf`  
    - `screenwriter-lang-esperanto.ldf`  

  - User documentation and examples:
    - `screenwriter-doc-a4.tex`
    - `screenwriter-doc-a4.pdf`
    - `screenwriter-doc-letter.tex`
    - `screenwriter-doc-letter.pdf`
    - `sample.pdf`

  - License file (LPPL 1.3c):
    - `LICENSE`

  - This file:
    - `README`  

Installation
------------

For a local installation in a personal TEXMF tree, copy the files as
follows:

  - Place `screenwriter.cls` and all `screenwriter-lang-*.ldf` files
    into a directory such as:

        TEXMFHOME/tex/latex/screenwriter/

    where `TEXMFHOME` is your local TEXMF root (for example `~/texmf` on
    a typical TeX Live installation).

  - Run `mktexlsr` or the equivalent command for your TeX distribution
    to update the file name database, if required.

Once installed, LaTeX should find the class and language files
automatically.

Usage
-----

A minimal document using the default (English) settings:

    \documentclass{screenwriter}

    \title{My First Screenplay}
    \author{Screenwriter Name}

    \begin{document}
        \coverpage

        \fadein
        \intslug[DAY]{Office}

        \begin{dialogue}{WRITER}
            This is a line of dialogue.
        \end{dialogue}

        \theend
    \end{document}

Page Layout and Options
-----------------------

The class loads the standard `article` class internally and sets up a
screenplay-friendly layout:

  - 12pt typewriter font
  - One column, one-sided
  - US Letter (default) or A4 paper
  - Ragged-right text, custom margins and dialogue widths

Paper options:

  - `a4paper` -- use A4 paper and adjust the width of dialogue and
    address blocks accordingly.
  - `letterpaper` -- use US Letter paper (default).

Example:

    \documentclass[a4paper]{screenwriter}

Screenplay style options:

  - `literary` -- sluglines without scene numbers (default).
  - `technical` -- sluglines with automatically numbered scenes in the
    margins.

Example:

    \documentclass[technical]{screenwriter}

Language support
----------------

The class provides a simple language mechanism for its own internal
strings (such as “FADE IN”, “THE END”, “INT.”, “EXT.”, etc.).  This is
separate from, but designed to cooperate with, `babel`.

There are two ways to select a language:

1. **Via class options (explicit language)**

   You can explicitly choose the language used for the internal strings
   by passing one of the available language options to the class:

     - `english` (default)
     - `catalan`
     - `esperanto`
     - `french`
     - `galician`
     - `german`
     - `italian`
     - `portuguese`
     - `spanish`

   Example:

        \documentclass[spanish]{screenwriter}

   This will load `screenwriter-lang-spanish.ldf` and use Spanish
   versions for all internal labels, regardless of whether `babel` is
   loaded.

2. **Via babel (implicit language)**

   If no explicit language option is given to the class, but `babel` is
   loaded with a language option, the class will attempt to detect the
   current language through `\languagename` at `\begin{document}` and
   load the corresponding `screenwriter-lang-<language>.ldf` file, if
   available.

   Example:

        \documentclass{screenwriter}
        \usepackage[french]{babel}

   In this case, the class will try to use
   `screenwriter-lang-french.ldf`.  If no matching language file is
   found, it falls back to English.

Note that the class does not load `babel` on its own; users are expected
to load `babel` (or `polyglossia`) in the usual way if they require
language-specific hyphenation and typography.

Main commands
-------------

The class defines several commands and environments tailored to
screenplays:

- Cover and title

  - `\coverpage`  
      Produces a standard cover page with title, author, and contact
      information.

  - `\nicholl`  
      Alternative simple title page variant.

  - `\title{...}`, `\author{...}`  
      Standard LaTeX macros reused by the class.

  - `\realauthor{...}`  
      Sets the “real” author name for the cover.

  - `\address{...}`, `\agent{...}`  
      Provide address and agent information for the cover page.

- Sluglines

  - `\intslug[QUALIFIER]{LOCATION}`  
      Interior slugline (INT.).

  - `\extslug[QUALIFIER]{LOCATION}`  
      Exterior slugline (EXT.).

  - `\intextslug[QUALIFIER]{LOCATION}`  
      Combined interior/exterior slugline (INT./EXT.).

  - `\extintslug[QUALIFIER]{LOCATION}`  
      Combined exterior/interior slugline (EXT./INT.).

  The exact abbreviations and punctuation are language-dependent and
  defined in the corresponding `.ldf` files.

- Dialogue

  - Environment `dialogue[paren]{CHARACTER}`  
      Typesets character name and dialogue in the standard screenplay
      layout.  An optional parenthetical can be provided in the optional
      argument.

  - `\dialbreak[paren]{CHARACTER}`  
      Ends the current dialogue block with a “(MORE)” marker, starts
      a new page, and continues the same character's dialogue marked as
      “(CONT'D)”.

- Transitions and labels

  - `\fadein`, `\fadeout`  
      Insert “FADE IN:” and “FADE OUT:” (or their localized versions).

  - `\intercut`, `\flashback`  
      Insert transition labels such as “INTERCUT WITH:” and
      “FLASHBACK TO:”.

  - `\titleover` environment  
      For “TITLE OVER:” blocks (such as on-screen text).

  - `\theend`  
      Typesets the final “THE END” (or localized equivalent) centered.

For detailed examples and spacing behaviour, see the accompanying
`screenwriter-doc.pdf`.

Development and contributions
-----------------------------

The class is intended as an up-to-date, language-aware replacement for
the original `screenplay.cls`, while preserving the general user
interface familiar to screenwriters using LaTeX.

Bug reports, suggestions, and contributions (especially new language
definition files) are welcome.  Please contact the maintainer at:
(jacorbal [at] gmail [dot] com).
