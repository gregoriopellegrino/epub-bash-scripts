#!/bin/bash

# This script is part of Bash scripts for EPUB production #eprdctn
# url: https://github.com/gregoriopellegrino/epub-bash-scripts/
# author: Gregorio Pellegrino
# license: MIT License https://github.com/gregoriopellegrino/epub-bash-scripts/blob/master/LICENSE

# This script uses pup: https://github.com/ericchiang/pup
# Mapping is based on https://idpf.github.io/epub-guides/aria-mapping/

# DISCLAIMER
# This script uses regex for HTML manipulation: please note that HTML should not be regexed! The end is nigh.
# Use these script at your own risk!

version="1.0"
dir_path="$1"

find "$dir_path" -name '*.xhtml' -or -name '*.html' |
while read file_path; do
	elements=$(cat "$file_path" | pup -l 0 --charset utf8 '[epub:type]:not([role])')

	echo "$file_path"

	while read element ; do
		epub_type=$(
			echo "$element" |
			grep --extended-regexp --color -oi -e "epub:type\s*=\s*\"([^\"]+)\"" |
			grep --extended-regexp --color -oi -e "\"([^\"]+)\"" |
			grep --extended-regexp --color -oi -e "([^\"]+)"
		)
		open_tag=$(
			echo "$element" |
			grep --extended-regexp --color -oi -e "<\s*[^/?]{1}[^>]*>"
		)
		if [ "$epub_type" != "" ]; then
		
			role=""
		
			case "$epub_type" in
				"abstract") role="doc-abstract";;
				"acknowledgments") role="doc-acknowledgments";;
				"afterword") role="doc-afterword";;
				"appendix") role="doc-appendix";;
				"biblioentry") role="doc-biblioentry";;
				"bibliography") role="doc-bibliography";;
				"biblioref") role="doc-biblioref";;
				"chapter") role="doc-chapter";;
				"colophon") role="doc-colophon";;
				"conclusion") role="doc-conclusion";;
				"cover") role="doc-cover";;
				"credit") role="doc-credit";;
				"credits") role="doc-credits";;
				"dedication") role="doc-dedication";;
				"endnote") role="doc-endnote";;
				"endnotes") role="doc-endnotes";;
				"epigraph") role="doc-epigraph";;
				"epilogue") role="doc-epilogue";;
				"errata") role="doc-errata";;
				"footnote") role="doc-footnote";;
				"foreword") role="doc-foreword";;
				"glossary") role="doc-glossary";;
				"glossref") role="doc-glossref";;
				"index") role="doc-index";;
				"introduction") role="doc-introduction";;
				"noteref") role="doc-noteref";;
				"notice") role="doc-notice";;
				"page-list") role="doc-pagelist";;
				"pagebreak") role="doc-pagebreak";;
				"part") role="doc-part";;
				"preface") role="doc-preface";;
				"prologue") role="doc-prologue";;
				"pullquote") role="doc-pullquote";;
				"qna") role="doc-qna";;
				"referrer") role="doc-backlink";;
				"subtitle") role="doc-subtitle";;
				"tip") role="doc-tip";;
				"toc") role="doc-toc";;
			esac
		
			if [ "$role" != "" ]; then
				echo -e "\tMapping epub:type=\"$epub_type\" to role=\"$role\""
				new_tag=${open_tag/>/ role=\"$role\">}
				#echo "$open_tag"
				#echo "$new_tag"
				sed -i '' -e "s/$open_tag/$new_tag/g" "$file_path"
			fi
		fi
	done <<< "$elements"
done
