%
% This is file `screenwriter.cls', version 1.0.1 (2026-05-09)
%
%   Author: J. A. Corbal (jacorbal [at] gmail [dot] net)
%   Copyright 2013--2026 J. A. Corbal
%   Based on J. Pate's <johnny [at] dvc [dot] org [dot] uk> `screenplay.cls'
%
%   This work may be distributed and/or modified under the conditions of
%   the LaTeX Project Public License (LPPL), either version 1.3c of this
%   license or (at your option) any later version.  The latest version
%   of the license is in <http://www.latex-project.org/lppl.txt>.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{screenwriter}[2026/05/09 v0.2 Screenwriter class]

% --- internal language state (default: english)
\newcommand*{\screenwriter@lang}{english}
\newif\ifscreenwriter@lang@explicit
\screenwriter@lang@explicitfalse

% --- default geometry-related parameters (US Letter screenplay-style)
\newcommand*{\mybaselinestretch}{0.8}
\newcommand*{\myparindent}{0.0in}
\newcommand*{\myevensidemargin}{0.5in}
\newcommand*{\myoddsidemargin}{0.5in}
\newcommand*{\mytopmargin}{-0.5in}
\newcommand*{\myheadsep}{0.4in}
\newcommand*{\mytopskip}{0.0in}
\newcommand*{\mytextwidth}{6.0in}
\newcommand*{\mytextheight}{9.5in}
\newcommand*{\mywidthgutter}{0.1in}
\newcommand*{\mydialgutter}{0.2in}
\newcommand*{\mydialwidth}{3.0in}
\newcommand*{\myparenwidth}{1.5in}
\newcommand*{\myparentab}{0.7in}
\newcommand*{\mytitskip}{3.75in plus 0in minus 1.5in}
\newcommand*{\mytitheadskip}{2.25in}
\newcommand*{\mybaselineskip}{12pt plus 0pt minus 0pt}
\newcommand*{\myaddrwidth}{2in}
\newcommand*{\myaddrseplen}{2.0in plus 0in minus 0.5in}

