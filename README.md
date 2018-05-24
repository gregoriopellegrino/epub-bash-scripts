# Bash scripts for EPUB production #eprdctn
A collection of bash scripts (developed on Mac) that can help in the making of  perfect crafted EPUBs.
## Getting started

 - install *pup*: https://github.com/ericchiang/pup
 - download scripts: 
## Scripts
### assignTitles<span></span>.sh
This script replace the `<title>` value of each HTML document in the EPUB with the first  occurance of the most important heading in it.
#### Usage

    /path_to/assignTitles.sh /path_to/OEBPS
### mapEpubTypeToRole<span></span>.sh
This script assigns ARIA `role` attribute to all HTML elements that have an `epub:type` attribute (as `role` is missing).
The mapping is based on https://idpf.github.io/epub-guides/aria-mapping/
#### Usage

    /path_to/mapEpubTypeToRole.sh /path_to/OEBPS
### pxToEm<span></span>.sh
This script converts `px` values (in CSS) to `em`.
#### Usage

    /path_to/mapEpubTypeToRole.sh /path_to/OEBPS

## Disclaimer

 1. Some of the scripts use regex for HTML manipulation: please note that HTML should not be regexed! The end is nigh.
 2. Pixels should not be transformed in em: pixels are an absolute unit of measures, ems depends on the parent element (https://stackoverflow.com/a/4575518)
 3. Use these script at your own risk!
