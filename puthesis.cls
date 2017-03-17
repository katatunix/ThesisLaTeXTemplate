\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{puthesis}[2008/05/02 v1.4 Princeton University Thesis class]
\RequirePackage{setspace}

\def\doctype#1{\gdef\@doctype{#1}}
\def\submitted#1{\gdef\@submitted{#1}}
\def\adviser#1{\gdef\@adviser{#1}}
\def\adviserSec#1{\gdef\@adviserSec{#1}}
\def\company#1{\gdef\@company{#1}}
\def\companycountry#1{\gdef\@companycountry{#1}}
\def\department#1{\gdef\@department{#1}}
\def\departmentPrefix#1{\gdef\@departmentPrefix{#1}}
\def\university#1{\gdef\@university{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\authorship#1{\gdef\@authorship{#1}}
\long\def\theAbstract#1{\gdef\@theAbstract{#1}}
\long\def\acknowledgments#1{\gdef\@acknowledgments{#1}}

\newcommand*{\frontmatter}{
	\pagenumbering{roman}
}
\newcommand*{\mainmatter}{\pagenumbering{arabic}}
\newcommand*{\makelot}{}
\newcommand*{\makelof}{}
\newcommand*{\makelos}{}
\newcommand*{\maketoc}{
	% Add ToC to the pdfbookmarks as a section, but not to the ToC itself.
	% only if we have the hyperref command that is necessary
	\ifdefined\pdfbookmark
		 \phantomsection
		 \pdfbookmark[1]{\contentsname}{Contents}
	\else
	\fi

	\tableofcontents
	\clearpage
}
%% Setup a command to add extra space only if in singlespacing mode
\newcommand*{\extravspace}[1]{\vspace{0in}}
\renewcommand*{\extravspace}[1]{\vspace{#1}}

%% Command inserted into the document immediately after \begin{document} to place all frontmatter
%%	 This was formerly named 'begincmd' and called below in \AtBeginDocument{}
%%	 However, that is not compatible with package 'hyperref'. \tableofcontents needs
%%	 to be declared from within the document itself. 
\newcommand*{\makefrontmatter}{
	\singlespacing
	\frontmatter\maketitlepage\makeauthorship\makeabstract
	\makeacknowledgments\maketoc

	\makelot\clearpage\makelof\clearpage
	\clearpage\mainmatter
}

\newcommand{\maketitlepage}{{
	\thispagestyle{empty}
	\sc
	\vspace*{0in}
	\begin{center}
		\LARGE \@title
	\end{center}
	\vspace{.6in}
	\extravspace{.6in}
	\begin{center}
		\@author
	\end{center}
	\vspace{.6in}
	\extravspace{.6in}
	\begin{center}
		A \@doctype\ submitted in partial fulfillment\\
		of the requirements of the\\
		\@university\\
		for the degree of\\
		\@degree
	\end{center}
	\vspace{.3in}
	\extravspace{.3in}
	\begin{center}
		Research undertaken in the\\
		\@departmentPrefix\ \@department \\
		in collaboration with \\
		\@company\ in \@companycountry\ \\
		Supervisor: \@adviser\\
		Second supervisor: \@adviserSec
	\end{center}
	\vspace{.3in}
	\extravspace{.3in}
	\begin{center}
		\@submitted
	\end{center}
	\clearpage
}}

\newcommand*{\makeabstract}{
	\ifx\@theAbstract\undefined
	\else
		\newpage
		\ifdefined\phantomsection
			\phantomsection
		\else
		\fi
		\addcontentsline{toc}{section}{Abstract}
		\begin{center}
		\Large \textbf{Abstract}\\
		\large \@title\\
		\large \textit{\@author}
		\end{center}
		\@theAbstract
		\clearpage
	\fi
}

\def\makeauthorship{
	\ifx\@authorship\undefined
	\else
		\ifdefined\phantomsection
			\phantomsection
		\else
		\fi
		\addcontentsline{toc}{section}{Statement of Authorship}
		\begin{center}
			\Large \textbf{Statement of Authorship}
		\end{center}
		\@authorship
		\clearpage
	\fi
}

\def\makeacknowledgments{
	\ifx\@acknowledgments\undefined
	\else
		\ifdefined\phantomsection
			\phantomsection
		\else
		\fi
		\addcontentsline{toc}{section}{Acknowledgments}
		\begin{center}
			\Large \textbf{Acknowledgments}
		\end{center}
		\@acknowledgments
		\clearpage
	\fi
}

\DeclareOption{lot}{\renewcommand*{\makelot}{
	\ifdefined\phantomsection
		\phantomsection
	\else
	\fi
	\addcontentsline{toc}{section}{List of Tables}\listoftables}
}

\DeclareOption{lof}{\renewcommand*{\makelof}{
	\ifdefined\phantomsection
		\phantomsection
	\else
	\fi
	\addcontentsline{toc}{section}{List of Figures}\listoffigures}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
%% Not necessary to specify the point size - we inherit it from above
%% \LoadClass[12pt]{report}
\LoadClass{report}
\setlength{\oddsidemargin}{.5in}	 %{.4375in}
\setlength{\evensidemargin}{.5in} %{.4375in}
\setlength{\topmargin}{-.5in}	%{-.5625in}
\setlength{\footskip}{.25in} % to put page number 3/4" from the bottom of the page (1/4" from bottom of body text)
\setlength{\textheight}{9in}
\setlength{\textwidth}{6in}

%%% Alter LaTeX defaults to try to eliminate all widows and orphans
\clubpenalty=10000
\widowpenalty=10000

%%% try to avoid overfull lines by limiting how far it is okay to exceed the margins
%%% http://www.tex.ac.uk/cgi-bin/texfaq2html?label=overfull
\setlength{\emergencystretch}{2em}

%% 'begincmd' no longer used -- insert \makefrontmatter in the document instead. See above. 
%\AtBeginDocument{\begincmd}
\endinput
%% 
%% End of file `puthesis.cls'.
