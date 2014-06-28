"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"==============================================================================
"  GetLatestVimScripts: 3772 1 :AutoInstall: rainbow_parentheses.zip

com! RainbowParenthesesToggle       cal rainbow_parentheses#toggle()
com! RainbowParenthesesToggleAll    cal rainbow_parentheses#toggleall()
com! RainbowParenthesesLoadRound    cal rainbow_parentheses#load(0)
com! RainbowParenthesesLoadSquare   cal rainbow_parentheses#load(1)
com! RainbowParenthesesLoadBraces   cal rainbow_parentheses#load(2)
com! RainbowParenthesesLoadChevrons cal rainbow_parentheses#load(3)

if (exists('g:rainbow_active') && g:rainbow_active)
	au VimEnter * RainbowParenthesesToggle
	au Syntax * RainbowParenthesesLoadRound
	au Syntax * RainbowParenthesesLoadSquare
	au Syntax * RainbowParenthesesLoadBraces
endif