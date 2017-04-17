\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{alpenthesis}%
    [2017/04/06 v0.0.1 PDF-LaTeX class for my thesis]
\LoadClassWithOptions{memoir}
\newif\ifhex
\newif\ifpaper
\RequirePackage[rmx,nott,intlimits,sumlimits]{kpfonts}
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
\pgfmathsetmacro\alpth@paperwidth{21}
\pgfmathsetmacro\alpth@paperheight{29.7}
\pgfmathsetmacro\alpth@numberOfSidesHorizontally{22}
\pgfmathsetmacro\alpth@side
    {\alpth@paperwidth / \alpth@numberOfSidesHorizontally}
\pgfmathtruncatemacro\alpth@totCols
    {0.666667 * \alpth@numberOfSidesHorizontally + 1}
\pgfmathcos{30}
\pgfmathsetmacro\alpth@height
    {\pgfmathresult * \alpth@side}
\pgfmathtruncatemacro\alpth@numberOfHeightsVertically
    {\alpth@paperheight / \alpth@height}
\pgfmathtruncatemacro\alpth@totRows
    {0.5 * \alpth@numberOfHeightsVertically + 1}
\pgfmathtruncatemacro\alpth@totRowsChap
    {0.1333 * \alpth@numberOfHeightsVertically + 1}
