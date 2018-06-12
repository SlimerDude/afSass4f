
** Sass compilation results.
class SassResult {

	** The input Scss file.
	File? inputFile
	
	** The compiled CSS.
	Str css
	
	** The compiled source map.
	Str	sourceMap
	
	** The options used to compile the Sass files.
	SassOptions options
	
	internal new make(|This|in) { in(this) }
	
	** A really shitty version of Autoprefixer.
	** https://github.com/postcss/autoprefixer
	Void autoprefix() {
		css = css
			.replace(";appearance: none", ";appearance: none;-moz-appearance: none;-webkit-appearance: none")
	}
	
	** Saves the CSS to the given file.
	** 
	** If the given file is a directory then the resulting filename is taken from the input file with a '.css' extension.
	** The parent directory is created if it does not exist.  
	Void saveCss(File cssFile) {
		saveStr(cssFile, ".css", css)
	}
	
	** Saves the source map to the given file.   
	** 
	** If the given file is a directory then the resulting filename is taken from the input file with a '.css.map' extension.
	** The parent directory is created if it does not exist.  
	Void saveSourceMap(File sourceMapFile) {
		saveStr(sourceMapFile, ".css.map", sourceMap)
	}
	
	private Void saveStr(File file, Str ext, Str content) {
		parent	:= file.isDir ? file : file.parent
		name	:= file.isDir ? inputFile.basename + ext : file.name 
		outFile	:= parent.plus(name.toUri)

		outFile.parent.create
		outFile.out.writeChars(content).close
	}
}