% --- default texts (English)
\newcommand*{\myaddresstext}{Contact via Agency}
\newcommand*{\mymoretext}{(MORE)}
\newcommand*{\mycontdtext}{(CONT'D)}
\newcommand*{\myoffscreentext}{(O.S.)}
\newcommand*{\myvoiceovertext}{(V.O.)}
\newcommand*{\myfadeintext}{FADE IN}
\newcommand*{\myfadeouttext}{FADE OUT}
\newcommand*{\myadlibtext}{ad~lib.}
\newcommand*{\mypunctcharA}{:}
\newcommand*{\mypunctcharB}{:}
\newcommand*{\myplacesep}{.~}
\newcommand*{\mysepintext}{./}
\newcommand*{\mybytext}{by}
\newcommand*{\myinttext}{INT}
\newcommand*{\myexttext}{EXT}
\newcommand*{\mytitleovertext}{TITLE OVER}
\newcommand*{\myintercuttext}{INTERCUT WITH}
\newcommand*{\myflashbacktext}{FLASHBACK TO}
\newcommand*{\mypovtext}{P.O.V.}
\newcommand*{\myreverttext}{REVERSE \pov}
\newcommand*{\mythirtytext}{THE END}
\newcommand*{\myslugspace}{ -- }

% --- options

\newcommand*{\slug}{} % will be redefined by literary/technical

% estado interno de idioma
\newif\ifscreenwriter@lang@explicit
\screenwriter@lang@explicitfalse

% idioma explícito por opciones
\DeclareOption{english}{%
  \def\screenwriter@lang{english}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{spanish}{%
  \def\screenwriter@lang{spanish}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{french}{%
  \def\screenwriter@lang{french}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{german}{%
  \def\screenwriter@lang{german}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{italian}{%
  \def\screenwriter@lang{italian}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{portuguese}{%
  \def\screenwriter@lang{portuguese}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{galician}{%
  \def\screenwriter@lang{galician}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{catalan}{%
  \def\screenwriter@lang{catalan}%
  \screenwriter@lang@explicittrue
}
\DeclareOption{esperanto}{%
  \def\screenwriter@lang{esperanto}%
  \screenwriter@lang@explicittrue
}

% papel
\DeclareOption{a4paper}{%
  \PassOptionsToClass{a4paper}{article}%
  \PassOptionsToPackage{a4paper}{geometry}%
  \renewcommand{\mytextwidth}{15cm}%
  \renewcommand{\mytextheight}{25cm}%
  \renewcommand{\myparenwidth}{3.8cm}%
  \renewcommand{\myparentab}{1.8cm}%
  \renewcommand{\myaddrwidth}{6.2cm}%
  \renewcommand{\myaddrseplen}{3cm plus 0cm minus 1.5cm}%
}
\DeclareOption{letterpaper}{%
  \PassOptionsToClass{letterpaper}{article}%
  \PassOptionsToPackage{letterpaper}{geometry}%
}

% tipo de guion
\DeclareOption{literary}{%
  \renewcommand{\slug}[3][]{%
    \MakeUppercase{#2\placesep#3}%
    \ifthenelse{\not\equal{#1}{}}%
      {\slugspace\MakeUppercase{#1}\hspace{\fill}}%
      {}%
    \nopagebreak
  }%
}
\DeclareOption{technical}{%
  \newcounter{scene}%
  \renewcommand{\slug}[3][]{%
    \stepcounter{scene}%
    \MakeUppercase{#2\placesep#3}\marginpar{\arabic{scene}}%
    \ifthenelse{\not\equal{#1}{}}%
      {\slugspace\MakeUppercase{#1}\hspace{\fill}}%
      {}%
    \hfill\reversemarginpar{\arabic{scene}}%
    \nopagebreak
  }%
}

% opciones por defecto
\ExecuteOptions{letterpaper,literary}
\ProcessOptions\relax

% --- base class and packages

\RequirePackage{ifthen}
\LoadClass[12pt,onecolumn,oneside]{article}
\RequirePackage{geometry}
\RequirePackage{courier}

% --- behaviour básico

\renewcommand*{\familydefault}{\ttdefault}
\raggedright
\pagenumbering{arabic}
\pagestyle{myheadings}

% --- integración de idioma con babel

\AtBeginDocument{%
  \@ifpackageloaded{babel}{%
    \ifscreenwriter@lang@explicit
      % usuario ya ha elegido idioma en la clase
    \else
      \@ifundefined{languagename}{}{%
        \edef\screenwriter@lang{\languagename}%
      }%
    \fi
  }{}%
  \InputIfFileExists{lang/screenwriter-lang-\screenwriter@lang.ldf}{}{%
    \def\screenwriter@lang{english}%
    \InputIfFileExists{lang/screenwriter-lang-english.ldf}{}{}%
  }%
}

% Margins.
\setlength{\baselineskip}{12pt plus 0pt minus 0pt}
\renewcommand*{\baselinestretch}{\mybaselinestretch}
\newcommand*{\dialfix}{\vspace{2pt}}
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{\myparindent}
\newcommand*{\slugspace}{\myslugspace}
\setlength{\evensidemargin}{\myevensidemargin}
\setlength{\oddsidemargin}{\myoddsidemargin}
\setlength{\topmargin}{\mytopmargin}
\setlength{\headsep}{\myheadsep}
\setlength{\topskip}{\mytopskip}
\setlength{\textheight}{\mytextheight}
\setlength{\textwidth}{\mytextwidth}
\newlength{\widthgutter}
\setlength{\widthgutter}{\mywidthgutter}
\addtolength{\textwidth}{\widthgutter}
\newlength{\dialwidth}
\setlength{\dialwidth}{\mydialwidth}
\newlength{\dialgutter}
\setlength{\dialgutter}{\mydialgutter}
\addtolength{\dialwidth}{\dialgutter}
\newcommand*{\dialtab}{\hspace*{1.5in}}
\newcommand*{\dialnametab}{\hspace*{1.2in}}
\newlength{\parenwidth}
\setlength{\parenwidth}{\myparenwidth}
\addtolength{\parenwidth}{\dialgutter}
\newcommand*{\parentab}{\hspace{\myparentab}}
\renewcommand*{\textfraction}{1}
\renewcommand*{\topfraction}{0}
\renewcommand*{\bottomfraction}{0}

% Title and address related.
\title{Prima Opus Magnum}
\author{Alan Smithee}
\newcommand{\@realauthor}{\@author}
\newcommand{\realauthor}[1]{\renewcommand{\@realauthor}{#1}}
\newcommand{\@address}{\myaddresstext}
\newcommand{\address}[1]{\renewcommand{\@address}{#1}}
\newcommand{\@agent}{~}
\newcommand{\agent}[1]{\renewcommand{\@agent}{#1}}
\newlength{\titskip}
\setlength{\titskip}{3.75in plus 0in minus 1.5in}
\newlength{\addrwidth}
\setlength{\addrwidth}{2.0in}
\newlength{\addrseplen}
\setlength{\addrseplen}{2.0in plus 0in minus 0.5in}
\newcommand*{\bytext}{\mybytext}
\newcommand*{\byskip}{\baselineskip}

% Cover related.
\newlength{\titheadskip}
\setlength{\titheadskip}{2.25in}

\newcommand{\nicholl}{%
  \thispagestyle{empty}%
  \vspace*{\titheadskip}%
  \begin{center}\MakeUppercase{\@title}\end{center}%
  \newpage\setcounter{page}{1}%
}

\newcommand{\coverpage}{%
  \thispagestyle{empty}%
  \vspace*{\titheadskip}%
  \begin{center}{\MakeUppercase{\@title}}\\
  \vspace{\byskip}%
  \bytext\\
  \vspace{\byskip}%
  \@author
  \end{center}%
  \vspace{\titskip}%
  \parbox[t]{\addrwidth}{\@agent}\hspace{\addrseplen}%
  \parbox[t]{\addrwidth}{\@realauthor\\\@address}%
  \newpage\setcounter{page}{1}%
}

% Text strings.
\newcommand*{\more}{\mymoretext}
\newcommand*{\contd}{\mycontdtext}
\newcommand*{\voiceover}{\myvoiceovertext}
\newcommand*{\offscreen}{\myoffscreentext}
\newcommand*{\adlib}{\myadlibtext}
\newcommand*{\pov}{\mypovtext}
\newcommand*{\revert}{\myreverttext}
\newcommand*{\thirty}{\mythirtytext}
\newcommand{\theend}{\sccentre{\thirty}}

% Dialog related.
\newcommand{\paren}[1]{%
  \par\parentab\parbox[t]{\parenwidth}{\raggedright(#1)\dialfix}\\%
}

\newenvironment{dialogue}[2][]{%
  \dialtab\dialnametab\hbox{\MakeUppercase{#2}}\\*%
  \dialtab\begin{minipage}[b]{\dialwidth}%
  \dialfix
  \raggedright
  \ifthenelse{\not\equal{#1}{}}%
    {\paren{#1}}%
    {}%
}{\end{minipage}}

\newcommand{\dialbreak}[2][]{%
  \nopagebreak
  \dialnametab\hbox{\more}%
  \end{dialogue}
  \newpage
  \ifthenelse{\not\equal{#1}{}}%
    {\begin{dialogue}[#1]{\MakeUppercase{#2} \contd}}%
    {\begin{dialogue}{\MakeUppercase{#2} \contd}}%
}

% Slugs.
\newcommand*{\placesep}{\myplacesep}

\newcommand*{\inttext}{\myinttext}
\newcommand{\intslug}[2][]{\slug[#1]{\inttext}{#2}}

\newcommand*{\exttext}{\myexttext}
\newcommand{\extslug}[2][]{\slug[#1]{\exttext}{#2}}

\newcommand*{\sepintext}{\mysepintext}
\newcommand{\intextslug}[2][]{\slug[#1]{\inttext\sepintext\exttext}{#2}}
\newcommand{\extintslug}[2][]{\slug[#1]{\exttext\sepintext\inttext}{#2}}

\newcommand*{\sccentre}[1]{\hspace*{\fill}{#1}\hspace{\fill}\hspace{\widthgutter}}
\newcommand*{\scflushright}[1]{\hspace*{\fill}{#1}\hspace{\widthgutter}}

% Title over, fades, intercuts and more labels.
\newcommand*{\punctcharA}{\mypunctcharA}
\newcommand*{\punctcharB}{\mypunctcharB}

\newcommand*{\titleovertext}{\mytitleovertext}

\newenvironment{titleover}[1][]{%
  \ifthenelse{\not\equal{#1}{}}%
    {\titleovertext #1\punctcharA}%
    {\titleovertext\punctcharA}%
  \\*[\baselineskip]%
  \dialtab\begin{minipage}[b]{\dialwidth}%
  \raggedright
}{\end{minipage}}

\newcommand{\titbreak}{%
  \nopagebreak
  \dialnametab\hbox{\more}%
  \end{titleover}
  \newpage
  \begin{titleover}[\contd]%
}

\newcommand{\centretitle}[1]{%
  \titleovertext\punctcharA\\*[\baselineskip]%
  \sccentre{#1}\\
  \bigskip
}

\newcommand*{\fadeintext}{\myfadeintext}
\newcommand{\fadein}{%
  \fadeintext\punctcharA\\
  \bigskip
}

\newcommand{\RIGHT}[2]{%
  \scflushright{#1#2}\\
  \bigskip
}

\newcommand*{\intercuttext}{\myintercuttext}
\newcommand*{\flashbacktext}{\myflashbacktext}
\newcommand*{\fadeouttext}{\myfadeouttext}

\newcommand{\intercut}{\RIGHT{\intercuttext}{\punctcharA}}
\newcommand{\flashback}{\RIGHT{\flashbacktext}{\punctcharA}}
\newcommand{\fadeout}{\RIGHT{\fadeouttext}{\punctcharB}}
