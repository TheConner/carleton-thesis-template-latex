%%
%% This is file `cu-thesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cu-thesis.dtx  (with options: `package')
%% ----------------------------------------------------------------
%% Copyright 2022 Conner Bradley
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Conner Bradley
%% 
%% This work consists of the files cu-thesis.cls
%%                                 cu-thesis.dtx
%%                                 cu-thesis.ins
%%                                 cu-thesis.pdf
%% ----------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  cu-thesis implementation  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\cu@boolopt}[1]{%
    \expandafter\newif\csname ifcu@#1\endcsname\csname cu@#1false\endcsname%
    \DeclareOption{#1}{\csname cu@#1true\endcsname}%
}
%% declare all package options
%% scrbook - use the KOMA-script scrbook class instead of book
\cu@boolopt{scrbook}

%% listoffigures - puts the list of figures (after the TOC).
\cu@boolopt{listoffigures}

%% listoftables - puts the list of tables (after the TOC).
\cu@boolopt{listoftables}

%% glossary - puts the glossary (after the TOC).
\cu@boolopt{glossary}

%% index - puts the index at the end of the thesis.
\cu@boolopt{withindex}

%% final - puts the index at the end of the thesis.
\cu@boolopt{final}
%% For ease of use we will use the default \LaTeX \texttt{book} class. More advanced users may prefer to use KOMA-scripts \texttt{scrbook} class, which is also supported.
%%
%% The \texttt{book} and \texttt{scrbook} class arguments are not perfectly compatible, thus we have to conditionally enable some flags in certain classes.
\newcommand{\cu@idocclass}{book}
\ifcu@scrbook
    \renewcommand{\cu@idocclass}{scrbook}
\fi
\PassOptionsToClass{oneside}{\cu@idocclass}
\PassOptionsToClass{12pt}{\cu@idocclass}
\ifcu@final
    \PassOptionsToClass{final}{\cu@idocclass}
\fi
%% A noteworthy snippet: all undefined options get passed through to the
%% underlying document class. This way, you can directly interact with all
%% documented options for the document class we are building on.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\cu@idocclass}}
\ProcessOptions\relax
\LoadClass{\cu@idocclass}

\raggedbottom
%% At this point our document class is loaded. We can load in helpful dependencies we need.
\RequirePackage{xparse}
\RequirePackage[utf8]{inputenc}
\RequirePackage{calc}
\RequirePackage[
    pdffitwindow=true,
    pdfpagelabels=true,
    colorlinks=false,
    pdfborder={0 0 0},
    pdfusetitle=true
]{hyperref}
\RequirePackage[all]{hypcap}
\ifcu@glossary
    \RequirePackage[toc,nonumberlist,acronyms]{glossaries}
    \makeglossaries%
    \setglossarystyle{listdotted}
