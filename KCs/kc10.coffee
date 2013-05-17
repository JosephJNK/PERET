module.exports =
  index: 10
  solutionPattern: /\[[.*?+$(\\{]]/
  description: 'Metacharacters lose their meaning inside of square brackets, with the exception of the following: (depending on their position) "-", "]", and "^"'
  prerequisites: [7, 12, 13]
