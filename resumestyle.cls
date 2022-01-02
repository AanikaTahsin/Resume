
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resumestyle}[Resume of Araf Al Jami]
\LoadClassWithOptions{scrartcl}

\RequirePackage[hmargin=1.25cm,vmargin=1.25cm,twocolumn,columnsep=1.25cm]{geometry}
\RequirePackage{enumitem,ragged2e,needspace,setspace}
\RequirePackage{bookman,booktabs,etoolbox,pifont,xcolor,hyperref,mdframed,xhfill,fontawesome,tikz}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[bold=0.1]{xfakebold}
\RequirePackage{multirow,tabularx}
\RequirePackage{ifthen}
\RequirePackage{lmodern} % Change fonts

% -------------
% Definitions
% -------------
%\definecolor{colorlink}{HTML}{006699}
\definecolor{colorlink}{HTML}{224191}
\definecolor{lightestgray}{HTML}{292929}
\definecolor{lightergray}{HTML}{292929}
\definecolor{lightgray}{HTML}{292929}
\definecolor{midgray}{HTML}{292929}
\definecolor{darkgray}{HTML}{292929}
\definecolor{verydarkgray}{HTML}{191919}
\definecolor{link}{HTML}{2c527d} % Hyperlinks

% -------------
% Commands
% -------------
% Command to set global color
\newcommand{\globalcolor}[1]{%
    \color{#1}\global\let\default@color\current@color}

% Allow conditionals based on the job name. This can usually be set
% from a command-line argument: check fausto.en.tex for an example.
% \ifjob
%     {jobname}
%     {content if matches}
%     {content if does not match}
\newcommand\ifjob[3]{%
    \edef\JOBNAME{\jobname}%
    \edef\PIVOT{\detokenize{#1}}%
    \ifdefstrequal{\JOBNAME}{\PIVOT}{#2}{#3}}

% Capitalize words of at least a minimum length (default to 3 chars).
% The text is capitalized before being expanded.
\newcommand\ucwords[2][3]{%
    \providecommand\directlua[1]{#2}%
    \directlua{%
        local minlen = tonumber("#1")
        local src = "\luaescapestring{\unexpanded{#2}}"
        local dst = {}
        for w in src:gmatch(string.char(37) .. "S+") do
            if w:len() >= minlen then
        	table.insert(dst, w:sub(1,1):upper() .. w:sub(2))
            else
        	table.insert(dst, w)
            end
        end
        tex.print(dst)}}

% Tags
\newcommand{\tag}[1]{%
    \tikz[baseline]\node[%
        anchor=base,%
        draw=black!90!white!35,%
        rounded corners,%
        inner xsep=0.78ex,%
        inner ysep =0.75ex,%
        text height=1.5ex,%
        text depth=.25ex]{ \fontsize{2.3ex}{0pt}\selectfont#1 };}

% Name 
\newcommand{\name}[1]{{%
    \fontsize{6.0ex}{0pt}\selectfont% set font size
    #1}}

% Header
\renewcommand\part[2][]{%
    \twocolumn[{%
        \setlength\arrayrulewidth{1.25pt}%
        \begin{tabularx}{\textwidth}{@{}X@{}r@{}}%
            \multirow{3}*%
                {\name{#2}}%
                &%
                \href%
                    {https://araf.aljami.me/}%
                    {araf.aljami.me} \faGlobe\\%
                &%
                \href%
                    {mailto:arafaljami1331@gmail.com}%
                    {arafaljami1331@gmail.com} \faEnvelopeO\\%
                &%
                \href%
                    {https://www.linkedin.com/in/araf-al-jami/}%
                    {linked.com/in/araf-al-jami} \faLinkedin\\%
            Bangkok, Thailand | +66 080-645-7338%
            &%
            \href%
                {https://github.com/CLown1331}%
                {github.com/CLown1331} \faGithub \medskip\\%
            \cline{1-2}%
            \medskip%
        \end{tabularx}}]}

% Section
\let\old@section\section
\renewcommand\section[2][]{%
    \vspace{-0.8ex}%
    \old@section[#1]{%
        \textcolor{black}{%
            \ucwords{\Large\MakeUppercase{#2}}}%
            \enspace\xrfill[0.7ex]{0.5pt}}%
    % \hrule height 0.4pt
    \vspace{-0.8ex}}

% Subsection title 
\newcommand{\subsssectiontitle}[1]{{%
    \fontsize{13pt}{0pt}\selectfont% set font size
    \textbf{#1}}}

% Titles for work experience section
\newcommand\worksubsection[3]{%
    {%
        \textbf{#1}%
    }%
    \vspace{2pt}\\% title
    #2\vspace{0.5pt}\\% subtitle 1
    #3}% subtitle 2

% Titles for work experience section
\newcommand\projectsubsection[2]{%
    {%
        % \fontsize{13pt}{0pt}\selectfont% font style
        \textbf{#1}%
    }%
    \vspace{2pt}\\% title
    #2}% subtitle 2

% --------------------------
% Document global settings
% --------------------------
\KOMAoption{bibliography}{totocnumbered}

\AtEndPreamble{%
    \@ifpackageloaded{biblatex}{%
        \defbibheading{bibliography}[\refname]{%
			\section{#1}}}%
	{}%
}

\pagestyle{empty}

\AtBeginDocument{\globalcolor{black}} % text color
\color[HTML]{303030} % Default foreground color

\hypersetup{colorlinks,breaklinks,urlcolor=black,linkcolor=black}
\setkomafont{disposition}{\color[HTML]{000000}}
\setkomafont{section}{\scshape\Large\mdseries}

\setcounter{secnumdepth}{-1} % Remove counter from sections
\setlength\parindent{0pt}

%% End