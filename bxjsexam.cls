\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bxjsexam}[03/12/2018 v0.4 BXJS exam class]

\gdef\@shorttitleoption{\underline{\bfseries\large \@title}}

\DeclareOption{portrait}{%
 \let\@portrait\relax%
}

\DeclareOption{a3paper}{%
 \PassOptionsToClass{a3paper,twocolumn}{bxjsarticle}%
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

\DeclareOption{questionnaire}{%
 \let\@questionnaire\relax%
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

\ifdefined\@portrait
\else
 \PassOptionsToClass{landscape}{bxjsarticle}%
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

\ifdefined\@questionnaire
 \RequirePackage{tikzpagenodes}
 \RequirePackage{xcolor}
 \colorlet{grey}{black!20}
 \usetikzlibrary{calc}
 \usetikzlibrary{backgrounds}
\fi

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

% Define DrawLeagalPadLines for questionnaire option.
\ifdefined\@questionnaire
 \newcommand*{\DrawLegalPadLines}[2]{%
 \begin{tikzpicture}[remember picture, overlay]
 \begin{pgfonlayer}{background}
 \foreach \fila in {0,...,#2}
 {
 \draw[line width=0.2mm,grey] ($(current page.west|-0in,-\fila*#1-\fila*8pt) + (0.7in, 0in)$) -- ++(\paperwidth-1.05in,0);
 }
 \draw[overlay, line width=0.2mm] ($(current page text area.north west) + (0cm, -0.6in)$) rectangle (current page text area.south east);
 \end{pgfonlayer}
 \end{tikzpicture}}
\fi

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
\ifdefined\@questionnaire
 \renewcommand{\maketitle}{\vbox{\vspace{\@otherpageheaderheight}}}
\else
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
   \newcommand{\unitedcolumnswithcmmt}[2]{\hline\multicolumn{\numexpr#1-1}{|>{\columncolor[gray]{.9}}c|}{\large \stepcounter{psectionnumber}\the\value{psectionnumber}} & (#2) \tabularnewline\hline}
  \else
  \fi
 \fi
\fi

 \newcommand{\InitGeometries}{\geometry{textheight=9in, textwidth=6.in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}
 %\newcommand{\InitGeometries}{\geometry{textheight=10.8in, textwidth=7.4in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}

% Define class and student number width in name field.
\def\numunderlinewidth{xxxxx}
% Define name width in name field.
\def\nameunderlinewidth{xxxxxxxxxxxxxxx}

% For the clash of rerunfilecheck and ifxetex styles in the preamble.
% a3paper geometry and a4paper geometry with switching by a3paper option.
\ifdefined\@athreeenable
 \ifdefined\@portrait
  \renewcommand{\InitGeometries}{\geometry{textheight=14.9in, textwidth=11in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}
  %\renewcommand{\InitGeometries}{\geometry{textheight=10.8in, textwidth=15.8in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}

  \def\numunderlinewidth{xxx}
  \def\nameunderlinewidth{xxxxxxxxxxx}
 \else
  \renewcommand{\InitGeometries}{\geometry{textheight=9in, textwidth=12.8in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}
  %\renewcommand{\InitGeometries}{\geometry{textheight=10.8in, textwidth=15.8in, top=0.4in, headsep=0.2in, footskip=0.3in, nohead, nofoot}}
 \fi
\else
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
\newcommand{\createnamefieldforquentionnaire}{\@shorttitleoption \begin{flushright}\@class\underline{\phantom{xxxxx}}年\@classaux\underline{\phantom{xxxxx}}番 氏名\underline{\phantom{xxxxxxxxxxxxxxx}}\end{flushright}}

% Printed namefield
\newcommand{\createnamefieldwithpagenumbertwosided}{\begin{tcolorbox}[sidebyside,sharp corners, colback=white, enhanced, segmentation style={solid}, boxrule=0.5pt, valign=top, box align=base, sidebyside align=top, lefthand ratio=0.37]
指示事項\\
1. 持込物品: \@use\\
2. 用紙: 問題用紙\@papers 枚
\tcblower
題目: \@title（担当: \@author）\\
試験日時: \@date {\hfill\large\divtwo{\thepage}/\divtwo{\LastPageNumber}}\\
\@class\underline{\phantom{\numunderlinewidth}}年\@classaux\underline{\phantom{\numunderlinewidth}}番 氏名\underline{\phantom{\nameunderlinewidth}} 
\end{tcolorbox}}

% Printed namefield
\newcommand{\createnamefieldwithpagenumber}{\begin{tcolorbox}[sidebyside,sharp corners, colback=white, enhanced, segmentation style={solid}, boxrule=0.25pt, valign=top, box align=base, sidebyside align=top, lefthand ratio=0.37]
指示事項\\
1. 持込物品: \@use\\
2. 用紙: 問題用紙\@papers 枚
\tcblower
\@title {\hfill\large\thepage/\LastPageNumber}\\
担当: \@author\hspace{0.5pc}/\hspace{0.5pc}\@date\\
\@class\underline{\phantom{\numunderlinewidth}}年\@classaux\underline{\phantom{\numunderlinewidth}}番 氏名\underline{\phantom{\nameunderlinewidth}} 
\end{tcolorbox}}

% Printed namefield
\newcommand{\createnamefieldwithoutpagenumber}{\begin{tcolorbox}[sidebyside,sharp corners, colback=white, enhanced, segmentation style={solid}, boxrule=0.25pt, valign=top, box align=base, sidebyside align=top, lefthand ratio=0.37]
指示事項\\
1. 持込物品: \@use\\
2. 用紙: 問題用紙\@papers 枚
\tcblower
\@title \\
担当: \@author\hspace{0.5pc}/\hspace{0.5pc}\@date\\
\@class\underline{\phantom{\numunderlinewidth}}年\@classaux\underline{\phantom{\numunderlinewidth}}番 氏名\underline{\phantom{\nameunderlinewidth}}
\end{tcolorbox}}

\newcounter{problemctr}[section]

%% problem environment

\newenvironment{problem}{%
 \refstepcounter{problemctr}
 \textsc{(\theproblemctr)}
}{\par\medskip}

\newcommand{\filledAnswerColumn}[1][]{\def\facarg{#1}\ifx\facarg\empty\fbox{\parbox{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}{\phantom{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX} \relax \phantom{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XXXXXXXXXXXXXXXXXXXXXXXX}}}\else\begingroup\setlength{\fboxsep}{0.8pc}\fbox{\parbox{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}{#1}}\endgroup\fi}

\newcommand{\shortAnswerColumn}[1][]{\def\sacarg{#1}\ifx\sacarg\empty\fbox{\parbox{2pc}{\phantom{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX} \relax \phantom{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}}}\else\begingroup\setlength{\fboxsep}{0.9pc}\framebox[2.5pc][c]{#1}\endgroup\fi}

%%%

\newskip\mcitemsep % glue separating the (.) from the text of each option (can be modified by user)
\mcitemsep=.5em
\newskip\mcinteritemskip % glue that goes between items on each line (can be modified by user)
\mcinteritemskip=1em

\newcounter{mccount}

\def\mcitembox(#1)#2{\hbox{\textbf{(#1)}\hspace\mcitemsep#2}}

\newcounter{mcs@lcount}

\def\isc@rrect{%
\addtocounter{mcs@lcount}{1}%
\def\n@xt{\ifx\n@@xt!\expandafter\c@rrect\fi}%
  \futurelet\n@@xt\n@xt}

\newcommand{\createChoices}[6][0]{%
\setcounter{mcs@lcount}{0}
\ifnum #1=0
\multch@ice{\isc@rrect#2}{\isc@rrect#3}{\isc@rrect#4}{\isc@rrect#5}{\isc@rrect#6}
\else
\multch@ice{\isc@rrect#2}{\isc@rrect#3}{\isc@rrect#4}{\isc@rrect#5}{\isc@rrect#6}
%currently there is no loose form of regular multiple choice.
\fi}

\newcommand{\multch@ice}[5]{%
\setbox0\mcitembox(a){#1}%
\setbox2\mcitembox(b){#2}%
\setbox4\mcitembox(c){#3}%
\setbox6\mcitembox(d){#4}%
\setbox8\mcitembox(e){#5}%
%
% Find the maximal length:
%
\dimen0=\wd0 \ifdim\wd2>\dimen0 \dimen0=\wd2 \fi\ifdim\wd4>\dimen0
\dimen0=\wd4 \fi\ifdim\wd6>\dimen0 \dimen0=\wd6 \fi\ifdim\wd8>\dimen0
\dimen0=\wd8 \fi%
%
% If the resulting length is more than \textwidth, we have to unbox the items and typeset them differently:
%
\ifdim\dimen0>\textwidth
\bgroup%
\begin{list}{\textbf{(\alph{mccount})}}{\usecounter{mccount}\setlength\labelsep\mcitemsep\setbox0=\hbox{\textbf{(a)}\hspace\mcitemsep}\setlength\labelwidth{\wd0}}
\item #1
\item #2
\item #3
\item #4
\item #5
\end{list}
\egroup%
\else
%
% Make all the boxes of the same length:
%
\wd0=\dimen0 \wd2=\dimen0 \wd4=\dimen0 \wd6=\dimen0 \wd8=\dimen0%
\bgroup%
\par%
%\openup\baselineskip
\tolerance=10000
\noindent\box0\hskip\mcinteritemskip\penalty9000\box2\hskip\mcinteritemskip\penalty6000\box4\hskip\mcinteritemskip\penalty3000\box6\hskip\mcinteritemskip\penalty1000\box8\hfill\par\egroup%
\fi}

%%%

\RequirePackage{enumitem}

\gdef\Katakana#1{\expandafter\@Katakana\csname c@#1\endcsname}

\gdef\@Katakana#1{\ifcase#1\or ア\or イ\or ウ\or エ\or オ\or カ\or キ\or ク\fi}

\AddEnumerateCounter{\Katakana}{\@Katakana}{ア}


\ifdefined\@questionnaire
 \fancypagestyle{examstyle}{%
 
  \fancyhead[LO]{\parbox{\columnwidth}{\ifnum\value{page}=1\@fancymaintitle\else\fi \createnamefieldforquentionnaire}}}
 \let\latex@outputpage\@outputpage
 \def\@outputpage{
  %\pgfmathparse{int(mod(\value{page},2))}%
  %\ifnum\pgfmathresult=0\noindent\vspace{3pc}\relax\vbox{\relax TOMBO}\else\fi
  \ifodd\value{page}
   \else\ifnum\value{page}<\LastPageNumber\noindent\vspace{\@otherpageheaderheight}\relax\vbox{\relax}\else\fi
  \fi
  \latex@outputpage
 }
 \pagestyle{examstyle}
\else
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
      \fancyfoot[LE]{\centering\hspace{-43.5pc}\thepage/\LastPageNumber}
      \fancyfoot[LO]{\centering\hspace{43.5pc}\thepage/\LastPageNumber}
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
      \fancyfoot[LE]{\centering\hspace{-43.5pc}\thepage/\LastPageNumber}
      \fancyfoot[LO]{\centering\hspace{43.5pc}\thepage/\LastPageNumber}
     \fi}
    \pagestyle{examstyle}}
   \else
    \pagestyle{fancy}
   \fi
  \fi
 \fi
\fi

% Double Underline
\def\duline#1{\underline{\underline{#1}}}

%%
%% End of file `bxjsexam.cls'.
