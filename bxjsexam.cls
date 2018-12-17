\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bxjsexam}[03/12/2018 v0.4 BXJS exam class]

\gdef\@shorttitleoption{{\LARGE\bfseries \@title}}

\DeclareOption{a3paper}{%
 \PassOptionsToClass{a3paper,landscape,twocolumn}{bxjsarticle}%
 %\typeout{a3paper!}%
 \let\@athreeenable\relax%
}
\DeclareOption{namefield}{%
 \let\@namefieldenable\relax%
 \DeclareOption{both}{
  \let\@bothenable\relax}
}

\DeclareOption{numbering}{%
 \let\@numbering\relax%
}

\DeclareOption{twoside}{%
 \let\@twosided\relax%
}

\DeclareOption{answers}{%
 \let\@answers\relax%
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
\RequirePackage{ifthen}

\RequirePackage{ifxetex}

\ifxetex
 \XeTeXlinebreaklocale "ja"
\else
\fi

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
% Define maintitle
\newcommand*{\maintitle}[1]{\gdef\@maintitle{#1}}
\AtBeginDocument{\let\maintitle\@maintitle}
\maintitle\relax

\gdef\@fancymaintitle{\ifdefined\@bothenable{\LARGE\bfseries \@maintitle\vspace{0.5pc}}\else\relax\fi}


\use{なし}
\papers{1}

% Define First Page Header Height
\gdef\@firstpageheaderheight{6.15pc}

\ifdefined\@athreeenable
 \gdef\@firstpageshortheaderheight{4.65pc}
\else
% \gdef\@firstpageshortheaderheight{3.65pc}
 \gdef\@firstpageshortheaderheight{4.65pc}
\fi

\gdef\@otherpageheaderheight{4.0pc}

% Define a maketitle
\ifdefined\@namefieldenable
 % tabularx settings for tcolorbox.
 \newcolumntype{Y}{>{\centering}m{2cm}}
 \renewcommand\tabularxcolumn[1]{m{#1}}
 % TabularX Row Height
 \setlength{\extrarowheight}{5pt}
 \ifdefined\@bothenable
  \renewcommand{\maketitle}{\vbox{\vspace{\@firstpageheaderheight}}}
 \else
  \renewcommand{\maketitle}{\vbox{\vspace{\@firstpageshortheaderheight}}}
 \fi
 \setlength{\extrarowheight}{0pt}
\else
 \renewcommand{\maketitle}{\@shorttitleoption}
 % Define the layout and commands for the example answers sheet.
 \ifdefined\@answers
  \RequirePackage{diagbox}
  \newcommand{\backslashing}{\backslashbox[\linewidth]{\vphantom{1}}{\vphantom{1}}}
  \renewcommand{\tabularxcolumn}[1]{m{#1}}
  \newcolumntype{Z}{>{\centering\arraybackslash}X}
  \newcommand{\setrowpaddingscalingfactor}[1]{\renewcommand\arraystretch{#1}}
  \newcounter{psectionnumber}
  \setcounter{psectionnumber}{0}
  \newcommand{\unitedcolumns}[1]{\hline\multicolumn{#1}{|>{\columncolor[gray]{.9}}c|}{\large \stepcounter{psectionnumber}\the\value{psectionnumber}} \tabularnewline\hline}
 \else
 \fi
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

\RequirePackage{zref-lastpage}
\newcommand{\LastPageNumber}{\zref@extractdefault{LastPage}{page}{0}}


% For calc twosided page number.
\newcount\halfnum
\def\divtwo#1{\ifnum#1=\numexpr(#1/2)*2 \halfnum=#1\divide \halfnum by 2\relax\the\halfnum\else\halfnum=#1\divide \halfnum by 2\advance \halfnum by 1\relax\the\halfnum\fi}

% Printed namefield
\newcommand{\createnamefieldwithpagenumbertwosided}{\begin{tcolorbox}[sidebyside,sharp corners, colback=white, enhanced, segmentation style={solid}, boxrule=0.5pt, valign=top, box align=base, sidebyside align=top, lefthand ratio=0.35]
指示事項\\
1. 持ち込み可能物品: \@use\\
2. 必要な用紙: 問題用紙\@papers 枚
\tcblower
題目: \@title（担当: \@author）\\
試験日時: \@date\\
\@class\underline{\phantom{xxxxxx}}年\@classaux\underline{\phantom{xxxxxxxx}}番 氏名\underline{\phantom{xxxxxxxxxxxxxxxxxxx}} {\hfill\large\divtwo{\thepage}/\divtwo{\LastPageNumber}}
\end{tcolorbox}}

% Printed namefield
\newcommand{\createnamefieldwithpagenumber}{\begin{tcolorbox}[sidebyside,sharp corners, colback=white, enhanced, segmentation style={solid}, boxrule=0.5pt, valign=top, box align=base, sidebyside align=top, lefthand ratio=0.35]
指示事項\\
1. 持ち込み可能物品: \@use\\
2. 必要な用紙: 問題用紙\@papers 枚
\tcblower
題目: \@title（担当: \@author）\\
試験日時: \@date\\
\@class\underline{\phantom{xxxxxx}}年\@classaux\underline{\phantom{xxxxxxxx}}番 氏名\underline{\phantom{xxxxxxxxxxxxxxxxxxx}} {\hfill\large\thepage/\LastPageNumber}
\end{tcolorbox}}

% Printed namefield
\newcommand{\createnamefieldwithoutpagenumber}{\begin{tcolorbox}[sidebyside,sharp corners, colback=white, enhanced, segmentation style={solid}, boxrule=0.5pt, valign=top, box align=base, sidebyside align=top, lefthand ratio=0.35]
指示事項\\
1. 持ち込み可能物品: \@use\\
2. 必要な用紙: 問題用紙\@papers 枚
\tcblower
題目: \@title（担当: \@author）\\
試験日時: \@date\\
\@class\underline{\phantom{xxxxxx}}年\@classaux\underline{\phantom{xxxxxxxx}}番 氏名\underline{\phantom{xxxxxxxxxxxxxxxxxxx}}
\end{tcolorbox}}


\ifdefined\@namefieldenable
 \ifdefined\@athreeenable
  \ifdefined\@numbering
   \ifdefined\@twosided
 
    \fancypagestyle{examstyle}{%
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithpagenumbertwosided}}}
 
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     \ifnum\value{page}<\LastPageNumber\ifodd\value{page}\else\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\fi\else\fi
     \latex@outputpage
    }
   \else
    \fancypagestyle{examstyle}{%
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithpagenumber}}}
 
    % After first page, put indent on the first of each page for the alignment of the name header on the background
    %\g@addto@macro\@outputpage{\ifnum\value{page}<\LastPageNumber\noindent\vspace{-5pc}\relax\vbox{\relax}\vbox{Not Last.}\else\fi}
    
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     \ifnum\value{page}<\LastPageNumber\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\else\fi
     \latex@outputpage
    }
   \fi
  \else
   \ifdefined\@twosided
 
    \fancypagestyle{examstyle}{%
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithoutpagenumber}}}
 
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     \ifnum\value{page}<\LastPageNumber\ifodd\value{page}\else\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\fi\else\fi
     \latex@outputpage
    }
 
   \else
    \fancypagestyle{examstyle}{%
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithoutpagenumber}}}
 
    % After first page, put indent on the first of each page for the alignment of the name header on the background
    %\g@addto@macro\@outputpage{\ifnum\value{page}<\LastPageNumber\noindent\vspace{-5pc}\relax\vbox{\relax}\vbox{Not Last.}\else\fi}
    
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     \ifnum\value{page}<\LastPageNumber\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\else\fi
     \latex@outputpage
    }
   \fi
  \fi
 \else
  \ifdefined\@numbering
   \ifdefined\@twosided
  
    \fancypagestyle{examstyle}{%
    
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithpagenumbertwosided}}}
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     %\pgfmathparse{int(mod(\value{page},2))}%
     %\ifnum\pgfmathresult=0\noindent\vspace{3pc}\relax\vbox{\relax TOMBO}\else\fi
     \ifodd\value{page}
      \else\ifnum\value{page}<\LastPageNumber\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\else\fi
     \fi
     \latex@outputpage
    }
   \else
    \fancypagestyle{examstyle}{%
    
     \fancyhead[LE]{\hspace{-5.32pc}\parbox{\columnwidth}{\createnamefieldwithpagenumber}}
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithpagenumber}}}
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     \ifnum\value{page}<\LastPageNumber\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\else\fi
     \latex@outputpage
    }
   \fi
  \else
   \ifdefined\@twosided
    \fancypagestyle{examstyle}{%
    
     %\fancyhead[LE]{\vspace{-1pc}\parbox{\columnwidth}{\hspace{-6.5pc}\large\thepage/\LastPageNumber\hfill}}
     %\fancyhead[RO]{\vspace{-1pc}\parbox{1.035\columnwidth}{\hfill\large\thepage/\LastPageNumber}}
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithoutpagenumber}}}
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     %\pgfmathparse{int(mod(\value{page},2))}%
     %\ifnum\pgfmathresult=0\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax TOMBO}\else\fi
     \ifodd\value{page}
      \else\ifnum\value{page}<\LastPageNumber\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\else\fi
     \fi
     \latex@outputpage
    }
  
   \else
    \fancypagestyle{examstyle}{%
    
     \fancyhead[LE]{\hspace{-5.32pc}\parbox{\columnwidth}{\createnamefieldwithoutpagenumber}}
     \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldwithoutpagenumber}}}
    \let\latex@outputpage\@outputpage
    \def\@outputpage{
     \ifnum\value{page}<\LastPageNumber\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\else\fi
     \latex@outputpage
    }
 
   \fi
  \fi
 \fi
 \pagestyle{examstyle}