\AtBeginDocument{%
    \ifpaper
        \foreach \y in {0,...,\alpth@totRowsChap} {%
            \foreach \x in {0,...,\alpth@totCols}{%
                \pgfmathsetmacro\mix
                    {100 * \x / \alpth@totCols}%
                \pgfmathsetmacro\mixvert
                    {100 * \y / \alpth@totRowsChap}%
                \colorlet{hex-\x}{white!\mix!br0}%
                \colorlet{hex-\x-\y}{white!\mixvert!hex-\x}%
                \colorlet{hexframecol-\x}{white!\mix!br2}%
                \colorlet{hexframecol-\x-\y}
                    {white!\mixvert!hexframecol-\x}%
                \colorlet{chapcol-\x}{dv-4!\mix!dv-7}%
                \colorlet{chapcol-\x-\y}
                    {dv-2!\mixvert!chapcol-\x}%
                \colorlet{appcol-\x}{ct4!\mix!da2}%
                \colorlet{appcol-\x-\y}{white!\mixvert!appcol-\x}%
            }%
        }%
    \else
        \foreach \x in {0,...,\alpth@totCols}{%
            \pgfmathsetmacro\leftTransp
                {100 *  \x    / \alpth@totCols}%
            \pgfmathsetmacro\rightTransp
                {100 * (\x+1) / \alpth@totCols}%
            \tikzfading[%
                name=hexfade \x,
                right color=transparent!\rightTransp,
                left color=transparent!\leftTransp]%
        }%
    \fi
}
\newcommand\fullhexpage[2]{%
    \ifhex
        \tikzset{external/export next=false}%
        \begin{tikzpicture}[remember picture,overlay,x=1cm,y=1cm]
            \path[clip]
                (current page.north west)
                rectangle
                (current page.south east);
            \foreach \y in {0,...,\alpth@totRows} {%
                \foreach \x in {0,...,\alpth@totCols} {%
                    \pgfmathsetmacro\alpth@isodd{mod(\x,2)}
                    \fill[fill=br2,draw=br1]
                        ($(current page.north west) +
                            (1.5 * \x * \alpth@side,
                                \alpth@isodd * \alpth@height -
                                \y * 2 * \alpth@height)$)
                        -- ++(   0:\alpth@side)
                        -- ++( -60:\alpth@side)
                        -- ++(-120:\alpth@side)
                        -- ++(-180:\alpth@side)
                        -- ++(-240:\alpth@side) -- cycle;
                }
            }
            % Create vertical contrast bar on left side.
            % Put it inside scope for clipping.
            \begin{scope}
                \path[clip]
                    (current page.north west)
                    rectangle
                    ($(current page.south west) +
                    (3.5 * \alpth@side,0)$);
                \foreach \y in {0,...,\alpth@totRows} {%
                    \foreach \x in {0,...,2} {%
                        \pgfmathsetmacro\alpth@isodd{mod(\x,2)}
                        \fill[fill=#1,draw=#2]
                            ($(current page.north west) +
                                (1.5 * \x * \alpth@side,
                                     \alpth@isodd * \alpth@height -
                                     \y * 2 * \alpth@height)$)
                            -- ++(   0:\alpth@side)
                            -- ++( -60:\alpth@side)
                            -- ++(-120:\alpth@side)
                            -- ++(-180:\alpth@side)
                            -- ++(-240:\alpth@side) -- cycle;
                    }
                }
            \end{scope}
        \end{tikzpicture}%
    \fi
}
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
\RequirePackage{amsmath}
\RequirePackage[separate-uncertainty=true]{siunitx}
\RequirePackage{counttexruns}
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
\newcommand\alpth@hexagons{%
    \tikzset{external/export next=false}%
    \begin{tikzpicture}[remember picture,overlay,x=1cm,y=1cm]
        \ifpaper
            \path[clip]
                (current page.north west)
                rectangle
                ($(current page.north east) + (-0pt,-11 * \alpth@height)$);
        \else
            \path[clip]
                (current page.north west)
                rectangle
                (current page.east);
        \fi
        \foreach \y in {0,...,\alpth@totRowsChap} {%
            \foreach \x in {0,...,\alpth@totCols} {%
                % Find out if we're in an odd or even column
                \pgfmathsetmacro\alpth@isodd{mod(\x,2)}
                \ifpaper
                    \fill[fill=hex-\x-\y,draw=hexframecol-\x-\y]
                \else
                    \fill[br0,draw=br1,path fading=hexfade \x]
                \fi
                    ($(current page.north west) +
                        (1.5 * \x * \alpth@side,
                         \alpth@isodd * \alpth@height - \y * 2 * \alpth@height)$)
                    -- ++(   0:\alpth@side)
                    -- ++( -60:\alpth@side)
                    -- ++(-120:\alpth@side)
                    -- ++(-180:\alpth@side)
                    -- ++(-240:\alpth@side) -- cycle;
            }%
        }%
    \end{tikzpicture}%
}
\newcommand\alpth@chapnumhexagons{%
    \tikzset{external/export next=false}
    \begin{tikzpicture}[remember picture,overlay,x=1cm,y=1cm]
        \path[clip]
            ($(current page.north west) + (0pt,-0pt)$)
            rectangle
            ($(current page.east) + (-0pt,0pt)$);

        \foreach \n in {1,...,\thechapter} {%
            \pgfkeysgetvalue{/chapter \thechapter/hexagon \n/x}{\x}
            \pgfkeysgetvalue{/chapter \thechapter/hexagon \n/y}{\y}
            % Find out if we're in an odd or even column
            \pgfmathsetmacro\alpth@isodd{mod(\x,2)}
            \ifpaper
                \fill[fill=chapcol-\x-\y,draw=br1]
            \else
                \fill[fill=dv-7,draw=br1,path fading=hexfade \x]
            \fi
                ($(current page.north west) +
                    (1.5 * \x * \alpth@side,
                     \alpth@isodd * \alpth@height - \y * 2 * \alpth@height)$)
                -- ++(   0:\alpth@side)
                -- ++( -60:\alpth@side)
                -- ++(-120:\alpth@side)
                -- ++(-180:\alpth@side)
                -- ++(-240:\alpth@side) -- cycle;
        }%
    \end{tikzpicture}%
}
\newcommand\alpth@appnumhexagons{%
    \tikzset{external/export next=false}
    \begin{tikzpicture}[remember picture,overlay,x=1cm,y=1cm]
        \path[clip]
            ($(current page.north west) + (0pt,-0pt)$)
            rectangle
            ($(current page.east) + (-0pt,0pt)$);

        \foreach \n in {A,...,\thechapter} {%
            \pgfkeysgetvalue{/appendix \thechapter/hexagon \n/x}{\x}
            \pgfkeysgetvalue{/appendix \thechapter/hexagon \n/y}{\y}
            % Find out if we're in an odd or even column
            \pgfmathsetmacro\alpth@isodd{mod(\x,2)}
            \ifpaper
                \fill[fill=appcol-\x-\y,draw=br1]
            \else
                \fill[ct4,draw=br1,path fading=hexfade \x]
            \fi
                ($(current page.north west) +
                    (1.5 * \x * \alpth@side,
                     \alpth@isodd * \alpth@height - \y * 2 * \alpth@height)$)
                -- ++(   0:\alpth@side)
                -- ++( -60:\alpth@side)
                -- ++(-120:\alpth@side)
                -- ++(-180:\alpth@side)
                -- ++(-240:\alpth@side) -- cycle;
        }%
    \end{tikzpicture}%
}
\newcommand\alpth@bottomscreen{%
    \tikzset{external/export next=false}%
    \begin{tikzpicture}[remember picture,overlay,x=1cm,y=1cm]
        \path[clip]
            (current page.north west)
            rectangle
            (current page.east);

        \ifpaper\else
            \fill[white,path fading=north]%
                ($(current page.north west) - (0pt, 10.5 * \alpth@side)$)
                rectangle
                ($(current page.north east) - (0pt,2 * \alpth@side)$);%
        \fi
    \end{tikzpicture}%
}
\newlength{\edgewidth}
\makechapterstyle{alpenthesis}{%
    % Lengths
    \setlength{\afterchapskip}{40pt}%
    \renewcommand*{\chapterheadstart}
        %{\vspace*{40pt}}%
        {\ifhex\alpth@hexagons\fi\vspace*{40pt}}%
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
        \ifhex\alpth@chapnumhexagons\fi%
        \alpth@bottomscreen%
        \chapnamefont\MakeTextUppercase{\@chapapp}%
    }%
    \renewcommand*\printchapternonum{\alpth@bottomscreen}%
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
        {\ifhex\alpth@hexagons\fi\vspace*{40pt}}%
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
        \ifhex\alpth@appnumhexagons\fi%
        \alpth@bottomscreen%
        \chapnamefont\MakeTextUppercase{\@chapapp}%
    }
    \renewcommand*\printchapternonum{\alpth@bottomscreen}%
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
\newcommand*\pacname[1]{\textsf{#1}}
\newcommand*\code[1]{\texttt{#1}}
\newcommand*\athes{\pacname{alpenthesis}}
\input{randInts.tex}
