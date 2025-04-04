%# Copyright (c) 2023-2025 Christoph P. Neumann,
%# Copyright (c) 2018-2021 Oliver Kopp
%# Reference: https://latextemplates.github.io/

% !TeX spellcheck = en-US
% LTeX: language=en-US
% !TeX encoding = utf8
% !TeX program = pdflatex
% !BIB program = biblatex / biber

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cs-techrep}[2025/03/30 TechReps in CS and SWE v0.7]

% Define marker counter for options (counter are global in latex):

\newcounter{cstechrep@subfigtracker}
\newcounter{cstechrep@subcaptiontracker}
\newcounter{cstechrep@pbalancetracker}
\newcounter{cstechrep@flushendtracker}

% Declare options:

\DeclareOption{subfig}{
  \setcounter{cstechrep@subfigtracker}{1}
  \typeout{cs-techrep class: subfig option is set (use subfloat command).}
}
\DeclareOption{subcaption}{
  \setcounter{cstechrep@subcaptiontracker}{1}
  \typeout{cs-techrep class: subcaption option is set (use subfigure command).}
}

% IEEE option onecolumn will be ignored
\DeclareOption{onecolumn}{\OptionNotUsed}

\DeclareOption{pbalance}{
  \setcounter{cstechrep@pbalancetracker}{1}
  \typeout{cs-techrep class: pbalance option is set.}
}
\DeclareOption{flushend}{
  \setcounter{cstechrep@flushendtracker}{1}
  \typeout{cs-techrep class: flushend option is set.}
}

% We'll pass any document class options along to the underlying class
% (recommended IEEE options: conference,a4paper)
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{IEEEtran}
}

% Now we'll execute any options passed in
\ProcessOptions\relax

% Instead of defining each and every little detail required to create a new
% document class, you can base your class on an existing document class.
\LoadClass{IEEEtran}

% This template has been tested with IEEEtran of 2015.

% =======================
% USER PROVIDED VARIABLES

