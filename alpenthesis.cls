\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{alpenthesis}%
    [2017/04/06 v0.0.1 PDF-LaTeX class for my thesis]
\LoadClassWithOptions{memoir}
\maxsecnumdepth{subsubsection}
\maxtocdepth{subsubsection}
\chapterstyle{veelo}
\newcommand\aiiistock{%
    \stockaiii
    \settrimmedsize{297mm}{210mm}{*}
    \setlength{\trimtop}{\stockheight}
    \addtolength{\trimtop}{-\paperheight}
    \setlength{\trimedge}{\stockwidth}
    \addtolength{\trimedge}{-\paperwidth}
    \settrims{0.5\trimtop}{0.5\trimedge}
    \renewcommand*{\trimmarkscolor}{\color{red}}
    \showtrimson
    \checkandfixthelayout
}
\showtrimsoff
\setlrmarginsandblock{0.142857111\paperwidth}{0.190476190\paperwidth}{*}
\setulmarginsandblock{0.111111111\paperheight}{*}{1.5}%
\checkandfixthelayout
\setsecheadstyle{\color{sqB}\Large\bfseries\sffamily}
\setsubsecheadstyle{\color{sqB}\large\bfseries\sffamily}
\setsubsubsecheadstyle{\color{sqB}\bfseries\sffamily}
\addtodef{\printchaptername}{\color{sqB}}{}
\pagestyle{headings}
\captionnamefont{\bfseries\small}
\captiontitlefont{\small}
\captiondelim{: }
\newfixedcaption{\figcaption}{figure}
\newfixedcaption{\tabcaption}{table}
\newif\ifhex
\newcommand\setupfadings{%
    \pgfmathsetmacro{\numberOfHorizSides}{12}%
    \pgfmathtruncatemacro\numberOfHorizElements{%
        round(\numberOfHorizSides * 5 / 4)}
    \pgfmathsetmacro{\maxElementNumber}{\numberOfHorizSides - 1}%
    \pgfmathsetmacro{\side}{0.5\paperwidth/\maxElementNumber}%
    \pgfmathcos{30}%
    \pgfmathsetmacro{\height}{\pgfmathresult * \side}%
    \foreach \j in {0,...,\maxElementNumber}{%
        \pgfmathsetmacro{\leftTransp}
            {100 * \j / \numberOfHorizSides}%
        \pgfmathsetmacro{\rightTransp}
            {100 * (\j+1) / \numberOfHorizSides}%
        \tikzfading[%
            name=hexfade \j,
            right color=transparent!\rightTransp,
            left color=transparent!\leftTransp]%
    }%
}
\newcommand\hexagons{%
    \setupfadings
    \tikzset{external/export next=false}%
    \begin{tikzpicture}[remember picture,overlay,x=1pt,y=1pt]
        \pgfmathtruncatemacro\iterstop
            {floor(\numberOfHorizElements / 2)}
        \pgfmathtruncatemacro\iterstopvert
            {floor(\numberOfHorizElements / 3 )}
        \foreach \n in {0,...,\iterstopvert} {%
            \foreach \m in {0,...,\iterstop} {%
                \pgfmathtruncatemacro\k{round(\m + 1)}
                \fill[br0,draw=br1,path fading=hexfade \k]
                    ($(current page.north west) +
                        (1.5 * \side + 3 * \m * \side,
                            + 0.866025 * \side - \n * 1.732051 * \side)$)
                    -- ++(   0:\side)
                    -- ++( -60:\side)
                    -- ++(-120:\side)
                    -- ++(-180:\side)
                    -- ++(-240:\side) -- cycle;
                \fill[br0,draw=br1,path fading=hexfade \m]
                    ($(current page.north west) +
                        (0 * \side + 3 * \m * \side,
                            -\n * 1.732051 * \side)$)
                    -- ++(   0:\side)
                    -- ++( -60:\side)
                    -- ++(-120:\side)
                    -- ++(-180:\side)
                    -- ++(-240:\side) -- cycle;
            }%
        }%
    \end{tikzpicture}%
}
\newcommand\chapnumhexagons{%
    \setupfadings
    \tikzset{external/export next=false}
    \begin{tikzpicture}[remember picture,overlay,x=1pt,y=1pt]
        \foreach \n in {1,...,\thechapter} {%
            \pgfkeysgetvalue{/chapter \thechapter/hexagon \n/x}
                {\randNumHoriz}
            \pgfkeysgetvalue{/chapter \thechapter/hexagon \n/y}
                {\randNumVert}
            \pgfmathmod{\randNumHoriz}{2}
            \pgfmathtruncatemacro\fadingIndex{floor(\randNumHoriz/2)}
            \pgfmathsetmacro\offsetVert{\pgfmathresult}
            \fill[dv-7,draw=br1,path fading=hexfade \fadingIndex]
                ($(current page.north west) +
                    (1.5 * \randNumHoriz * \side,
                        - 0.866025 * \offsetVert * \side
                        - \randNumVert * 1.732051 * \side)$)
                -- ++(   0:\side)
                -- ++( -60:\side)
                -- ++(-120:\side)
                -- ++(-180:\side)
                -- ++(-240:\side) -- cycle;
        }%
    \end{tikzpicture}%
}
\newcommand\appendixnumhexagons{%
    \setupfadings
    \tikzset{external/export next=false}
    \begin{tikzpicture}[remember picture,overlay,x=1pt,y=1pt]
        \foreach \n in {A,...,\thechapter} {%
            \pgfkeysgetvalue{/appendix \thechapter/hexagon \n/x}
                {\randNumHoriz}
            \pgfkeysgetvalue{/appendix \thechapter/hexagon \n/y}
                {\randNumVert}
            \pgfmathmod{\randNumHoriz}{2}
            \pgfmathtruncatemacro\fadingIndex{floor(\randNumHoriz / 2)}
            \pgfmathsetmacro\offsetVert{\pgfmathresult}
            \fill[ct4,draw=br1,path fading=hexfade \fadingIndex]
                ($(current page.north west) +
                    (1.5 * \randNumHoriz * \side,
                        - 0.866025 * \offsetVert * \side
                        - \randNumVert * 1.732051 * \side)$)
                -- ++(   0:\side)
                -- ++( -60:\side)
                -- ++(-120:\side)
                -- ++(-180:\side)
                -- ++(-240:\side) -- cycle;
        }%
    \end{tikzpicture}%
}
\newcommand\bottomscreen{%
    \setupfadings
    \tikzset{external/export next=false}%
    \begin{tikzpicture}[remember picture,overlay,x=1pt,y=1pt]
        \fill[white,path fading=north]%
            ($(current page.north west) - (0pt, 10.5 * \side)$)
            rectangle
            ($(current page.north east) - (0pt,2 * \side)$);%
    \end{tikzpicture}%
}
\newlength{\edgewidth}
\makechapterstyle{alpenthesis}{%
    % Lengths
    \setlength{\afterchapskip}{40pt}%
    \renewcommand*{\chapterheadstart}
        %{\vspace*{40pt}}%
        {\ifhex\hexagons\fi\vspace*{40pt}}%
    \renewcommand*{\afterchapternum}
        {\par\nobreak\vskip 25pt}%
    \setlength{\beforechapskip}{18mm}%
    \setlength{\midchapskip}{\paperwidth}%
    \addtolength{\midchapskip}{-\textwidth}%
    \addtolength{\midchapskip}{-\spinemargin}%
    % Fonts
    \renewcommand*{\chapnamefont}
        {\sffamily\LARGE\flushright}%
    \renewcommand*{\chapnumfont}
        {\sffamily\HUGE}%
    \renewcommand*{\chaptitlefont}
        {\sffamily\HUGE\flushright}%
    % Output:
    \renewcommand*\printchaptertitle{\chaptitlefont}%
    \renewcommand*{\printchaptername}{%
        \ifhex\chapnumhexagons\fi%
        \bottomscreen%
        \chapnamefont\MakeTextUppercase{\@chapapp}%
    }%
    \renewcommand*\printchapternonum{\bottomscreen}%
    % What comes between chaptername and the number:
    \renewcommand*{\chapternamenum}{}%
    % Print chapter number etc.
    \renewcommand*{\printchapternum}{%
        \setlength{\edgewidth}{\marginparwidth}%
        \addtolength{\edgewidth}{\marginparsep}%
        \makebox[0pt][l]{%
            \hspace{.8em}%
            \resizebox{!}{\beforechapskip}
                {\chapnumfont\thechapter}%
            \hspace{.8em}%
            %\rule{\midchapskip}{\beforechapskip}%
        }%
   }%
   \makeoddfoot{plain}{}{}{\thepage}}%
