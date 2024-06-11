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
%% \gloss : Format a 2, 4, or 5-line gloss.
%% =====================================================================
%%
%% Example:
%%
%%   \gloss {
%%       Caesar     | pisc-em     | ēm-it
%%       Caesar.nom | fish-acc.sg | buy-3sg.past
%%   }
%%
%% A | delimits columns. You don’t need to line up the columns manually;
%% this was only done here for demonstration purposes. There is also a
%% 4/5-line format if you want to include the original spelling, pronunciation
%% and translation:
%%
%%   \gloss {
%%       Caesar piscem ēmit.
%%       Caesar     | pisc-em     | ēm-it
%%       ˈkae.sar   | pis.kẽˑ     | ˈeː.mɪt      % You can also omit this line.
%%       Caesar.nom | fish-acc.sg | buy-3sg.past
%%       ‘Caesar bought a fish.’
%%   }
%%
%% The first line (the text) is typeset in bold+italic, the second line
%% in italic, any other lines in roman.
%%
%% =====================================================================
%% \multigloss : Format a gloss across multiple lines
%% =====================================================================
%%
%% Example:
%%
%%   \multigloss {
%%       Caesar     | pisc-em     | ēm-it
%%       Caesar.nom | fish-acc.sg | buy-3sg.past
%%   }
%%
%%
%% The syntax of this is identical to \gloss, except that only the 2-line
%% format is supported. Unlike \gloss, which always typesets everything in
%% a single line, this will automatically break the gloss into multiple lines
%% if it would run into the page margin. Use this for longer glosses.
%%
%% You can also put the gloss on multiple lines in the source code; this
%% doesn’t have any effect on the output, but may help to make it more
%% readable:
%%
%%   \multigloss {
%%       Caesar     | pisc-em
%%       Caesar.nom | fish-acc.sg
%%
%%       ēm-it
%%       buy-3sg.past
%%   }
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
\cs_generate_variant:Nn \seq_set_split_keep_spaces:Nnn { Nnx }

%% Set a background image.
\cs_new:Npn \__nguh_bg_image:n #1 {
     \AddToShipoutPictureBG {
         \includegraphics[width=\paperwidth, height=\paperheight]{#1}
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
%% Glossing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\cs_new:Npn \__nguh_gloss_insert_table_header: {
    %% Generating columns doesn’t seem to work, so this hack will do. If you
    %% need a gloss with more columns than this, I suggest you pause and take
    %% a moment to reflect on your life choices.
    \begin {tabular} { @{} *{100}l }
}

\cs_new:Npn \__nguh_gloss_table_start: {
    \__nguh_end_par:
    \addvspace { 8pt }
    %\vtop{\iffalse}\fi
    \noindent
}

\cs_new:Npn \__nguh_gloss_table_end: {
    \end {tabular}
    \ifvmode\else\par\fi
    \addvspace { 8pt }
    %\iffalse{\fi}
    \everypar { \setbox\z@\lastbox \everypar{} }
}

%% Rescan a token list.
\cs_new:Npn \__nguh_gloss_rescan:n #1 {
    { \tl_rescan:nn {} { #1 } }
}

%% Format a single line of a gloss.
%%
%% The line number must be stored in \g_tempb_int.
%%
%% This takes the line #1 and formats it, inserting the contents of #2
%% at the start of each line, and #3 at the beginning of each column.
%% #3 can be a macro that takes one argument, in which case it will be
%% passed the contents of the column.
\cs_new:Npn \__nguh_gloss_format_line:nnn #1 #2 #3 {
    #2

    \seq_set_split:Nnn \l_tmpa_seq { | } { #1 }
    \bool_set_true:N \l_tmpa_bool

    \seq_map_inline:Nn \l_tmpa_seq {
        \bool_if:NF \l_tmpa_bool { & }
        \bool_set_false:N \l_tmpa_bool
        #3 { \__nguh_gloss_rescan:n {##1} }
    }
}

%% Format a gloss.
%%
%% This iterates over all lines in #1 and calls #2 on it.
\cs_new:Npn \__nguh_gloss_format:nn #1 #2 {
    \int_gset:Nn \g_tmpb_int { 1 }
    \tl_map_inline:nn { #1 } {
        \tl_if_blank:nF { ##1 } {
            %% Insert \cr or table header if this is the first line. We
            %% need to emit this here, as otherwise, TeX will encounter
            %% unexpandable tokens before the formatter (#2) is executed,
            %% which will start the cell before any actual content has
            %% been inserted; this means we can no longer tell TeX to
            %% \omit the cell header, which causes \multicolumn to break
            %% horribly.
            %%
            %% By emitting the table header here, we ensure that instead,
            %% the formatter is the first thing TeX gets to see after the
            %% initial table header and after every \cr.
            \int_compare:nNnTF { \g_tmpb_int } > { 1 } { \\ } { \__nguh_gloss_insert_table_header: }
            #2 { ##1 }
            \int_gincr:N \g_tmpb_int
        }
    }
}

%% Two lines means object language + gloss.
\cs_new:Npn \__nguh_gloss_two_lines:n #1 {
    \cs_gset:Npn \__formatter:n ##1 {
        \__nguh_gloss_format_line:nnn { ##1 } {} {
            \int_compare:nNnTF { \g_tmpb_int } = { 1 } { \itshape } { \scshape }
        }
    }

    \__nguh_gloss_format:nn { #1 } { \__formatter:n }
}

%% Full gloss (text, object language, pronunciation, gloss, and translation).
\cs_new:Npn \__nguh_gloss_five_lines:n #1 {
    \cs_gset:Npn \__formatter_i:n   ##1 { \multicolumn {100} {@{}l} {\itshape\bfseries\__nguh_gloss_rescan:n {##1}} }
    \cs_gset:Npn \__formatter_ii:n  ##1 { \__nguh_gloss_format_line:nnn {##1} {} {\itshape} }
    \cs_gset:Npn \__formatter_iii:n ##1 { \__nguh_gloss_format_line:nnn {##1} {} {} }
    \cs_gset:Npn \__formatter_iv:n  ##1 { \__nguh_gloss_format_line:nnn {##1} {} {\scshape} }
    \cs_gset:Npn \__formatter_v:n   ##1 { \multicolumn {100} {@{}l} {\__nguh_gloss_rescan:n {##1}} }

    \__nguh_gloss_format:nn { #1 } {
        \cs:w __formatter_ \int_to_roman:n \g_tmpb_int :n \cs_end:
    }
}

%% Full gloss w/o IPA (text, object language, gloss, and translation).
\cs_new:Npn \__nguh_gloss_four_lines:n #1 {
    \cs_gset:Npn \__formatter_i:n   ##1 { \multicolumn {100} {@{}l} {\itshape\bfseries \__nguh_gloss_rescan:n {##1} } }
    \cs_gset:Npn \__formatter_ii:n  ##1 { \__nguh_gloss_format_line:nnn {##1} {} {\itshape} }
    \cs_gset:Npn \__formatter_iii:n ##1 { \__nguh_gloss_format_line:nnn {##1} {} {\scshape} }
    \cs_gset:Npn \__formatter_iv:n  ##1 { \multicolumn {100} {@{}l} {\__nguh_gloss_rescan:n {##1}} }

    \__nguh_gloss_format:nn { #1 } {
        \cs:w __formatter_ \int_to_roman:n \g_tmpb_int :n \cs_end:
    }
}

