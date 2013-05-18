module.exports =
  statement: "containing the string 'ab' or 'ib'"
  solution: 'ab|bc'
  hits: [
    'abba'
    'cab'
    'glib'
    'bib'
    'ibix'
  ]
  misses: [
    'bag'
    'cb'
    'aBc'
    'bob'
    'b'
  ]
  alternation: [
    {
      statement: "containing the string 'ab'"
      solution: 'ab'
    }
    {
      statement: "containing the string 'ib'"
      solution: 'ib'
    }
  ]

