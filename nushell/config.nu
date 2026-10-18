# Nushell Config File

# For more information on themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
let dark_theme = {
  # leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
  header: green_bold
  # Closures can be used to choose colors for specific values.
  # The value (in this case, a bool) is piped into the closure.
  bool: {|| if $in { 'light_cyan' } else { 'light_gray' } }
  filesize: {|e|
    if $e == 0b {
      'white'
    } else if $e < 1mb {
      'cyan'
    } else { 'blue' }
  }
  datetime: {|| (date now) - $in |
    if $in < 1hr {
      'purple'
    } else if $in < 6hr {
      'red'
    } else if $in < 1day {
      'yellow'
    } else if $in < 3day {
      'green'
    } else if $in < 1wk {
      'light_green'
    } else if $in < 6wk {
      'cyan'
    } else if $in < 52wk {
      'blue'
    } else { 'dark_gray' }
  }
  search_result: { bg: dark_gray fg: white }
}

$env.config.show_banner = false
$env.config.rm.always_trash = true
$env.config.explore.selected_cell = { bg: dark_gray }
$env.config.history.max_size = 100_000
$env.config.history.file_format = "plaintext"
$env.config.completions.algorithm = "fuzzy"
$env.config.cursor_shape.emacs = "line"
$env.config.buffer_editor = "nvim"
$env.config.filesize.unit = 'binary'
$env.config.max_last_result_size = 1MiB
$env.config.use_kitty_protocol = true
# $env.config.completions.cache_size = 100

$env.config.shell_integration.osc7 = ($nu.os-info.name != windows)
$env.config.shell_integration.osc9_9 = ($nu.os-info.name == windows)
$env.config.shell_integration.osc133 = false

# Before Nushell output is displayed in the terminal
# $env.config.hooks.display_output = "if (term size).columns >= 100 { table -e } else { table }"
$env.config.hooks.display_output = "table --icons"

$env.config.highlight_resolved_externals = true
$env.config.color_config = $dark_theme

# test with [{a: 1} {b: 2} {c: 3}]
$env.config.table.missing_value_symbol = "∅"
$env.config.color_config.empty = {attr: d, fg: red}

### Keybindings
$env.config.keybindings ++= [
  {
    name: ls
    modifier: control
    keycode: char_i
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { edit: CutFromStart }
      { edit: InsertString, value: " l" }
      { send: Enter }
    ]
  }
  {
    name: dirs_next
    modifier: alt
    keycode: right
    mode: [emacs vi_insert vi_normal]
    event: {
      send: executehostcommand
      cmd: 'dirs next'
    }
  }
  {
    name: dirs_prev
    modifier: alt
    keycode: left
    mode: [emacs vi_insert vi_normal]
    event: {
      send: executehostcommand
      cmd: 'dirs prev'
    }
  }
]

$env.config.abbreviations = {
  v: 'nvim'
  y: 'yazi'
  gu: 'gitui'
  lg: 'lazygit'
  ga: 'git add'
  gd: 'git diff'
  gds: 'git diff --staged'
  gp: 'git push'
  gb: 'git branch --sort=committerdate'
  gst: 'git status'
  gr: 'cd (git rev-parse --show-toplevel)'
}

### Aliases
alias md = mkdir
alias pwd = echo $env.PWD
alias ll = eza -la -s Name --binary --git --icons --group-directories-first
alias g = git --no-pager
alias gi = git rev-parse --abbrev-ref HEAD # in git
alias ti = commandline edit --replace $"timeit {(history | last 1 | first | get command)}" # a shortcut to apply timeit to the previous command

### Functions
def uptime [] {
  (sys host).uptime
}

def mem [] {
  (sys mem) | select total free used
}

# cmd duration
def dur [] {
  $env.CMD_DURATION_MS + 'ms' | into duration
}

# Set tab title
def title [name?: string] {
  if ($name == null) {
    $"(ansi title)($env.PWD | path basename)(ansi st)" | print -n
  } else {
    $"(ansi title)($name)(ansi st)" | print -n
  }
}

