PERET
=====

Intelligent tutoring system to teach Posix extended regular expressions

PERET is intended to provide students with a testbed for practicing Posix style regular expressions, such as those used in sed, grep, and awk's extended modes.  It is a step based tutoring system with simulation aspects, allowing students to see the result of their solution's execution on a sample data set with each step.

PERET was started as a term project and is currently in an early stage of development.  Regex cross compilation is about half-finished, and tweaks may continue to the compiler's intermediate JSON representation of the expressions.  Problems are minimal and hand-coded, and the automatic decomposition of problems into steps is naieve.  Future work will focus on finishing the cross compiler, and generating problems based on the intermediate representation form used by the compiler, enabling easier problem entry and generation.

The learner and pedagogical modules are currently nonexistant, and the syntax used for knowledge components needs a complete overhaul.

License
=====
MIT
