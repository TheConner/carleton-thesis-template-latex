%%
%% This is file `cu-thesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cu-thesis.dtx  (with options: `cuthesis')
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
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{cu-thesis}[2023/09/07 v1.4 document class for typesetting theses]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  cu-thesis implementation  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\cu@ifbool}[1]{\csname ifcu@#1\endcsname}
\newcommand{\cu@setbool}[2]{\csname cu@#1#2\endcsname}
\newcommand{\cu@boolopt}[1]{%
    \expandafter\newif\csname ifcu@#1\endcsname%
    \csname cu@#1false\endcsname%_
    \DeclareOption{#1}{\csname cu@#1true\endcsname}%
}
%% declare all package options
\cu@boolopt{scrbook}
\cu@boolopt{listoffigures}
\cu@boolopt{listoftables}
\cu@boolopt{listoflistings}
\cu@boolopt{glossary}
\cu@boolopt{draft}
\cu@boolopt{final}
\ProcessOptions*
%% For ease of use we will use the default \LaTeX \texttt{book} class. More
%% advanced users may prefer to use KOMA-scripts \texttt{scrbook} class, which
%% is also supported.
%%
%% The \texttt{book} and \texttt{scrbook} class arguments are not perfectly
%% compatible, thus we have to conditionally enable some flags in certain
%% classes.
\newcommand{\cu@idocclass}{book}
\cu@ifbool{scrbook}
    \renewcommand{\cu@idocclass}{scrbook}
    %% We aren't setting paper size here as it is very very tricky with koma
    %% script classes, attempts to pass to typearea seem to fail. Thus,
    %% koma script classes will have their paper size set after \LoadClass
    \PassOptionsToClass{headings=standardclasses}{\cu@idocclass}
    \PassOptionsToClass{listof=totoc}{\cu@idocclass}
\else
    \PassOptionsToClass{letterpaper}{\cu@idocclass}
\fi
\PassOptionsToClass{oneside}{\cu@idocclass}
\PassOptionsToClass{12pt}{\cu@idocclass}
\cu@ifbool{final}
    \PassOptionsToClass{final}{\cu@idocclass}
\fi
%% A noteworthy snippet: all undefined options get passed through to the
%% underlying document class. This way, you can directly interact with all
%% documented options for the document class we are building on.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\cu@idocclass}}
\ProcessOptions\relax
\LoadClass{\cu@idocclass}
%% For koma-script classes, we can now set paper size...
\cu@ifbool{scrbook}
    \KOMAoptions{paper=letter,pagesize,paper=portrait}
\fi
%% At this point our document class is loaded. We can load in helpful
%% dependencies we need.
\RequirePackage{iftex}
\RequirePackage{xparse}
\RequirePackage[utf8]{inputenc}
\RequirePackage[
    pdffitwindow=true,
    pdfpagelabels=true,
    colorlinks=false,
    pdfborder={0 0 0},
    pdfusetitle=true
]{hyperref}
\RequirePackage[all]{hypcap}
\cu@ifbool{glossary}
    \RequirePackage[toc,nonumberlist,acronyms]{glossaries}
    \makeglossaries%
    \setglossarystyle{listdotted}
\fi
%% package.
\cu@ifbool{final}
    \ifluatex
        \RequirePackage{luatex85}
    \fi
    \RequirePackage[a-1b]{pdfx}
\fi
%% For page formatting, refer to the following Carleton guidelines for thesis
%% formatting
%% All written and illustrative material on an 8 1\"\ x 11\"\ page, including page
%% numbers, must fall within the following margins: one and one-half inches on
%% the left margin and one full inch on the other three sides. Margins may be
%% wider but not narrower than the stated requirements.
%%
%% For theses written in landscape format, please allow one and one-half inches
%% on the top margin and one full inch on the other three sides.
%% Within this context, use the \texttt{geometry} package to format the page
%% within these bounds. A noteworthy point is that all text
%% \textit{including page numbers} must fall within these margins.
%%
%% Doing this is tricky as geometry and koma-packages don't mix well. Use the
%% pass option to avoid geometry directly interfering with KOMA settings
\RequirePackage[includefoot,includehead]{geometry}
\newcommand{\cu@setgeometry}{\geometry{%
    left=1.5in,
    right=1in,
    top=1in,
    bottom=1in}}
\cu@ifbool{scrbook}
    \AfterCalculatingTypearea{\cu@setgeometry}
    \recalctypearea
\else
    \cu@setgeometry
\fi
\reversemarginpar
%% Next is the line spacing (double), straightforward
\RequirePackage[doublespacing]{setspace}
%% Set up headers and footers using KOMA's scrlayer-scrpage class. This works
%% with both the book and scrbook class. Ensure that we aren't setting draft
%% as this will cause rulers to apperar in the header/footer.
\RequirePackage[automark]{scrlayer-scrpage}
\KOMAoptions{draft=false}
\clearpairofpagestyles
\chead{\headmark}
\cfoot*{\pagemark}
%% Environments used to fill sections of the thesis
%%
%% We can create a macro that helps with generating these. Use xparse to create
%% these commands, as it easily lets us define a second optional argument.
\NewDocumentCommand{\cu@isectioninput}{ m o }{%
    %\expandafter\newif\csname cu@ifinput#1\endcsname\csname cu@input#1false\endcsname%
    \expandafter\newcommand\csname cu@input#1\endcsname{#2}%
    \expandafter\newcommand\csname #1\endcsname[1]{%
        %% Confirm that this has been overriden
        \expandafter\csname cu@input#1true\endcsname%
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
\cu@isectioninput{submissionnotice}[%
    A {\cu@inputthesistype} submitted to {\cu@inputsubmittedto}\\%
    in partial fulfillment of the requirements for the degree of]

%% degree (The degree for which this thesis is written.)
\cu@isectioninput{degree}

%% program (The program for which this thesis is written.)
\cu@isectioninput{program}

%% degreeprogram (override degree and program with some other text)
\cu@isectioninput{degreeprogram}

%% Chapter and section numbering
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

%% Command to create the title page that follows Carleton's template
\newcommand{\cu@maketitle}{
    \newgeometry{margin=1in}
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
            \ifcsname cu@inputdegreeprogramtrue\endcsname%
                {
                    \large\bfseries
                    \cu@inputdegreeprogram
                }
            \else
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
            \fi
            \vfill
            {
                \cu@inputinstitution\\
                \cu@inputlocation
            }
            \vfill
            {
                \textcopyright~\cu@inputsubmissiondate,~\@author
            }
        \end{center}
    \end{titlepage}
    \restoregeometry
}

%% Implementation of command to create the frontmatter
%% Frontmatter follows the following format
%% \item Title page
%% \item Abstract
%% \item Acknowledgements
%% \item Table of Contents
%% \item List of Tables
%% \item List of Figures
%% \item List of Listings (optional if the listings package is loaded)
%% \item List of Appendices
%% Start off by creating the frontmatter command, create the title page
\renewcommand{\frontmatter}{
    \cu@maketitle
    %% Set up the page formatting for the rest of the paper
    %% A note on page numbering, from the requirements:
    %% ``Small Roman numerals are used in the preliminary section. All pages are to be numbered except for the title page on which number “i” is implied but not given...''
    \pagenumbering{roman}
    \setcounter{page}{1}
    \hypersetup{pdftitle={\@title},pdfauthor={\@author},pdfkeywords={\cu@inputkeywords}}

    %% Create abstract page
    \chapter*{Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
    \cu@inputabstract
    % Acknowledgements
    %% Create acknowledgements page
    \chapter*{Acknowledgements}
    \addcontentsline{toc}{chapter}{Acknowledgements}
    \cu@inputacknowledgements
    %% Create TOC
    % TOC
    \tableofcontents
    %% Create list of tables if option is set
    \cu@ifbool{listoftables}
        \listoftables
    \fi
    %% Create list of figures if option is set
    \cu@ifbool{listoffigures}
        \listoffigures
    \fi
%% Create list of listings if option is set. A potential todo is to ensure that
%% we correctly handle some quirks on scrbook vs plain book. For more information
%% refer to the scrbook manual.
%%
%% We also ensure that the title of the list of listings is ``List of Listings'' and not ``Listings''.
%% This is to be consistent with the other ``List of'' sections.
    \cu@ifbool{listoflistings}
        \@ifpackageloaded{listings}{%
            \renewcommand\lstlistingname{Listing}%
            \renewcommand\lstlistlistingname{List of Listings}%
            \lstlistoflistings%
        }{\PackageError{cu-thesis}{listings package not loaded}{%
        The listoflistings option is set but the listings package is not loaded.%
        Load the package before calling \\frontmatter}%
        }
    \fi
    %% Create glossaries if option is set
    \cu@ifbool{glossary}
        \printglossaries
    \fi
    \newpage
    %% End of frontmatter, use arabic numbers for rest of thesis. Ready to start chapter 1.
    \setcounter{page}{1}
    \pagenumbering{arabic}
}
%% If `draft' is set, we want to clearly label this copy of the thesis as a draft. We include a timestamp in case a reviewer sees multiple revisions of the thesis and needs to differentiate between versions.
\cu@ifbool{draft}
    \RequirePackage{datetime2}
    \DTMsettimestyle{hmmss}
    \usepackage[all]{background}
    \SetBgContents{\color{gray!50!white} [DRAFT: Rev. as of \DTMnow]}
    \SetBgPosition{current page.west}
    \SetBgVshift{-1.0cm}
    \SetBgOpacity{1.0}
    \SetBgAngle{90.0}
    \SetBgScale{2.0}
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