# Set tab color
def color [idx: int] {
  ansi -e ( ["2;15;", ($idx | into string), (",|") ] | str join )
}

# interactive global search with rg and fzf and open in hx
def rghx [] {
  let li = ((rg -e '.' --no-heading -n --color always | fzf --ansi) | lines |  split row ':')
  hx ([$li.0, ':', $li.1] | str join)
}

# search for files with fd and preview them with fzf
def fs [...args] {
  # fd ...$args -H -t f -E .git -E node_modules | fzf --multi --preview 'bat -pp --color=always --line-range :300 {}' | str trim | lines
  fzf --with-shell 'nu --no-std-lib --no-config-file -c' --multi --preview='use fzf-utils.nu *; preview-file {}' | str trim | lines
}

# search for files with fd and preview them with fzf and open them with nvim
def fe [...args] {
  # let file = (fd -H -e txt -e json -e js -e jsx -e ts -e tsx -e css -e html -e md -e lua | fzf --multi --preview 'bat --style=numbers --color=always --line-range :500 {}' | decode utf-8 | str trim | lines)
  let files = (fs ($args | to text))
  if not ($files | is-empty) {
    nvim ...$files
  }
}

# search for media files with fd and fzf and open them with mpv
def fm [...args] {
  let files = (fd ...$args -e mp4 -e m4a -e webm -e mkv -e gif | fzf --scheme=path --multi | str trim | lines)
  if not ($files | is-empty) {
    let full_path = ($files | each {|it| $"($env.PWD)\\($it)"})
    mpv ...$full_path
  }
}

# histry with fzf
def fh [] {
  commandline edit --replace (history | get command | uniq | reverse | str join (char -i 0) | fzf --read0 --scheme=history --layout=reverse --multi  | decode utf-8 | str trim)
}

# get aliases
def get-aliases [] {
  # open $nu.config-path | lines | find alias | find -v aliases | split column '=' | select column1 column2 | rename Alias Command | update Alias {|f| $f.Alias | split row ' ' | last} | sort-by Alias
  scope aliases | update expansion { |c| $c.expansion | nu-highlight } | select name expansion description
}

# alias the built in ls command so we don't shadow it
alias ls-builtin = ls

# List the filenames, sizes, and modification times of items in a directory.
@category filesystem
@search-terms dir
@example "List the files in the current directory" { ls }
@example "List visible files in a subdirectory" { ls subdir }
@example "List visible files with full path in the parent directory" { ls -f .. }
@example "List Rust files" { ls *.rs }
@example "List files and directories whose name do not contain 'bar'" { ls | where name !~ bar }
@example "List the full path of all dirs in your home directory" { ls -a ~ | where type == dir }
@example "List only the names (not paths) of all dirs in your home directory which have not been modified in 7 days" { ls -as ~ | where type == dir and modified < ((date now) - 7day) }
@example "Recursively list all files and subdirectories under the current directory using a glob pattern" { ls -a **/* }
@example "Recursively list *.rs and *.toml files using the glob command" { ls ...(glob **/*.{rs,toml}) }
@example "List given paths and show directories themselves" { ['/path/to/directory' '/path/to/file'] | each {|| ls -D $in } | flatten }
def ls [
  --all (-a), # Show hidden files
  --long (-l), # Get all available columns for each entry (slower; columns are platform-dependent)
  --short-names (-s), # Only print the file names, and not the path
  --full-paths (-f), # display paths as absolute paths
  --du (-d), # Display the apparent directory size ("disk usage") in place of the directory metadata size
  --directory (-D), # List the specified directory itself instead of its contents
  --mime-type (-m), # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
  --threads (-t), # Use multiple threads to list contents. Output will be non-deterministic.
  ...pattern: glob, # The glob pattern to use.
]: [nothing -> table] {
  let pattern = if ($pattern | is-empty) { ['.'] } else { $pattern }
  (
    ls-builtin
    --all=$all
    --long=$long
    --short-names=$short_names
    --full-paths=$full_paths
    --du=$du
    --directory=$directory
    --mime-type=$mime_type
    --threads=$threads
    ...$pattern
  ) | sort-by type name -i
}

