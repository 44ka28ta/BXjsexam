BXjsexam Package
=====

This package provides an document class for Japanese examination.

System Requirement
=====

* Prerequisite document class
	* BXjsarticle
* Prerequisite packages
	* caption
	* tcolorbox
	* array
	* tabularx
	* colortbl
	* fancyhdr
	* diagbox
	* ifthen
	* zref-lastpage
	* enumitem
* Prerequisite packages for quenstionnaire option
	* tikzpagenodes
	* xcolor

Unique Class Options
=====

* `a3papers`
* `namefield`
	* `both`
* `numbering`
* `twoside`
* `answers`
* `quenstionnaire`

### Global commands

* `\class`
* `\classaux`
* `\use`
* `\papers`
* `\maintitle`
* `\InitGeometries`

### Local commands for answers option

* `\backslashing`
* `\setrowpaddingscalingfactor`
* `\unitedcolumns`

### Local command for quenstionnaire option

* `\DrawLegalPadLines`

### Local command for question

* `\filledAnswerColumn`
	* If you write answer in question box, then you can write as follows:
		* `\filledAnswerColumn[This is an answer.]`
* `\shortAnswerColumn`
	* If you write answer in question box, then you can write as follows:
		* `\shortAnswerColumn[C]`
* `\createChoices`
	* If you draw options, then you can write at most 5 options as follows:
		* `\createChoices{option1}{option2}{option3}`
* Katakana label for enumerate environment (by enumitem package)
	* If you use Katakana enumeration, then you can start to write at most 8 enumrations as follows:
		* `\begin{enumerate}[label=(\Katakana*)]`

### Notes

* The recommended default fontsizes of landscape A3paper with double columns and portrait A4paper are 12pt. However, the recommended fontsize of portrait A3paper is 10pt.
