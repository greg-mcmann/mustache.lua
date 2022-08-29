return {
  {
    name = "Basic Behavior",
    desc = "The greater-than operator should expand to the named partial.",
    data = {},
    template = "\"{{>text}}\"",
    partials = {
      text = "from partial"
    },
    expected = "\"from partial\""
  },
  {
    name = "Failed Lookup",
    desc = "The empty string should be used when the named partial is not found.",
    data = {},
    template = "\"{{>text}}\"",
    partials = {},
    expected = "\"\""
  },
  {
    name = "Context",
    desc = "The greater-than operator should operate within the current context.",
    data = {
      text = "content"
    },
    template = "\"{{>partial}}\"",
    partials = {
      partial = "*{{text}}*"
    },
    expected = "\"*content*\""
  },
  {
    name = "Recursion",
    desc = "The greater-than operator should properly recurse.",
    data = {
      content = "X",
      nodes = {
        {
          content = "Y",
          nodes = {}
        }
      }
    },
    template = "{{>node}}",
    partials = {
      node = "{{content}}<{{#nodes}}{{>node}}{{/nodes}}>"
    },
    expected = "X<Y<>>"
  },
  {
    name = "Surrounding Whitespace",
    desc = "The greater-than operator should not alter surrounding whitespace.",
    data = {},
    template = "| {{>partial}} |",
    partials = {
      partial = "\t|\t"
    },
    expected = "| \t|\t |"
  },
  {
    name = "Inline Indentation",
    desc = "Whitespace should be left untouched.",
    data = {
      data = "|"
    },
    template = "  {{data}}  {{> partial}}\n",
    partials = {
      partial = ">\n>"
    },
    expected = "  |  >\n>\n"
  },
  {
    name = "Standalone Line Endings",
    desc = "\"\\r\\n\" should be considered a newline for standalone tags.",
    data = {},
    template = "|\r\n{{>partial}}\r\n|",
    partials = {
      partial = ">"
    },
    expected = "|\r\n>|"
  },
  {
    name = "Standalone Without Previous Line",
    desc = "Standalone tags should not require a newline to precede them.",
    data = {},
    template = "  {{>partial}}\n>",
    partials = {
      partial = ">\n>"
    },
    expected = "  >\n  >>"
  },
  {
    name = "Standalone Without Newline",
    desc = "Standalone tags should not require a newline to follow them.",
    data = {},
    template = ">\n  {{>partial}}",
    partials = {
      partial = ">\n>"
    },
    expected = ">\n  >\n  >"
  },
  {
    name = "Standalone Indentation",
    desc = "Each line of the partial should be indented before rendering.",
    data = {
      content = "<\n->"
    },
    template = "\\\n {{>partial}}\n/\n",
    partials = {
      partial = "|\n{{{content}}}\n|\n"
    },
    expected = "\\\n |\n <\n->\n |\n/\n"
  },
  {
    name = "Padding Whitespace",
    desc = "Superfluous in-tag whitespace should be ignored.",
    data = {
      boolean = true
    },
    template = "|{{> partial }}|",
    partials = {
      partial = "[]"
    },
    expected = "|[]|"
  }
}