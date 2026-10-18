export def preview-file [path:path] {
  if ($path | path type) == file {
    let type = do -i { open $path | metadata | get content_type } | default ''
    if ($type starts-with 'image') {
      file $path
    } else if ($path ends-with '.nu') {
      open $path | nu-highlight
    } else {
      bat --color=always -pp --line-range :300 $path
    }
  } else if ($path | path type) == dir {
    eza --color always -la -s Name --binary --git --icons --group-directories-first --no-permissions $path
  }
}