\fi
%% For page formatting, refer to the following Carleton guidelines for thesis formatting
%% All written and illustrative material on an 8 1\"\ x 11\"\ page, including page
%% numbers, must fall within the following margins: one and one-half inches on
%% the left margin and one full inch on the other three sides. Margins may be
%% wider but not narrower than the stated requirements.
%%
%% For theses written in landscape format, please allow one and one-half inches
%% on the top margin and one full inch on the other three sides.
%% Within this context, use the \texttt{geometry} package to format the page within these bounds. A noteworthy point is that all text \textit{including page numbers} must fall within these margins.
\RequirePackage[letterpaper]{geometry}
\newlength{\cu@bottom}
\newlength{\cu@marginparwidth}
\let\oldgeometry\geometry
\let\oldnewgeometry\newgeometry
\renewcommand{\geometry}[5][0.7]{
    \setlength{\cu@marginparwidth}{#2}
    \addtolength{\cu@marginparwidth}{-2.5mm}
    \setlength{\cu@bottom}{#5}
    \oldgeometry{letterpaper,left=#2,right=#3,top=#4,
        bottom=\cu@bottom+#1\cu@bottom,
        footskip=#1\cu@bottom,
        marginparwidth=\cu@marginparwidth,
        marginparsep=2mm
        }
}
\renewcommand{\newgeometry}[5][0.7]{
    \setlength{\cu@marginparwidth}{#2}
    \addtolength{\cu@marginparwidth}{-2.5mm}
    \setlength{\cu@bottom}{#5}
    \oldnewgeometry{left=#2,right=#3,top=#4,
    bottom=\cu@bottom+#1\cu@bottom,
    footskip=#1\cu@bottom,
    marginparwidth=\cu@marginparwidth,
    marginparsep=2mm
    }
}
\geometry{1.5in}{1in}{1in}{1in}
\reversemarginpar
%% Next is the line spacing (double), straightforward
\RequirePackage[doublespacing]{setspace}

%% Environments used to fill sections of the thesis
%%
%% We can create a macro that helps with generating these. Use xparse to create
%% these commands, as it easily lets us define a second optional argument.
\NewDocumentCommand{\cu@isectioninput}{ m o }{%
    %\expandafter\newif\csname ifcu@input#1\endcsname\csname cu@input#1false\endcsname%
    \expandafter\newcommand\csname cu@input#1\endcsname{#2}%
    \expandafter\newcommand\csname #1\endcsname[1]{%
        %% Confirm that this has been overriden
        %\expandafter\csname cu@input#1true\endcsname%
        %% Set the value
        \expandafter\renewcommand\csname cu@input#1\endcsname{##1}%
        }
}
%% abstract placed at the beginning of the thesis
\cu@isectioninput{abstract}
%% acknowledgements (The text that will be instered into the
%% acknowledgments of the thesis.)
\cu@isectioninput{acknowledgements}

%% institution. Default to Carleton University, but can be overriden if
%% you so wish.
\cu@isectioninput{institution}[Carleton University]

%% location (The location of the thesis writer's institution, which will appear
%% just below their name.)
\cu@isectioninput{location}[Ottawa, Ontario]

%% keywords (These keywords will appear in the PDF meta-information
%% called `pdfkeywords`.)
\cu@isectioninput{keywords}

%% subjectline (This subject will appear in the PDF meta-information
%% called `pdfsubject`.)
\cu@isectioninput{subjectline}

%% submissiondate (The date of the submission of this thesis.)
\cu@isectioninput{submissiondate}

%% type (The type of document, e.g., thesis, thesis proposal, dissertation.)
\cu@isectioninput{thesistype}

%% submitted to
\cu@isectioninput{submittedto}[the Faculty of Graduate and Postdoctoral Affairs]

%% submissionnotice (The submission notice is shown on the bottom of the
%% title page.)
%% Faculty of Graduate and Postdoctoral Affairs
\cu@isectioninput{submissionnotice}[A {\cu@inputthesistype} submitted to {\cu@inputsubmittedto}\\ in partial fulfillment of the requirements for the degree of]

%% degree (The degree for which this thesis is written.)
\cu@isectioninput{degree}

%% program (The program for which this thesis is written.)
\cu@isectioninput{program}

%% Chapter and section numbering
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

%% Command to create the title page that follows Carleton's template
\newcommand{\cu@maketitle}{
    \begin{titlepage}
        \begin{center}
            {
                \Large\bfseries
                \@title
            }
            \bigbreak
            {
                by
            }
            \bigbreak
            {
                \Large\bfseries
                \@author
            }
            \vfill
            {
                \cu@inputsubmissionnotice
            }
            \vfill
            {
                \large\bfseries
                \cu@inputdegree
            }
            \bigbreak
            {
                in
            }
            \bigbreak
            {
                \large\bfseries
                \cu@inputprogram
            }
            \vfill
            {
                \cu@inputinstitution\\
                \cu@inputlocation
            }
            \vfill
            {
                \textcopyright~\cu@inputsubmissiondate\\
                \@author
            }
        \end{center}
    \end{titlepage}
}

%% Implementation of command to create the frontmatter
%% Frontmatter follows the following format
%% \item Title page
%% \item Abstract
%% \item Acknowledgements
%% \item Table of Contents
%% \item List of Tables
%% \item List of Illustrations
%% \item List of Appendices
%% Start off by creating the frontmatter command, create the title page
\renewcommand{\frontmatter}{
    \cu@maketitle

    %% Set up the page formatting for the rest of the paper
    \pagestyle{plain}
    \newgeometry[0]{1.5in}{1.5in}{1.5in}{1.5in}
    \ifcu@final
    \else
        \pagenumbering{roman}
        \setcounter{page}{0}
        \thispagestyle{empty}
        \listoftodos
        \newpage
    \fi
    \pagenumbering{roman}
    \setcounter{page}{0}
    \thispagestyle{empty}

    \hypersetup{pdfsubject={\cu@inputsubjectline},pdfkeywords={\cu@inputkeywords}}

    \newpage
    \restoregeometry

    %% Create abstract page
    \chapter*{Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
    \cu@inputabstract
    % Acknowledgements
    %% Create acknowledgements page
    \chapter*{Acknowledgements}
    \addcontentsline{toc}{chapter}{Acknowledgements}
    \cu@inputacknowledgements{}
    %% Create TOC
    % TOC
    \tableofcontents
    %% Create list of tables if option is set
    \ifcu@listoftables%
        \listoftables
    \fi
    %% Create list of figures if option is set
    \ifcu@listoffigures%
        \listoffigures
    \fi
    %% Create glossaries if option is set
    \ifcu@glossary%
        \printglossaries
    \fi
    \newpage
    %% End of frontmatter, use arabic numbers for rest of thesis. Ready to start chapter 1.
    \setcounter{page}{1}
    \pagenumbering{arabic}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%