# ls sorted by type and without the type column
def l [
  --reverse(-r) # reverse order
  --type(-t) # sort-by type
  --modified(-m) # sort-by modified
  --extension(-e) # sort-by extension
  ...pattern: glob, # The glob pattern to use.
] {
  let pattern = if ($pattern | is-empty) { ['.'] } else { $pattern }
  let columns = if ($type and $modified) {
    [$.type $.modified]
  } else if ($modified) {
    [$.modified]
  } else {
    [$.type $.name]
  }
  if ($extension) {
    ls --all | where type == file | sort-by --reverse=$reverse { get name | path parse | get extension } ...$columns | select name size modified
  } else {
    ls --all ...$pattern | sort-by --reverse=$reverse ...$columns | select name size modified
  }
}

def lsg [] {
  ls --all | sort-by type name | grid -ic
}

# structured eza
def la [path:glob = '.'] {
  eza $path -la -s Name --binary --git --header --group-directories-first --time-style long-iso | detect columns -c 2..3 |
  update Size {|row|
    if ($row.Size == '-') {
      null
    } else {
      $row.Size | str replace ',' '' | into filesize
    }
  } | into datetime Date | reject Mode | rename --block {str lowercase} | metadata set --path-columns [name]
  | move size date --after name | rename --column {date: modified}
}

# search for specific process
def psn [name: string] {
  ps | find -i $name
}

# Kill all processes matching search
def killn [
  --ignore-case(-i) # Ignore capitalization
  --force(-f) # Force close processes
  regex: string # Pattern to match proceeses on
]: nothing -> list {
  let ignore = if $ignore_case { '(?i)' } else { '' }
  ps | where name =~ $'($ignore)($regex)' | tee {
    match $in.pid? { [$a ..$b] => {
      if $force { kill --force $a ...$b } else {
        kill $a ...$b }
    }}
  }
}

# tldr with fzf
def tldrfzf [] {
  tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | tldr $in
}

def countryfzf [] {
  countryfetch --list-countries | lines | skip 3 | to text | fzf --multi --accept-nth -1 | lines | countryfetch ...$in
}

# git checkout interactive
def gci [] {
  git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} | delta" | str trim | git checkout $in
}

# git diff preview
def gdp [] {
  let files = git diff --name-only | fzf --multi --preview 'git diff {} | delta --paging=never' | lines
  if ($files | is-not-empty) {
    git diff ...$files | delta --paging=never
  }
}

# push to git
def git-push [m: string] {
  git add -A
  git status
  git commit -am $"($m)"
  git push origin main
}

# git log (count)
def gl [count: int = 10] {
  git log $'--max-count=($count)' --color=always
}

def git-branches [] {
  git branch --list | lines | each { parse -r '(\*)?\s+(\S+)' | get 0 } | rename active name | update active { $in == "*" }
}

# Universal help command, combining https://tldr.sh/ with nushell’s help for built-ins:
def ? [...terms] {
  if (
    which ($terms | first) | any { |it| $it.type != external or $it.path =~ ^Nushell }
  ) {
    help ($terms | str join " ")
  } else {
    tldr ($terms | str join "-")
  }
}

# Return random element from a list or a table
def get-random-entry [input] {
  $input | get (random int 0..(($input|length) - 1))
}

# Shortcut function and competitions to search for commands in the selected category of nushell
def "nu-complete help categories" [] {
  help commands | get category | uniq
}

def hc [category?: string@"nu-complete help categories"] {
  help commands | select name category description | move description --after name | where category =~ $category
}

def show_banner [] {
  let ellie = [
    "     __  ,"
    " .--()°'.'"
    "'|, . ,'  "
    ' !_-(_\   '
  ]
  print $"(ansi reset)(ansi green)($ellie.0)"
  print $"(ansi green)($ellie.1)  (ansi yellow) (ansi yellow_bold)Nushell (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
  print $"(ansi green)($ellie.2)  (ansi light_blue) (ansi light_blue_bold)RAM (ansi reset)(ansi light_blue)((sys mem).used) / ((sys mem).total)(ansi reset)"
  print $"(ansi green)($ellie.3)  (ansi light_purple)ﮫ (ansi light_purple_bold)Uptime (ansi reset)(ansi light_purple)((sys host).uptime)(ansi reset)"
}