%% Process two words. Used by \multigloss.
\cs_new:Npn \__nguh_multigloss_word:nn #1#2 {
    \allowbreak

    \hbox {
        \begin{tabular}{@{}l}
            \itshape \tl_rescan:nn {} {#1} \\
            \noalign{\vskip-6pt}
            \scshape \tl_rescan:nn {} {#2} \\
        \end{tabular}
    }

    \space
}

%% Process two lines. Used by \multigloss.
\cs_new:Npn \__nguh_multigloss:NN #1 #2 {
    \ifvmode\noindent\leavevmode\fi

    %% Split the lines into words.
    \seq_set_split_keep_spaces:Nnx \l_tmpa_seq { | } { #1 }
    \seq_set_split_keep_spaces:Nnx \l_tmpb_seq { | } { #2 }

    %% Iterate over each word in the two lines.
    \seq_mapthread_function:NNN \l_tmpa_seq \l_tmpb_seq \__nguh_multigloss_word:nn
}

\NewDocumentCommand \gloss {
    > { \exp_args:Nx \SplitList { \iow_char:N \^^M } } +v
} {
    \__nguh_gloss_table_start:

    %% Count lines.
    \int_gset:Nn \g_tmpa_int { 0 }
    \tl_map_inline:nn { #1 } {
        \tl_if_blank:nF { ##1 } {
            \int_gincr:N \g_tmpa_int
        }
    }

    %% Dispatch the appropriate number of lines.
    \int_case:nnF { \g_tmpa_int } {
        2 { \__nguh_gloss_two_lines:n { #1 } }
        4 { \__nguh_gloss_four_lines:n { #1 } }
        5 { \__nguh_gloss_five_lines:n { #1 } }
    } {
        %% Any other line count is an error.
        \msg_new:nnn { gloss } { too-many-lines } {
            Unexpected~number~of~lines~in~gloss:~expected~2/4/5~got~\int_use:N \g_tmpa_int
        }

        \msg_error:nn { gloss } { too-many-lines }
    }

    %% Close the table.
    \__nguh_gloss_table_end:
}

%% Typeset two-line glosses across multiple lines.
\NewDocumentCommand \multigloss {
    > { \exp_args:Nx \SplitList { \iow_char:N \^^M } } +v
} {
    \__nguh_end_par:
    \group_begin:
    \linespread { 1.5 } \selectfont
    \raggedright
    \begin{sloppypar}

    %% Iterate over each line, two lines at a time.
    \bool_gset_true:N \g_tmpa_bool
    \tl_map_inline:nn { #1 } {
        %% Ignore empty lines entirely.
        \tl_if_blank:nF { ##1 } {
            \bool_if:NTF \g_tmpa_bool {
                \tl_gset:Nn \g_tmpa_tl { ##1 }
            } {
                \tl_gset:Nn \g_tmpb_tl { ##1 }
                \__nguh_multigloss:NN \g_tmpa_tl \g_tmpb_tl
            }

            %% Flip.
            \bool_gset_inverse:N \g_tmpa_bool
        }
    }

    \end{sloppypar}
    \group_end:
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Interface
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sections in a presentation are a slide with centred text.
\RenewDocumentCommand \section {s m} {
    \clearpage
    \__nguh_bg_image:n { background.png }
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
    \__nguh_bg_image:n { background.png }
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

