\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bxjsexam}[20/11/2018 v0.3 BXJS exam class]

\gdef\@shorttitleoption{{\LARGE\bfseries \@title}}
\gdef\@titleoption{}

\DeclareOption{a3paper}{%
 \PassOptionsToClass{a3paper,landscape,twocolumn}{bxjsarticle}%
 %\typeout{a3paper!}%
 \let\@athreeenable\relax%
}
\DeclareOption{namefield}{%
 \let\@namefieldenable\relax%
 \DeclareOption{both}{\gdef\@titleoption{\@shorttitleoption}}
}

\DeclareOption{numbering}{%
 \let\@numbering\relax%
}

\DeclareOption*{%
 \PassOptionsToClass{\CurrentOption}{bxjsarticle}%
}
\ProcessOptions\relax


% Define class options for left equation number and float left equations as global options.
% Cannot be affected the document by passing options to LoadClass func.
\@expandtwoargs\in@{leqno}{\@classoptionslist}
\ifin@
\else
 \ifx\@classoptionslist\@empty
  \g@addto@macro\@classoptionslist{leqno}
 \else
  \g@addto@macro\@classoptionslist{,leqno}
 \fi
\fi
\@expandtwoargs\in@{fleqn}{\@classoptionslist}
\ifin@
\else
 \ifx\@classoptionslist\@empty
  \g@addto@macro\@classoptionslist{fleqn}
 \else
  \g@addto@macro\@classoptionslist{,fleqn}
 \fi
\fi

% For header and footer by fancyhdr package
\ifdefined\@athreeenable
\else
 \PassOptionsToClass{twoside}{bxjsarticle}
\fi

% Enable to use Japanese in Math mode.
\PassOptionsToClass{enablejfam=true}{bxjsarticle}
% Specify Latex engine.
\PassOptionsToClass{xelatex}{bxjsarticle}

\LoadClass{bxjsarticle}

\RequirePackage{caption}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\RequirePackage[skins, hooks]{tcolorbox}

% tabularx settings for tcolorbox.
\newcolumntype{Y}{>{\centering}m{2cm}}
\renewcommand\tabularxcolumn[1]{m{#1}}
% TabularX Row Height
\setlength{\extrarowheight}{5pt}

\XeTeXlinebreaklocale "ja"

\renewcommand\section{\@startsection{section}{1}{\z@}{\z@}{\z@}{\bfseries\large\headfont\setcounter{equation}{0}}}

% Define class variable
\newcommand*{\class}[1]{\gdef\@class{#1}}
\AtBeginDocument{\let\class\@class}
% Define use variable
\newcommand*{\use}[1]{\gdef\@use{#1}}
\AtBeginDocument{\let\use\@use}
% Define papers variable
\newcommand*{\papers}[1]{\gdef\@papers{#1}}
\AtBeginDocument{\let\papers\@papers}
% Define classaux variable
\newcommand*{\classaux}[1]{\gdef\@classaux{#1}}
\AtBeginDocument{\let\classaux\@classaux}
\classaux\relax

\use{なし}
\papers{1}

% Define a maketitle
\ifdefined\@namefieldenable
\renewcommand{\maketitle}{\@titleoption\begin{tcolorbox}[sidebyside,sharp corners, colback=white, enhanced, segmentation style={solid}, boxrule=0.5pt, valign=top, box align=base, sidebyside align=top, lefthand ratio=0.35]
指示事項\\
1. 持ち込み可能物品: \@use\\
2. 必要な用紙: 問題用紙\@papers 枚
\tcblower
題目: \@title（担当: \@author）\\
試験日時: \@date\\
\@class\underline{\phantom{xxxxxx}}年\@classaux\underline{\phantom{xxxxxxxx}}番 氏名\underline{\phantom{xxxxxxxxxxxxxxxxxxxxxxxxx}}
\end{tcolorbox}}
\else
 \renewcommand{\maketitle}{\@shorttitleoption}
\fi


% For the clash of rerunfilecheck and ifxetex styles in the preamble.
% a3paper geometry and a4paper geometry with switching by a3paper option.
\ifdefined\@athreeenable
 \newcommand{\InitGeometries}{\geometry{textheight=9in, textwidth=12.8in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}
\else
 \newcommand{\InitGeometries}{\geometry{textheight=9in, textwidth=6.in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}
\fi

\RequirePackage{fancyhdr}
\renewcommand{\plainifnotempty}{\relax}
\fancyhead{}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}

\ifdefined\@numbering
 \RequirePackage{lastpage}
 \ifdefined\@athreeenable
  \fancypagestyle{examstyle}{%
  \lhead{\vspace{-1pc}\parbox{2.075\columnwidth}{\hspace{-1.5pc}\large\thepage/\pageref{LastPage}\hfill}}}
 \else
  \fancypagestyle{examstyle}{%
  \fancyhead[LE]{\vspace{-1pc}\parbox{\columnwidth}{\hspace{-6.5pc}\large\thepage/\pageref{LastPage}\hfill}}
  \fancyhead[RO]{\vspace{-1pc}\parbox{1.035\columnwidth}{\hfill\large\thepage/\pageref{LastPage}}}}
 \fi
 \pagestyle{examstyle}
\else
 \pagestyle{fancy}
\fi

%%
%% End of file `bxjsexam.cls'.