# green echo
def echo-g [string:string] {
  echo $"(ansi -e { fg: '#A8D8B9' attr: b })($string)(ansi reset)"
}

# red echo
def echo-r [string:string] {
  echo $"(ansi -e { fg: '#ff0000' attr: b })($string)(ansi reset)"
}

# rm trough pipe
#
# Example
# ls *.txt | first 5 | rmp
def rmp [] {
  if not ($in | is-empty) {
    get name | ansi strip | par-each {|file| rm -rf $file }
  }
}

# cp trough pipe to same dir
def cpp [
  to: string # target directory
  #
  # Example
  # ls *.txt | first 5 | cpp ~/temp
] {
  get name | each { |file| echo $"copying ($file)..." ; cp -r $file ($to | path expand) }
}

# mv trough pipe to same dir
def mvp [
  to: string # target directory
  #
  # Example
  # ls *.txt | mvp ~/temp
] {
  get name | each { |file| echo $"moving ($file)..." ; mv $file ($to | path expand) }
}

# rename a file
def mvr [
  path: string # e.g: dir/subdir/file.txt
  moveto: string # e.g: %/file2.txt
  #
  # Example
  # mvr dir/subdir/file.txt %/file2.txt
] {
  mv $path ($moveto | str replace % ($path | path dirname))
}

# last n elements in history with highlight(default 100)
def h [n = 20] {
  # history | last $n | update command { |f| $f.command | nu-highlight }
  history | get command | uniq | last $n | each { |it| $it | nu-highlight } | wrap command
}

# short pwd
def pwds [] {
  $env.PWD | str replace $nu.home-dir '~'
}

# shorter pwd
def pwdss [sep?: string] {
  let sep = (if ($sep | is-empty) {
    char path_sep
  } else { $sep })

  let tokens = (
    ["!" $env.PWD] | str join
    | str replace (["!" $nu.home-dir] | str join) "~"
    | split row $sep
  )

  $tokens
  | enumerate
  | each {|it|
    $it.item
    | if ($it.index != (($tokens | length) - 1)) {
      str substring (
        if ($it.item | str starts-with '.') { 0..2 } else { 0..1 }
      )
    } else { $it.item }
  }
  | path join
}

# Function querying free online English dictionary API for definition of given word(s)
def dict [...word #word(s) to query the dictionary API but they have to make sense together like "martial law", not "cats dogs"
] {
  let query = ($word | str join %20)
  let link = ('https://api.dictionaryapi.dev/api/v2/entries/en/' + $query)
  let output = (http get -e $link | rename word)
  if ($output.word == "No Definitions Found") {
    echo $output.word
  } else {
    echo $output.meanings | flatten | get definitions  | flatten
  }
}

# translate text using mymemmory api
def tr [
  ...search:string  # search query
  --from:string     # from which language you are translating (default english)
  --to:string       # to which language you are translating (default french)
  #
  # Use ISO standar names for the languages, for example:
  # english: en-US
  # spanish: es-ES
  # italian: it-IT
  # swedish: sv-SV
  #
  # More in: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
] {
  if ($search | is-empty) {
    echo-r "no search query provided"
  } else {
    let from = if ($from | is-empty) {"en-US"} else {$from}
    let to = if ($to | is-empty) {"fr-FR"} else {$to}
    let to_translate = ($search | str join "%20")
    let url = $"https://api.mymemory.translated.net/get?q=($to_translate)&langpair=($from)%7C($to)"

    http get $url
    | get responseData
    | get translatedText
  }
}

# Get weather using wttr
def weather [location:string, --json] {
  http get $"https://wttr.in/($location)?format=(if $json {'j1'} else { '3' })"
}