\makechapterstyle{alpenappendix}{%
    % Lengths
    \setlength{\afterchapskip}{40pt}%
    \renewcommand*{\chapterheadstart}
        %{\vspace*{40pt}}%
        {\ifhex\hexagons\fi\vspace*{40pt}}%
    \renewcommand*{\afterchapternum}
        {\par\nobreak\vskip 25pt}%
    \setlength{\beforechapskip}{18mm}%
    \setlength{\midchapskip}{\paperwidth}%
    \addtolength{\midchapskip}{-\textwidth}%
    \addtolength{\midchapskip}{-\spinemargin}%
    % Fonts
    \renewcommand*{\chapnamefont}
        {\sffamily\LARGE\flushright}%
    \renewcommand*{\chapnumfont}
        {\sffamily\HUGE}%
    \renewcommand*{\chaptitlefont}
        {\sffamily\HUGE\flushright}%
    % Output:
    \renewcommand*\printchaptertitle{\chaptitlefont}%
    \renewcommand*{\printchaptername}{%
        \ifhex\appendixnumhexagons\fi%
        \bottomscreen%
        \chapnamefont\MakeTextUppercase{\@chapapp}%
    }
    \renewcommand*\printchapternonum{\bottomscreen}%
    % What comes between chaptername and the number:
    \renewcommand*{\chapternamenum}{}%
    % Print chapter number etc.
    \renewcommand*{\printchapternum}{%
        \setlength{\edgewidth}{\marginparwidth}%
        \addtolength{\edgewidth}{\marginparsep}%
        \makebox[0pt][l]{%
            \hspace{.8em}%
            \resizebox{!}{\beforechapskip}
                {\chapnumfont \thechapter}%
            \hspace{.8em}%
            %\rule{\midchapskip}{\beforechapskip}%
        }%
   }%
   \makeoddfoot{plain}{}{}{\thepage}}%
