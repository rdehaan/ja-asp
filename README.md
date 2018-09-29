# JA-ASP
Encodings of Judgment Aggregation (JA) problems into Answer Set Programming (ASP)

For more details on Judgment Aggregation,
we refer to the literature, e.g.:
> Endriss, U. [*Judgment Aggregation*](https://staff.fnwi.uva.nl/u.endriss/pubs/files/EndrissHBCOMSOC2016.pdf). In: F. Brandt, V. Conitzer, U. Endriss, J. Lang, and A. D. Procaccia, editors, [*Handbook of Computational Social Choice*](http://procaccia.info/papers/comsoc.pdf), Cambridge University Press, 2016.

## Table of contents

- [Getting started](#getting-started)
- [Use](#use)
  - [Answer set programming](#answer-set-programming)
  - [Encoding judgment aggregation](#encoding-judgment-aggregation)
  - [Generating all consistent judgment sets](#generating-all-consistent-judgment-sets)
  - [Winner determination](#winner-determination)
  - [Checking agenda properties](#checking-agenda-properties)

## Getting Started

### Prerequisites

This package was developed and tested with [clingo](https://potassco.org/clingo/),
which is part of the [Potsdam Answer Set Solving Collection](https://potassco.org/) -
in particular, with the following version:
```
clingo 5.3.0
```

You need to have [clingo](https://potassco.org/clingo/)
(with python support) installed to run the examples.

### Installing

This package can be installed by simply downloading all files.

For instructions on how to install [clingo](https://potassco.org/clingo/),
see the [potassco web page](https://potassco.org/).

## Use

### Answer set programming

The encodings in this package use the
[ASP-Core-2 language format](https://www.mat.unical.it/aspcomp2013/files/ASP-CORE-2.03c.pdf).

For more details on answer set programming,
we refer to the literature, e.g.:
> Gebser, M., Kaminski, R., Kaufmann, B. and Schaub, T. [*Answer set solving in practice*](https://www.morganclaypool.com/doi/abs/10.2200/S00457ED1V01Y201211AIM019). Synthesis Lectures on Artificial Intelligence and Machine Learning, 6(3), pp. 1-238, 2012.

For several encodings and examples, we use
pottasco's [metasp](https://potassco.org/labs/metasp/) encodings,
that employ the technique of meta-programming.

### Encoding judgment aggregation

#### Agendas

For each issue (propositional variable) `p`, add a fact `issue(p).`
(Note, you can express multiple facts in one line, e.g., `issue(p;q).`)

To express an integrity constraint in CNF, for each clause (`l1` OR `l2` OR `l3`),
where `l1`, `l2` and `l3` are literals, add facts `clause(i,(l1;l2;l3)).`
Here `i` is the unique identifier of the clause (e.g., its number).
E.g., `clause(1,(p;-q;-r)).`

Example:
```
issue(i1;i2;i3;i4;i5).
clause(1,(i3;-i4)).
clause(2,(-i3;i4;-i1)).
clause(3,(-i3;i4;-i2)).
```

#### Auxiliary variables

If you want to use auxiliary variables to express the integrity constraint,
you need to declare each auxiliary variable `a` with a fact `aux(a).`

Example:
```
issue(i1;i2;i3;i4;i5).
aux(a1).
clause(1,(i3;-i4)).
clause(2,(-i3;i4;-i1)).
clause(3,(-i3;i4;-i2;a1)).
clause(3,(-i3;i4;-i2;-a1)).
```

#### Profiles

For each voter `v`, add a fact `voter(v).`
(Note, you can express multiple facts in one line,
e.g., `voter(v1;v2).` or `voter(1..10).`)

For each voter `v` and each issue `p`,
add the voter's judgment on this issue:
`js(v,p).` or `js(v,-p).`

Example:
```
voter(1..17).
js(1..6,(i1;i2;i3;i4;i5)).
js(7..10,(i1;i2;-i3;-i4;i5)).
js(11..17,(-i1;-i2;i3;-i4;-i5)).
```

### Generating all consistent judgment sets

General use (replace `PROFILE`):
```
clingo models.lp PROFILE.lp -Wno-atom-undefined --project -n0
```
Example:
```
clingo models.lp examples/profiles/profile1.lp -Wno-atom-undefined --project -n0
```

### Pretty printing

General use (replace `INPUT`):
```
clingo INPUT pretty-printing.lp --outf=3
```
Example:
```
clingo models.lp examples/profiles/profile1.lp -Wno-atom-undefined --project -n0 pretty-printing.lp --outf=3
```

The module `pretty-printing.lp` works with all encodings of judgment aggregation problems in this package.

### Winner determination

#### Rules with standard encodings

For the following encodings of judgment aggregation rules, one needs to enumerate
all answer sets to get all outcomes:

```
windet/kemeny.lp
windet/kemeny1-graph.lp
windet/kemeny2-graph.lp
windet/majority.lp
windet/msa.lp
windet/quota.lp     % needs definition of #const quota
windet/ra.lp
windet/slater-graph.lp
```

General use (replace `RULE` and `PROFILE`):
```
clingo windet/RULE.lp PROFILE.lp -Wno-atom-undefined --project -n0
```
Example:
```
clingo windet/msa.lp examples/profiles/profile1.lp -Wno-atom-undefined --project -n0
```

<!---Another example, invoking meta-programming:
```
clingo windet/msa.lp examples/profiles/profile1.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
```
--->

In order to use the (uniform) quota rule, you need to specify a value for the
constant `quota`, for example:
```
clingo windet/quota.lp examples/profiles/profile0.lp <(echo "#const quota=2.") -Wno-atom-undefined --project -n0
```

#### Rules with optimization encodings

For the following encodings of judgment aggregation rules, one needs to enumerate
all *optimal* answer sets to get all outcomes:

```
windet/kemeny1-opt.lp
windet/kemeny2-opt.lp
windet/kemeny3-opt.lp
windet/leximax-opt.lp
windet/maxham-opt.lp
windet/mnac-opt.lp
windet/reversal1-opt.lp
windet/reversal2-opt.lp
windet/slater-opt.lp
windet/young-opt.lp
```

General use (replace `RULE` and `PROFILE`):
```
clingo windet/RULE-opt.lp PROFILE.lp --opt-mode=optN -q1 -Wno-atom-undefined --project
```

Example:
```
clingo windet/kemeny1-opt.lp examples/profiles/profile1.lp --opt-mode=optN -q1 -Wno-atom-undefined --project
```

#### Rules with meta-programming encodings

The following encodings of judgment aggregation rules
are based on meta-programming techniques.
For these encodings, one needs to use `reify`, `meta.lp`,
`metaD.lp` and `metaO.lp`,
and one needs to enumerate all answer sets to get all outcomes:

```
windet/kemeny-meta.lp
windet/leximax-meta.lp
windet/maxham-meta.lp
windet/mnac-meta.lp
windet/msa-meta.lp
windet/reversal-meta.lp
windet/slater-meta.lp
windet/young-meta.lp
```

General use (replace `RULE` and `PROFILE`):
```
clingo windet/RULE-meta.lp PROFILE.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```

Example:
```
clingo windet/msa-meta.lp examples/profiles/profile1.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```

### Checking agenda properties

#### Median property

General use (replace `AGENDA`):
```
clingo agenda-properties/mp.lp examples/profiles/AGENDA.lp -Wno-atom-undefined --project -n0
```
Example:
```
clingo agenda-properties/mp.lp examples/profiles/profile1.lp -Wno-atom-undefined --project -n0
```

<!---
Another example, invoking meta-programming:
```
clingo agenda-properties/mp.lp examples/profiles/profile1.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```
--->

#### k-Median property

General use (replace `AGENDA` and `VALUE`):
```
clingo agenda-properties/k-mp.lp AGENDA.lp <(echo "#const k=VALUE.") -Wno-atom-undefined --project -n0
```
Example:
```
clingo agenda-properties/k-mp.lp examples/profiles/profile1.lp <(echo "#const k=2.") -Wno-atom-undefined --project -n0
```
<!---
Another example, invoking meta-programming:
```
clingo agenda-properties/k-mp.lp examples/profiles/profile1.lp <(echo "#const k=2.") -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```
--->

#### Separation

General use (replace `AGENDA`):
```
clingo agenda-properties/separation.lp AGENDA.lp -Wno-atom-undefined --project -n0
```
Example:
```
clingo agenda-properties/separation.lp examples/profiles/profile1.lp -Wno-atom-undefined --project -n0
```
<!---
Another example, invoking meta-programming:
```
clingo agenda-properties/separation.lp exąmples/profiles/profile1.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```
--->

#### Overlapping separation

General use (replace `AGENDA`):
```
clingo agenda-properties/overlapping-separation.lp AGENDA.lp -Wno-atom-undefined --project -n0
```
Example:
```
clingo agenda-properties/overlapping-separation.lp examples/profiles/profile1.lp -Wno-atom-undefined --project -n0
```
<!---
Another example, invoking meta-programming:
```
clingo agenda-properties/overlapping-separation.lp examples/profiles/profile1.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```
--->

#### Total blockedness / path connectedness

TBA

#### Even negatability

TBA

### Checking profile properties

#### Single-crossedness

General use (replace `PROFILE`):
```
clingo profile-properties/unidimensional-alignment.lp PROFILE.lp -Wno-atom-undefined --project -n0
```
Example:
```
clingo profile-properties/unidimensional-alignment.lp examples/profiles/profile0.lp -Wno-atom-undefined --project -n0
```

#### Nearly single-crossedness

Three types of nearly single-crossedness are implemented:
1. Single-crossedness after deleting a minimal number of voters
  - `profile-properties/near-unidimensional-alignment1-*.lp`
2. Single-crossedness after deleting a minimal number of issues
  - `profile-properties/near-unidimensional-alignment2-*.lp`
3. Single-crossedness after deleting a inclusion-minimal set of issues
  - `profile-properties/near-unidimensional-alignment3-meta.lp`

Both optimization encodings (indicated with the suffix `-opt`)
and meta-programming encodings (indicated with the suffix `-meta`)
are available.

General use for **optimization encodings** (replace `PROFILE` and `*`):
```
clingo profile-properties/near-unidimensional-alignment*-opt.lp PROFILE.lp -Wno-atom-undefined --project --opt-mode=optN -q1
```
Example:
```
clingo profile-properties/near-unidimensional-alignment1-opt.lp examples/profiles/profile7.lp -Wno-atom-undefined --project --opt-mode=optN -q1
```

General use for **meta-programming encodings** (replace `PROFILE` and `*`):
```
clingo profile-properties/near-unidimensional-alignment*-meta.lp PROFILE.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```
Example:
```
clingo profile-properties/near-unidimensional-alignment3-meta.lp examples/profiles/profile7.lp -Wno-atom-undefined --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project -n0
```

## Acknowledgments

The encodings in this package are created by
[Ronald de Haan](https://staff.science.uva.nl/r.dehaan/)
and [Marija Slavkovik](http://slavkovik.com/).

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
