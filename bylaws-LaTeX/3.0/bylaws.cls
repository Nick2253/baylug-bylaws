% bylaws.cls
% Format for Bylaws
% 2012-Oct-27 Nicholas Card nick2253 (at) gmail.com
% --- Class structure: identification part
% ---
\ProvidesClass{bylaws}[2012/10/27 version 0.01 "alpha" Bylaws]
\NeedsTeXFormat{LaTeX2e}

% --- Class structure: declaration of options part
% ---
% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.bylaws" exists, then it is loaded
\DeclareOption*{\InputIfFileExists{\CurrentOption.bylaws}{}{%
\PassOptionsToClass{\CurrentOption}{article}}}

% --- Class structure: execution of options part
% ---
\ProcessOptions \relax

% --- Class structure: declaration of options part
% ---
\LoadClass{article}


% --- Required packages
% ---
\RequirePackage[utf8]{inputenc}% Allows more characters to be used in text
\RequirePackage[margin=1in]{geometry}% Sets page margins
\RequirePackage{parskip}% Sets page to business format
\RequirePackage{titlesec}% Allows customizing section formats
\RequirePackage{enumitem}% Allows removing list spaces
\RequirePackage{fancyhdr}% Allows customizing header/footer
\RequirePackage{hyperref}% Creates document hyperlinks and allows URLs
\RequirePackage{color}%  Allows text color for commenting during drafting
\RequirePackage{lastpage}% Creates label LastPage for the last page.
\RequirePackage{xspace}% Allows automatic handling of space after macros
\RequirePackage{graphicx}% Allows adding images to documents

% --- New Commands
% ---

% Club Name, Logo, Version, Date, Status information

\newcommand{\version}[1]{\def\@bylawsver{#1}}

\renewcommand{\date}[1]{\def\@bylawsdate{#1}}

\newif\if@draft
\@draftfalse
\newcommand{\draft}{\@drafttrue}

\newcommand{\name}[2][\@empty]{\def\@name{#2}\ifx#1\@empty\def\@nickname{#2}\else\def\@nickname{#1}\fi}

\newcommand{\logo}[2][]{\def\@logoopts{#1}\def\@logoimage{#2}}

% Properly clear the global variables and commands
\version{0.0}
\date{\today}
\name{}
\logo{}


% Article and Section Numbering

\newcommand{\article}[2]{\subtitle{#2} \section{#1}}
\renewcommand{\sec}[1]{\subsection{#1}}
\newcommand{\subsec}[1]{\subsubsection{#1}}

% Subtitle for sections

\newcommand*{\sectionpostamble}{}
\newcommand*{\subtitle}[1]{%
  \def\sectionpostamble{#1}%
}

%Page Numbering and Footer


% Other Useful Commands
%
% Horizontal Lines

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

% Superscript and Subscript Commands

\newcommand\textsubscript[1]{\@textsubscript{\selectfont#1}}
\def\@textsubscript#1{{\m@th\ensuremath{_{\mbox{\fontsize\sf@size\z@#1}}}}}
\newcommand\textbothscript[2]{%
  \@textbothscript{\selectfont#1}{\selectfont#2}}
\def\@textbothscript#1#2{%
  {\m@th\ensuremath{%
    ^{\mbox{\fontsize\sf@size\z@#1}}%
    _{\mbox{\fontsize\sf@size\z@#2}}}}}
\def\@super{^}\def\@sub{_}

\catcode`^\active\catcode`_\active
\def\@super@sub#1_#2{\textbothscript{#1}{#2}}
\def\@sub@super#1^#2{\textbothscript{#2}{#1}}
\def\@@super#1{\@ifnextchar_{\@super@sub{#1}}{\textsuperscript{#1}}}
\def\@@sub#1{\@ifnextchar^{\@sub@super{#1}}{\textsubscript{#1}}}
\def^{\let\@next\relax\ifmmode\@super\else\let\@next\@@super\fi\@next}
\def_{\let\@next\relax\ifmmode\@sub\else\let\@next\@@sub\fi\@next}

% Leading zero numbering

\newcommand{\twodigits}[1]{\ifnum\value{#1}<10 0\fi\arabic{#1}}

% LEGO

\newcommand{\LEGO}{LEGO^{\textregistered}\xspace}

% Command for Note Text

\newcommand{\note}[1]{\footnotesize \textcolor{red}{\textit{#1}}}

% --- Formatting Issues
% ---

% Title and Heading

\renewcommand{\maketitle}{%
\begin{center}
\expandafter\includegraphics\expandafter[\@logoopts]{\@logoimage}

\HRule \\[0.4cm]
{ \LARGE \bfseries \@name{} Bylaws }\\

\HRule \\
\textsc{\if@draft DRAFT \fi Revision \@bylawsver{}, \if@draft Proposed \else Approved \fi\@bylawsdate{}}
\end{center}%
}

% Section Numbering and Spacing

\renewcommand{\thesection}{Article \arabic{section}}
\renewcommand{\thesubsection}{Section \arabic{section}.\twodigits{subsection}}
\renewcommand{\thesubsubsection}{Subsection \arabic{section}.\twodigits{subsection}(\alph{subsubsection})}

\renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname . }

\titleformat{\section}{\normalfont\Large\bfseries}{\thesection . }{0pt}{}
  [\normalfont\small\itshape\raggedright\sectionpostamble
  \global\let\sectionpostamble\relax]

% Header and Footer

\pagestyle{fancy}
\fancyhf{} % clear all header and footer fields
\fancyfoot[R]{\footnotesize Page \thepage\ of \pageref*{LastPage}}
\fancyfoot[L]{\footnotesize \if@draft DRAFT \fi\@nickname{} Bylaws Revision \@bylawsver{}, \if@draft proposed \else approved \fi\@bylawsdate{}.}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}  

% Other Formatting Issues
%
%Fix List Spacing
\setlist{nolistsep}