\RequirePackage[rmx,nott]{kpfonts}
\RequirePackage[scaled=0.8125]{DejaVuSansMono}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{xcolor}
\globalcolorstrue
\definecolor{da0}{HTML}{002B36}
\definecolor{da1}{HTML}{073642}
\definecolor{da2}{HTML}{008080}
\definecolor{da3}{HTML}{800080}
\definecolor{da4}{HTML}{404040}
\definecolor{ct0}{HTML}{CB4B16}
\definecolor{ct1}{HTML}{DC322F}
\definecolor{ct2}{HTML}{DC3682}
\definecolor{ct3}{HTML}{268BD2}
\definecolor{ct4}{HTML}{2AA198}
\definecolor{ct5}{HTML}{B58900}
\definecolor{ct6}{HTML}{859900}
\definecolor{br0}{HTML}{BEB9AA}
\definecolor{br1}{HTML}{EEE8D5}
\definecolor{br2}{HTML}{FDF6E3}
\definecolor{sq0}{HTML}{F7FBFF}
\definecolor{sq1}{HTML}{EFF3FF}
\definecolor{sq2}{HTML}{DECDF7}
\definecolor{sq3}{HTML}{C6DBEF}
\definecolor{sq4}{HTML}{BDD7E7}
\definecolor{sq5}{HTML}{9ECAE1}
\definecolor{sq6}{HTML}{6BAED6}
\definecolor{sq7}{HTML}{4292C6}
\definecolor{sq8}{HTML}{3182BD}
\definecolor{sq9}{HTML}{2171B5}
\definecolor{sqA}{HTML}{08519C}
\definecolor{sqB}{HTML}{084594}
\definecolor{sqC}{HTML}{08306B}
\definecolor{dv-7}{HTML}{8E0152}
\definecolor{dv-6}{HTML}{C51B7D}
\definecolor{dv-5}{HTML}{D01C8B}
\definecolor{dv-4}{HTML}{DE77AE}
\definecolor{dv-3}{HTML}{E9A3C9}
\definecolor{dv-2}{HTML}{F1B6DA}
\definecolor{dv-1}{HTML}{FDE0EF}
\definecolor{dv+0}{HTML}{F7F7F7}
\definecolor{dv+1}{HTML}{D1E5F0}
\definecolor{dv+2}{HTML}{92C5DE}
\definecolor{dv+3}{HTML}{67A9CF}
\definecolor{dv+4}{HTML}{4393C3}
\definecolor{dv+5}{HTML}{0571B0}
\definecolor{dv+6}{HTML}{2166AC}
\definecolor{dv+7}{HTML}{053061}
\definecolor{q0}{named}{ct3}
\definecolor{q1}{named}{sqB}
\definecolor{q2}{named}{ct2}
\definecolor{q3}{named}{da3}
\definecolor{q4}{HTML}{FEC44F}
\definecolor{q5}{named}{ct0}
\definecolor{q6}{HTML}{80EA82}
\definecolor{q7}{HTML}{2E7D32}
\newcommand*\testcolor[1]{\tikz \fill[#1] (0em,0ex) rectangle (2em,2ex);}
\newcommand*\rowtestcolor[1]{#1 & \tikz \fill[#1] (0em,0ex) rectangle (2em,2ex);}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\usetikzlibrary{fadings}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.14}
\usepgfplotslibrary{external}
\tikzexternalize[prefix=cache/,optimize command away=\includepdf]
\RequirePackage{tcolorbox}
\tcbuselibrary{minted}
\tcbuselibrary{skins}
\tcbset{%
    colback=br2,
    coltitle=br2,
    colframe=da1,
    fonttitle=\sffamily,
    minted options={autogobble},
    enhanced,
    frame code={
        \draw[very thick]
               ([xshift=-3mm,yshift=+1mm]frame.north east)
            -- ([xshift=+0mm,yshift=-2mm]frame.north east)
            -- ([xshift=+0mm,yshift=+2mm]frame.south east)
            -- ([xshift=-3mm,yshift=-1mm]frame.south east)
            -- ([xshift=+3mm,yshift=-1mm]frame.south west)
            -- ([xshift=-0mm,yshift=+2mm]frame.south west)
            -- ([xshift=-0mm,yshift=-2mm]frame.north west)
            -- ([xshift=+3mm,yshift=+1mm]frame.north west)
            -- cycle;
    },
    interior titled code={%
        \path[tcb fill interior]
               ([xshift=-2.7mm,yshift=+1.3mm]interior.north east)
            -- ([xshift=+0.3mm,yshift=-1.7mm]interior.north east)
            -- ([xshift=+0.3mm,yshift=+1.7mm]interior.south east)
            -- ([xshift=-2.7mm,yshift=-1.3mm]interior.south east)
            -- ([xshift=+2.7mm,yshift=-1.3mm]interior.south west)
            -- ([xshift=-0.3mm,yshift=+1.7mm]interior.south west)
            -- ([xshift=-0.3mm,yshift=-1.7mm]interior.north west)
            -- ([xshift=+2.7mm,yshift=+1.3mm]interior.north west)
            -- cycle;
    },
    interior code={%
        \path[tcb fill interior]
               ([xshift=-2.7mm,yshift=+1.3mm]interior.north east)
            -- ([xshift=+0.3mm,yshift=-1.7mm]interior.north east)
            -- ([xshift=+0.3mm,yshift=+1.7mm]interior.south east)
            -- ([xshift=-2.7mm,yshift=-1.3mm]interior.south east)
            -- ([xshift=+2.7mm,yshift=-1.3mm]interior.south west)
            -- ([xshift=-0.3mm,yshift=+1.7mm]interior.south west)
            -- ([xshift=-0.3mm,yshift=-1.7mm]interior.north west)
            -- ([xshift=+2.7mm,yshift=+1.3mm]interior.north west)
            -- cycle;
    },
    title code={%
        \path[tcb fill frame]
               ([xshift=-3mm,yshift=+1mm]frame.north east)
            -- ([xshift=+0mm,yshift=-2mm]frame.north east)
            -- ([xshift=+0.3mm,yshift=-2mm]interior.north east)
            -- ([xshift=-3mm,yshift=+1mm]interior.north east)
            -- ([xshift=+3mm,yshift=+1mm]interior.north west)
            -- ([xshift=-0.3mm,yshift=-2mm]interior.north west)
            -- ([xshift=-0mm,yshift=-2mm]frame.north west)
            -- ([xshift=+3mm,yshift=+1mm]frame.north west)
            -- cycle;
    }
}
\RequirePackage[%
    pdfauthor=alpenwasser,
    pdfsubject={LaTeX document design},
    pdftitle={alpenwasser's thesis},
    bookmarksnumbered=true,
    pdfkeywords={LaTeX,design,alpenwasser,thesis,class,hexagons},
    colorlinks=true,
    linkcolor=sqB,
    citecolor=ct4,
    urlcolor=dv-6]{hyperref}
\RequirePackage[english]{babel}
\RequirePackage{minted}
\RequirePackage{tcolorbox}
\RequirePackage{amsmath}
\RequirePackage[separate-uncertainty=true]{siunitx}
\RequirePackage{counttexruns}
\RequirePackage{booktabs}
\newcommand*\pacname[1]{\textsf{#1}}
\newcommand*\code[1]{\texttt{#1}}
\newcommand*\athes{\pacname{alpenthesis}}
\input{randInts.tex}