\else
 \ifdefined\@athreeenable
  \ifdefined\@numbering
   \AtBeginDocument{\fancypagestyle{examstyle}{%
    \ifnum\pdfstrcmp{\thepage}{\LastPageNumber}=0
     \fancyfoot[LE]{\centering\thepage}
     \fancyfoot[LO]{\centering\thepage}
    \else
     \fancyfoot[LE]{\centering\hspace{-15.5pc}\thepage/\LastPageNumber}
     \fancyfoot[LO]{\centering\hspace{15.5pc}\thepage/\LastPageNumber}
    \fi}
   \pagestyle{examstyle}}
  \else
   \pagestyle{fancy}
  \fi
 \else
  \ifdefined\@numbering
   \AtBeginDocument{\fancypagestyle{examstyle}{%
    \ifnum\pdfstrcmp{\thepage}{\LastPageNumber}=0
     \fancyfoot[LE]{\centering\thepage}
     \fancyfoot[LO]{\centering\thepage}
    \else
     \fancyfoot[LE]{\centering\hspace{-15.5pc}\thepage/\LastPageNumber}
     \fancyfoot[LO]{\centering\hspace{15.5pc}\thepage/\LastPageNumber}
    \fi}
   \pagestyle{examstyle}}
  \else
   \pagestyle{fancy}
  \fi
 \fi
\fi


% Double Underline
\def\duline#1{\underline{\underline{#1}}}

%%
%% End of file `bxjsexam.cls'.
