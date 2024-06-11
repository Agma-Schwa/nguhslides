%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NGUHSLIDES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This is a lightweight alternative to the 'beamer' class with additional
%% functionality geared mainly towards linguistics. It is mostly used to
%% typeset slides for the Agma Schwa YouTube channel.
%%
%% Below is a list of macros and enviroments provided by this class.
%%
%% Macros that deal with typesetting are lowercase, whereas macros that
%% pass options to the class or affect global settings use PascalCase.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Typesetting Macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% =====================================================================
%% \section : Start a new section
%% =====================================================================
%%
%% Example:
%%
%%   \section{Syntax}
%%
%% This starts a new ‘section’, i.e. it creates a slide whose only content
%% is its argument centred vertically and horizontally; additionally, it will
%% insert a \slide with the same name as the section. You can suppress this
%% behaviour by writing \section* instead.
%%
%% =====================================================================
%% \slide : Start a new slide
%% =====================================================================
%%
%% Example:
%%
%%   \slide{Word Order}
%%
%% This starts a new slide with the argument given as the slide title.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% =====================================================================
%% narrow : Make the contents of the environment narrower
%% =====================================================================
%%
%% Example:
%%
%%   \begin{narrow}[1cm]
%%       ...
%%   \end{narrow}
%%
%% This increases the right and left margin of the content within the
%% environment by the specified amount. If no amount is given, '.5cm'
%% is used.
%%
%% =====================================================================
%% items : Basically 'itemize'
%% =====================================================================
%%
%% Example:
%%
%%   \begin{items}[*]
%%       \item Foo
%%       \begin{items}[-]
%%           \item Bar
%%       \end{items}
%%       \item Baz
%%   \end{items}
%%
%% This is a list environment that functions basically like 'itemize', but
%% with the indentation tweaked a bit to work better on a slide; you can
%% specify the marker to use as an optional argument. If not specified, this
%% will cycle through '•', '–', and '*' in nested lists.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% =====================================================================
%% \SetBackgroundImage : Set the background image
%% =====================================================================
%%
%% Example:
%%
%%   \SetBackgroundImage{background.png}
%%
%% This sets the background image for all slides. If no image is set, the
%% background will be white.
%%
%% =====================================================================
%% \SetFont : Set all fonts used by the class
%% =====================================================================
%%
%% Example:
%%
%%   \SetFont{Noto Sans}[Numbers=OldStyle]
%%
%% This sets the main font and title font to Noto Sans, as if by calling
%%
%%   \setmainfont{Noto Sans}[Numbers=OldStyle]
%%   \SetTitleFont{Noto Sans}[Numbers=OldStyle]
%%
%% =====================================================================
%% \SetTitleFont : Set the title font
%% =====================================================================
%%
%% Example:
%%
%%   \SetTitleFont{Noto Sans}[Numbers=OldStyle]
%%
%% This sets the font used for slide and section titles.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{nguhslides}{2024/06/08}{v1.0}{Class for slides posted on the Agma Schwa YT channel}
\ExplSyntaxOn % FIXME: Remove once my editor stops screaming at me for not including this.