def tolink [name: string] {
  let url = $in
  let pre = "\e]8;;"
  let sp = "\e\\"
  $"($pre)($url)($sp)($name)($pre)($sp)"
}

def "list todos" [] {
  rg "(--|//).? ?TODO" . -n
  | lines | parse "{file}:{line}:{match}" | str trim
  | try {
    group-by file | transpose | reject column1.file | transpose -rid
  } catch {
    "no TODOs found in this directory"
  }
}

# output shortcuts set in config.nu, or use $env.config.keybindings
def "keybindings config" [] {
  open $nu.config-path -r | lines | skip (open $nu.config-path -r | lines | enumerate
  | each {|i| if $i.item =~ "keybindings" {$i.index}} | get 0) | str join "\n"
  | parse -r "[^#].*name: (?P<name>.*)\n.*modifier: (?P<modifier>.*)\n.*keycode: (?P<key>.*)"
}

# get the environment details
def "env details" [] {
  let e = ($env | reject config | transpose key value)
  $e | each { |r|
  let is_envc = ($r.key == ENV_CONVERSIONS)
  let is_closure = ($r.value | describe | str contains 'closure')
  let is_list = ($r.value | describe | str contains 'list')
  if $is_envc {
    echo [[key value];
    [($r.key) ($r.value | transpose key value | each { |ec|
      let to_string = ($ec.value | get to_string | view source $in | nu-highlight)
      let from_string = ($ec.value | get from_string | view source $in | nu-highlight)
      echo ({'ENV_CONVERSIONS': {($ec.key): { 'to_string': ($to_string) 'from_string': ($from_string)}}})
    })]
    ]
  } else if $is_closure {
    let closure_value = (view source ($env | get $r.key) | nu-highlight)
    echo [[key value]; [($r.key) ($closure_value)]]
  } else if $is_list {
    let list_value = ($env | get $r.key | split row (char esep))
    echo [[key value]; [($r.key) ($list_value)]]
  } else {
    echo [[key value]; [($r.key) ($r.value)]]
  }
  }
}

def env [] { env details | flatten }

# example: ["http://tinyurl.com/nushell-gh" "https://bit.ly/1sNZMwL"] | url expand
def "url expand" [$urls:any = []]: [string -> string, list -> table] {
  let urls = ($in | default $urls)
  def expand-link [] {
    http head --redirect-mode manual $in | where name == location | get value.0
  }
  match ($urls | describe) {
    string => { $urls | expand-link }
    $type if ($type =~ list) => { $urls | wrap link | insert expanded {|url| $url.link | expand-link}}
  }
}

def "alternate screen enable" [] { print -ne (ansi -e '?1049h') }
def "alternate screen disable" [] { print -ne (ansi -e '?1049l') }

# Append to the end and beginning of a string.
@example "add backticks" { "test" | str sandwich "`" } --result "`test`"
def "str sandwich" [ append_str: string ]: string -> string {
  $append_str ++ $in ++ $append_str
}

# Convert path to url.
@example "windows" { "C:/test_file.txt" | path url } --result "file:///C:/test%5Ffile.txt"
@example "linux" { "/rust-build-artifacts" | path url } --result "file:///rust%2Dbuild%2Dartifacts"
def "path url" []: [path -> string, list<path> -> list<string>] {
  each { path expand | str replace -a '\' '/' | url encode | $"file://(if $nu.os-info.name == windows {'/'})($in)" }
}

# go up n directories
def --env up [nb: int = 1] {
  let path = (1..($nb) | each {|_| ".."} | reduce {|it, acc| $acc + "\\" + $it})
  cd $path
}

# make and cd into a directory
def --env mcd [name: path] {
  mkdir $name ; cd $name
}

#cd to the folder where a binary is located
def --env which-cd [program] {
  let dir = (which $program | get path | path dirname)
  cd $dir.0
}

# cd with yazi
def --env yy [] {
  # let tmp = $"($env.TEMP)(char path_sep)yazi-cwd." + (random chars -l 6)
  let tmp = mktemp -t "yazi-cwd.XXXXX"
	yazi --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -p $tmp
}

### Standard Library
use std/dirs
