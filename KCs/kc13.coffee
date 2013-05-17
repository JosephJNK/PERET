module.exports =
  index: 13
  solutionPattern: '\[(\^.*-|[-\]]{2}.*|(\^[-\]]{1,2}.*)|\^?].*-)]' #please forgive me
  description: 'Within square braces, the metacharacters "^", "]" and "-" follow a specific pritority: to be treated as a metacharacter, "^" must come first.  To be treated as a literal, "]" must come first, or second if "^" is first.  To be treated as a literal, "-" can come first (after "^" if a literal "]" is not being used, and must come last otherwise'
  prerequisites: [7, 8, 10, 11, 12]