%% We only support XeTeX and LuaTeX.
\sys_if_engine_xetex:F {
    \sys_if_engine_luatex:F {
        \msg_new:nnn  { nguhslides } { engine } { This~class~requires~XeLaTeX~or~LuaLaTeX. }
        \msg_fatal:nn { nguhslides } { engine }
    }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[12pt, oneside, landscape, final]{article}
\RequirePackage{fontspec}
\RequirePackage[english]{babel}
\RequirePackage{csquotes}
\RequirePackage{graphicx}
\RequirePackage{tabularx, array, multirow}
\RequirePackage{xcolor}
\RequirePackage{eso-pic}
\RequirePackage{ulem}
\RequirePackage{nguhslides/nguhgloss}
\RequirePackage[
    paperwidth  = 16cm,
    paperheight =  9cm,
    left        =  1.5cm,
    right       =  1.5cm,
    top         =  1cm,
    bottom      =  1cm
]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setmainfont { Noto~Sans }
\newfontfamily \g__nguh_title_font { Noto~Sans }
\tl_new:N \g__nguh_background_image_tl

%% Adjust page dimensions etc. This mainly boils down to disabling
%% margin pars, the header, footer, etc.
\pagestyle { empty }
\parsep      12pt
\headsep      1cm
\parindent    \z@
\headheight   \z@
\voffset      \z@
\marginparsep \z@
\topskip      \z@

%% Adjust list dimensions.
\itemsep      6pt

%% Make all spaces the same length after punctuation marks.
\frenchspacing

%% Adjust font size, colour etc.
\large

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Internals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set a background image.
\cs_new:Npn \__nguh_bg_image: {
    \tl_if_empty:NF \g__nguh_background_image_tl {
        \AddToShipoutPictureBG {
            \includegraphics [ width = \paperwidth, height = \paperheight ] {
                \tl_use:N \g__nguh_background_image_tl
            }
        }
    }
}

%% End a paragraph.
\cs_new:Npn \__nguh_end_par: {
    \ifvmode\else
        \unskip
        \par
    \fi
}

%% Current list depth.
\int_new:N \g__nguh_list_depth_int

%% Get the list marker based on the list depth.
\cs_new:Npn \__nguh_list_marker: {
    \int_case:nn { \int_mod:nn {\g__nguh_list_depth_int - 1} 3 } {
        { 0 } { • }
        { 1 } { – }
        { 2 } { * }
    }
}

%% Open a list.
\cs_new:Npn \__nguh_enter_list: {
    %% Advance listdepth and adjust left margin accordingly.
    \dim_set:Nn  \leftmargin { 25pt * \g__nguh_list_depth_int }
    \int_gincr:N \g__nguh_list_depth_int
}

%% Close a list.
\cs_new:Npn \__nguh_leave_list: {
    %% Decrease list depth. No reason to adjust the \leftmargin
    %% because we used a local assigment for that one anyway.
    \int_gdecr:N \g__nguh_list_depth_int
}

%% Create a centred horizontal rule with
%% a given width and height.
\cs_new:Npn \__nguh_centred_rule:nn #1#2 {
    \group_begin:
        \centering
        \nointerlineskip
        \vrule width #1 height #2
    \group_end:
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Interface
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sections in a presentation are a slide with centred text.
\RenewDocumentCommand \section {s m} {
    \clearpage
    \__nguh_bg_image:
    \nointerlineskip
    \vglue \z@ plus 1 fill
    \group_begin:
        \g__nguh_title_font
        \bfseries
        \scshape
        \fontsize { 48pt } { 48pt } \selectfont
        \centering
        #2
        \__nguh_end_par:
    \group_end:
    \vfill
    \IfBooleanF { #1 } {
        \slide { #2 }
    }
}

%% Individual slide.
\NewDocumentCommand \slide { m } {
    \clearpage
    \__nguh_bg_image:
    \group_begin:
        \centering
        \LARGE
        \g__nguh_title_font
        #1
        \vskip .5em
        \__nguh_centred_rule:nn { 8cm } { 1pt }
        \vskip .5em
    \group_end:
    \large
    \nointerlineskip
}

%% Set the background.
\NewDocumentCommand \SetBackgroundImage { m } {
    \tl_gset:Nn \g__nguh_background_image_tl { #1 }
}

%% Set a font.
\NewDocumentCommand \SetFont { mo } {
    \setmainfont { #1 } [ #2 ]
    \SetTitleFont { #1 } [ #2 ]
}

%% Set a title font only.
\NewDocumentCommand \SetTitleFont { mo } {
    \global \renewfontfamily \g__nguh_title_font { #1 } [ #2 ]
}

%% Items on a slide.
\NewDocumentEnvironment { items } { O{ \__nguh_list_marker: } } {
    \begin { list } { #1 } {
        \__nguh_enter_list:
    }
} {
    \end { list }
    \__nguh_leave_list:
}

%% Make paragraphs narrower.
\NewDocumentEnvironment { narrow } { O{.5cm} } {
    \leftskip #1
    \rightskip #1
} {
    \__nguh_end_par:
    \leftskip \z@
    \rightskip \z@
    \addvspace{\medskipamount}
}
