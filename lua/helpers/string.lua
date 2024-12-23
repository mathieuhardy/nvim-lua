  function starts_with(s, pattern)
    return string.sub(s, 1, string.len(pattern)) == pattern
  end