\makeatletter
\newcommand*\DefcstechrepVar[1]{%
\@namedef{cstechrep#1}##1{\global\@namedef{cstechrep#1}{##1}}}
\makeatother

\DefcstechrepVar{AuthorListTex}
\DefcstechrepVar{AuthorListBib} % Use *and* as author separator!
\DefcstechrepVar{TitleTex}
\DefcstechrepVar{TitleBib}
\DefcstechrepVar{Department}  % e.g., Department of Computer Science
\DefcstechrepVar{Institution} % e.g., OTH Amberg-Weiden
\DefcstechrepVar{Address}     % e.g., Amberg, Germany
\DefcstechrepVar{Type}        % e.g., Technical Report
\DefcstechrepVar{Year}        % e.g., 2024
\DefcstechrepVar{Title}
\DefcstechrepVar{Month}       % e.g., 10 (for October)
\DefcstechrepVar{Number}      % e.g., CL-2024-42
\DefcstechrepVar{Lang}        % e.g., english = en-US (or: ngerman = DE)
% =======================

% backticks (`) are rendered as such in verbatim environments.
% See following links for details:
%   - https://tex.stackexchange.com/a/341057/9075
%   - https://tex.stackexchange.com/a/47451/9075
%   - https://tex.stackexchange.com/a/166791/9075
\RequirePackage{upquote}

% Set English as language and allow to write hyphenated"=words
%
% Even though `american`, `english` and `usenglish` are synonyms
% for babel package (according to 
% https://tex.stackexchange.com/questions/12775/babel-english-american-usenglish),
% the llncs document class is prepared to avoid the overriding of certain 
% names (such as "Abstract." -> "Abstract" or "Fig." -> "Figure")
% when using `english`, but not when using the other 2.
% english has to go last to set it as default language
\RequirePackage[ngerman,main=english]{babel}
%
% Hint by http://tex.stackexchange.com/a/321066/9075 -> enable "= as dashes
\addto\extrasenglish{\languageshorthands{ngerman}\useshorthands{"}}

% CM variant with scalable font
% (to prevent "pdfTeX error (font expansion):
% auto expansion is only possible with scalable")
\RequirePackage{lmodern}
% Times New Roman, because IEEE is based on Times (and not CM/lmodern),
% however, package times is not a scalable font, thus, lmodern is required
% additionally and must be loaded before times.
\RequirePackage{times}

% Links behave as they should. Enables "\url{...}" for URL typesettings.
% Allow URL breaks also at a hyphen, even though it might be confusing:
% Is the "-" part of the address or just a hyphen?
% See https://tex.stackexchange.com/a/3034/9075.
\RequirePackage[hyphens]{url}

% When activated, use text font as url font, not the monospaced one.
% For all options see https://tex.stackexchange.com/a/261435/9075.
% \urlstyle{same}

% Improve wrapping of URLs - hint by http://tex.stackexchange.com/a/10419/9075
\makeatletter
\g@addto@macro{\UrlBreaks}{\UrlOrds}
\makeatother

% nicer // - solution by http://tex.stackexchange.com/a/98470/9075
% DO NOT ACTIVATE -> prevents line breaks
%\makeatletter
%\def\Url@twoslashes{\mathchar`\/\@ifnextchar/{\kern-.2em}{}}
%\g@addto@macro\UrlSpecials{\do\/{\Url@twoslashes}}
%\makeatother

% use nicer font for code
\RequirePackage[zerostyle=b,scaled=.75]{newtxtt}

% inputenc must be loaded before biblatex
\RequirePackage[utf8]{inputenc}

% Has to be loaded AFTER any font packages.
% See https://tex.stackexchange.com/a/2869/9075.
\RequirePackage[T1]{fontenc}


% Character protrusion and font expansion.
% See http://www.ctan.org/tex-archive/macros/latex/contrib/microtype/
\RequirePackage[
  babel=true, % Enable language-specific kerning
  expansion=alltext,
  protrusion=alltext-nott, % Ensure no changes at the edge of the listing.
  nopatch=eqnum, % fix unable to apply patch eqnum
  final % Always enable microtype, even if in draft mode.
        % This helps finding bad boxes quickly. In the standard
        % configuration, this template is always in the final mode, so
        % this option only makes a difference if "pros" use the draft mode.
]{microtype}

% \texttt{test -- test} keeps the "--" as "--" 
% (and does not convert it to an en dash)
\DisableLigatures{encoding = T1, family = tt* }

\RequirePackage{graphicx}

% Creative Commons
\RequirePackage{ccicons}

% Diagonal lines in a table
% http://tex.stackexchange.com/questions/17745/diagonal-lines-in-table-cell
% Slashbox is not available in texlive (due to licensing)
% and also gives bad results. Thus, we use diagbox
\RequirePackage{diagbox}

\RequirePackage[cmyk, table]{xcolor}

\RequirePackage{relsize} % allows for \textsmaller{..}

\RequirePackage[nolist,smaller]{acronym}

% Code Listings
\RequirePackage{listings}

\definecolor{eclipseStrings}{RGB}{42,0.0,255}
\definecolor{eclipseKeywords}{RGB}{127,0,85}
\colorlet{numb}{magenta!60!black}

% JSON definition
% Source: https://tex.stackexchange.com/a/433961/9075

\lstdefinelanguage{json}{
  basicstyle=\normalfont\ttfamily,
  commentstyle=\color{eclipseStrings}, % style of comment
  stringstyle=\color{eclipseKeywords}, % style of strings
  numbers=left,
  numberstyle=\scriptsize,
  stepnumber=1,
  numbersep=8pt,
  showstringspaces=false,
  breaklines=true,
  frame=lines,
  % backgroundcolor=\color{gray}, %only if you like
  string=[s]{"}{"},
  comment=[l]{:\ "},
  morecomment=[l]{:"},
  literate=
      *{0}{{{\color{numb}0}}}{1}
       {1}{{{\color{numb}1}}}{1}
       {2}{{{\color{numb}2}}}{1}
       {3}{{{\color{numb}3}}}{1}
       {4}{{{\color{numb}4}}}{1}
       {5}{{{\color{numb}5}}}{1}
       {6}{{{\color{numb}6}}}{1}
       {7}{{{\color{numb}7}}}{1}
       {8}{{{\color{numb}8}}}{1}
       {9}{{{\color{numb}9}}}{1}
}

\lstset{
  % everything between (* *) is a latex command
  escapeinside={(*}{*)},
  %
  language=json,
  %
  showstringspaces=false,
  %
  extendedchars=true,
  %
  basicstyle=\footnotesize\ttfamily,
  %
  commentstyle=\slshape,
  %
  % default: \rmfamily
  stringstyle=\ttfamily,
  %
  breaklines=true,
  %
  breakatwhitespace=true,
  %
  % alternative: fixed
  columns=flexible,
  %
  numbers=left,
  %
  numberstyle=\tiny,
  %
  basewidth=.5em,
  %
  xleftmargin=.5cm,
  %
  % aboveskip=0mm,
  %
  % belowskip=0mm,
  %
  captionpos=b
}

% Enable Umlauts when using \lstinputputlisting.
% See https://stackoverflow.com/a/29260603/873282 für details.
% listingsutf8 did not work in June 2020.
\lstset{literate=
  {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
  {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
  {à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
  {À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
  {ä}{ä}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{ö}1 {ü}{{\"u}}1
  {Ä}{ä}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{ö}1 {Ü}{{\"U}}1
  {â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1
  {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
  {Ã}{{\~A}}1 {ã}{{\~a}}1 {Õ}{{\~O}}1 {õ}{{\~o}}1
  {œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1
  {ű}{{\H{u}}}1 {Ű}{{\H{U}}}1 {ő}{{\H{o}}}1 {Ő}{{\H{O}}}1
  {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
}

% Allows for column type X
% In tabularx environment, e.g., \begin{tabularx}{\textwidth}{lX}
\RequirePackage{tabularx}
% Definition of booktabs commands (\toprule, \midrule, \bottomrule)
% without booktabs package:
% (However, the smallskip still breaks vertical lines!)
\newcommand{\toprule}{\hline\noalign{\smallskip}}
\newcommand{\midrule}{\noalign{\smallskip}\hline\noalign{\smallskip}}
\newcommand{\bottomrule}{\noalign{\smallskip}\hline}

% Extended enumerate, such as \begin{compactenum}
\RequirePackage[alwaysadjust]{paralist}

% Read: Is there a disadvantage to using natbib=true with biblatex?
% https://tex.stackexchange.com/questions/149313
% /is-there-a-disadvantage-to-using-natbib-true-with-biblatex
% Substitutions:
% Natbib \textcite = biblatex \textcite 
% Natbib \citep = biblatex \parencite

\RequirePackage[
    defernumbers=true,  % required due to self-cite
    %style=ieee,        % english only
    sorting=none,       % nty, nyt, nyvt, anyt, anyvt, ynt, ydnt, none, debug
    sortcites=false,
    citestyle=numeric-comp, % BEWARE: ieee-comp would be preferred, but Overleaf does currently NOT support ieee-comp :-(
    bibstyle=numeric,
    backend=biber,
    bibencoding=utf8,   % = auto, utf8, ascii
    hyperref=true,      % activate hyperref support
    backref=false,      % activate backrefs
    isbn=true,
    url=true,
    doi=true,
    urldate=terse,      % = iso, year, short, long, terse
    maxnames=5,         % max number of names in text ??
    minnames=1,         % min number of names in text ??
    maxbibnames=99,     % max number of names in bibliography
    minbibnames=1,      % number of names in bibliography (bevor et al)
    maxcitenames=99,    % max number of names in text ??
    mincitenames=1,     % max number of names in text ??
    giveninits=false,   % abbreviate first names
    uniquename=init,    % otherwise option conflict with firstinits=true
    autolang=other
]{biblatex}

% Due to applied option defernumbers=true:
% Prevent citations in the references are being numbered as '0' in ArXiv
% https://tex.stackexchange.com/questions/463556
% /all-the-citations-in-the-references-are-being-numbered-as-0-in-arxiv-while-upl
\makeatletter
\let\blx@rerun@biber\relax
\makeatother

% selfref.bib needs to be generated, containing a bibentry with key selfref
\addbibresource{selfref.bib}
\DeclareBibliographyCategory{selfref}
\addtocategory{selfref}{selfref}
% How to use: \printbibliography[notcategory=selfref]

% Same fontsize as without natbib
\renewcommand{\bibfont}{\normalfont\small}

% Zotero generates wrong language fields with wrong "en"
% instead of correct "english" option, thus, despite
% default biblatex clearlang, the "en" will incorrectly
% be printed out, even in english papers.
% Make "en" equivalent to "english" and/or its derivatives:
\DeclareRedundantLanguages{en}{english,american,british,
  canadian,australian,newzealand,USenglish,UKenglish}

% Enable hyperlinked author names in the case of \textcite
% Source: https://tex.stackexchange.com/a/76075/9075
\RequirePackage{etoolbox}
\makeatletter
\patchcmd{\NAT@test}{\else \NAT@nm}{\else \NAT@hyper@{\NAT@nm}}{}{}
\makeatother

\makeatletter
\DeclareCiteCommand{\citemonth}
  {\usebibmacro{prenote}}
  {%
    \let\oldabx@bibmonth\abx@bibmonth%
    \setkeys{blx@opt@pre}{dateabbrev=false}% nowork
    \mkbibmonth{\thefield{month}}%
    \let\abx@bibmonth\oldabx@bibmonth% restore
  }
  {\multicitedelim}
  {\usebibmacro{postnote}}
\makeatother

%% Enable nice TODO comments
\RequirePackage[colorinlistoftodos,prependcaption,textsize=tiny]{todonotes}
\newcommand{\TODO}[1]{\todo[%
linecolor=red,backgroundcolor=red!25,bordercolor=red]{#1}}

% bring the table caption in the same line as label "Table I"
\usepackage{etoolbox}
\makeatletter
\patchcmd{\@makecaption}
  {\\}
  {.\ }
  {}
  {}
\makeatother

% For controlling the placement of the captions
% (table: top | figure: bottom), the package caption
% recommends to use package floatrow:
% (Without foatrom, the positioning is determined by
%  the textual (!) position of command \label in relation to
%  includegraphics/begin-tabular; a well-known latex aspect.)
\RequirePackage{floatrow}
\floatsetup[table]{capposition=top,captionskip=5pt}
\floatsetup[figure]{capposition=bottom,captionskip=8pt}

% Put footnotes below floats
% Source: https://tex.stackexchange.com/a/32993/9075
% and allow floats in a twocolumn document with [t] or [b]
\RequirePackage{stfloats}
\fnbelowfloat

\RequirePackage[group-minimum-digits=4,per-mode=fraction]{siunitx}
\addto\extrasgerman{\sisetup{locale = DE}}

% Enable that parameters of \cref{}, \ref{}, \cite{}, ...
% are linked so that a reader can click on the number
% and jump to the target in the document
\RequirePackage{hyperref}

% Enable hyperref without colors and without bookmarks
\hypersetup{
  hidelinks,
  colorlinks=true,
  allcolors=black,
  pdfstartview=Fit,
  breaklinks=true
}

% Enable correct jumping to figures when referencing
\RequirePackage[all]{hypcap}

\RequirePackage{orcidlink}

% For easy quotations: \enquote{text}
% This package is very smart when nesting is applied,
% otherwise textcmds (see below) provides a shorter command
\RequirePackage[autostyle=true]{csquotes}

% Enable using "`quote"'
% See: https://tex.stackexchange.com/a/150954/9075
\defineshorthand{"`}{\openautoquote}
\defineshorthand{"'}{\closeautoquote}

% amsmath must be loaded before cleveref
\usepackage{amsmath,amssymb,amsfonts}

% Extensions for references inside the document (\cref{fig:sample}, ...)
% Enable usage \cref{...} and \Cref{...} instead of \ref:
% Type of reference included in the link.
% That means, "Figure 5" is a full link instead of just "5".
% !! Underlying rules for "capitalize" and "noabbrev": APA style
% http://www.sagepub.com/upm-data/27160_APA_Style.pdf
% Use a capital letter "S" when saying "In Section 2, we..."
% Don't use capital letters when saying "There are four sections, ..."
% Capitalize when figure is followed by a number, e.g., "In Figure 3, we...."
% Don't use when no number follows, e.g., "The two figures ..."
% (Please notice: CMOS would prefer lower letters, in contrast to APA.)
\RequirePackage[capitalise,nameinlink,noabbrev]{cleveref}

\crefname{listing}{Listing}{Listings}
\Crefname{listing}{Listing}{Listings}
\crefname{lstlisting}{Listing}{Listings}
\Crefname{lstlisting}{Listing}{Listings}

\RequirePackage{lipsum}

\RequirePackage{tcolorbox}
\tcbuselibrary{listings}

%introduce \powerset
% See: http://matheplanet.com/matheplanet/nuke/
% html/viewtopic.php?topic=136492&post_id=997377
\DeclareFontFamily{U}{MnSymbolC}{}
\DeclareSymbolFont{MnSyC}{U}{MnSymbolC}{m}{n}
\DeclareFontShape{U}{MnSymbolC}{m}{n}{
  <-6>    MnSymbolC5
  <6-7>   MnSymbolC6
  <7-8>   MnSymbolC7
  <8-9>   MnSymbolC8
  <9-10>  MnSymbolC9
  <10-12> MnSymbolC10
  <12->   MnSymbolC12%
}{}
\DeclareMathSymbol{\powerset}{\mathord}{MnSyC}{180}

\RequirePackage{xspace}
%\newcommand{\eg}{e.\,g.,\xspace}
%\newcommand{\ie}{i.\,e.,\xspace}
\newcommand{\eg}{e.\,g.,\ }
\newcommand{\ie}{i.\,e.,\ }

% Enable hyphenation at other places as the dash.
% Example: application\hydash specific
\makeatletter
\newcommand{\hydash}{\penalty\@M-\hskip\z@skip}
% Definition of "=
% See: http://mirror.ctan.org/macros/latex
% /contrib/babel-contrib/german/ngermanb.dtx
\makeatother

% Enable copy and paste of text from the PDF
% Only required for pdflatex. It "just works" in the case of lualatex.
\input glyphtounicode
\pdfgentounicode=1

\RequirePackage{lscape}
\RequirePackage{pdflscape}
\RequirePackage{afterpage}

% requires, e.g., \PassOptionsToPackage{
% type=CC,modifier=by,version=4.0}{doclicense} before \documentclass
\RequirePackage[hyperxmp=false,lang=English]{doclicense}

% Improve wrapping of URLs
% See: http://tex.stackexchange.com/a/10419/9075
\makeatletter
\def\ps@IEEEtitlepagestyle{
  \def\@oddfoot{\mycopyrightnotice}
  \def\@evenfoot{}
}
\def\mycopyrightnotice{
  {\footnotesize
    \begin{minipage}{0.8\textwidth}
  \centering
    % License based on doclicense package:
    \href{\doclicenseURL}{\doclicenseIcon{}
    This work is licensed under a \doclicenseLongNameRef{}
    (\doclicenseNameRef{}) license.}
    % Citation advice:
    \\Please cite as: \fullcite{selfref}.
  \end{minipage}
  }
}
\makeatother

\makeatletter
% allows for forcing command expansion inside a filecontents* environment
% (cf. https://tex.stackexchange.com/questions/534035
% /macros-commands-inside-a-filecontents-environment-does-not-expand)
\def\filecontentsForceExpansion#1#2#3{
  \global\let\ltxspecials\dospecials
  \gdef\dospecials{\ltxspecials
    \catcode`#1=0
    \catcode`#2=1
    \catcode`#3=2
    \global\let\dospecials\ltxspecials
  }
}
\makeatother

\title{\cstechrepTitleTex}

\author{
\IEEEauthorblockN{\cstechrepAuthorListTex}
\IEEEauthorblockA{%
\cstechrepDepartment\\
\cstechrepInstitution\\
\cstechrepAddress
}}

\IEEEspecialpapernotice{\cstechrepType: \cstechrepNumber, 
\citemonth{selfref} \cstechrepYear}

% subfigure captions with parentheses and footnotesize:
\ifnum\value{cstechrep@subfigtracker}=1
  \typeout{cs-techrep class: load subfig package (use subfloat command).}
  \RequirePackage[caption=false,font=footnotesize]{subfig}
\fi
\ifnum\value{cstechrep@subcaptiontracker}=1
  \typeout{cs-techrep class: load subcaption package (use subfigure command).}
  \RequirePackage{subcaption}
  \captionsetup[subfigure]{labelformat=parens,font=footnotesize}
\fi

% Balance/level columns at the last page / in bibliography
% DISCLAIMER: No solution is a 100%/perfect one!
% Mainstream option: pbalance (see https://ctan.org/pkg/pbalance)
% BUT: incompatible with arxiv automated process (!)
\ifnum\value{cstechrep@pbalancetracker}=1
  \typeout{cs-techrep class: load pbalance package.}
  \RequirePackage{pbalance}
\fi
% Flushend => works with arxiv, but major incampatibility with lineno
% (and, thus, also with mindflow et al.)
\ifnum\value{cstechrep@flushendtracker}=1
  \typeout{cs-techrep class: load flushend package.}
  \RequirePackage{flushend}
\fi

% ========================================================
% Packages that need to be loaded last:

% Allows to hyphenate a word that contains a dash:
% https://stackoverflow.com/questions/2193307
% /how-do-i-get-latex-to-hyphenate-a-word-that-contains-a-dash
% Use \-/ for a breakable dash that does not prevent the remainer
% of the word to be hyphenated.
\RequirePackage[shortcuts]{extdash} 
% ========================================================

% Finally, we'll use \endinput to indicate that LaTeX can stop reading
% this file. LaTeX will ignore anything after this line.
\endinput
