# ja-asp
Encodings of Judgment Aggregation (JA) problems into Answer Set Programming (ASP)

## Getting Started

### Prerequisites

This package was developed and tested with [clingo](https://potassco.org/clingo/)
(from the [Potsdam Answer Set Solving Collection (potassco)](https://potassco.org/)).
In particular, with the following version:
```
clingo 5.3.0
```

### Installing

[TODO]

## Use

### Encoding

#### Agendas

For each issue (propositional variable) `p`, add a fact `issue(p).`
(Note, you can express multiple facts in one line, e.g., `issue(p;q).`)

To express an integrity constraint in CNF, for each clause (`l1` OR `l2` OR `l3`),
where `l1`, `l2` and `l3` are literals, add facts `clause(i,(l1;l2;l3)).`
E.g., `clause(1,(p;-q;-r)).`
Here `i` is the unique identifier of the clause (e.g., its number).

Example:
```
issue(i1;i2;i3;i4;i5).
clause(1,(i3;-i4)).
clause(2,(-i3;i4;-i1)).
clause(3,(-i3;i4;-i2)).
```

#### Profiles

For each voter `v`, add a fact `voter(v).`
(Note, you can express multiple facts in one line,
e.g., `voter(v1;v2).` or `voter(1..10).`)

For each voter `v` and each issue `p`,
add the voters judgment on this issue:
`js(v,p).` or `js(v,-p).`

Example:
```
voter(1..17).
js(1..6,(i1;i2;i3;i4;i5)).
js(7..10,(i1;i2;-i3;-i4;i5)).
js(11..17,(-i1;-i2;i3;-i4;-i5)).
```

### Winner determination

#### Rules with standard encodings

For the following encodings of judgment aggregation rules, one needs to enumerate
all answer sets to get all outcomes:

```
windet/majority.lp
windet/msa.lp
windet/quota.lp
windet/ra.lp
```

General use:
```
clingo ja.lp windet/windet.lp windet/RULE-opt.lp PROFILE.lp -n 0
```

Example:
```
clingo ja.lp windet/windet.lp windet/msa.lp examples/profiles/profile1.lp -n 0
```
Another example:
```
clingo ja.lp windet/windet.lp windet/quota.lp examples/profiles/profile0.lp <(echo "#const quota=2.") -n 0
```
Yet another example, invoking meta-programming, where possible duplicate answer sets are removed:
```
clingo ja.lp windet/windet.lp windet/msa.lp examples/profiles/profile1.lp --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
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

General use:
```
clingo ja.lp windet/windet.lp windet/RULE-opt.lp PROFILE.lp --opt-mode=optN
```

Example:
```
clingo ja.lp windet/windet.lp windet/kemeny1-opt.lp examples/profiles/profile1.lp --opt-mode=optimization
```

#### Rules with meta-programming encodings

The following encodings of judgment aggregation rules
are based on meta-programming techniques.
For these encodings, one needs to use `reify`, `meta.lp`,
`metaD.lp` and `metaO.lp`,
and one needs to enumerate all answer sets to get all outcomes:

```
windet/kemeny-meta.lp
windet/msa-meta.lp
windet/reversal-meta.lp
windet/slater-meta.lp
```

General use:
```
clingo ja.lp windet/windet.lp windet/RULE-meta.lp PROFILE.lp --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
```

Example:
```
clingo ja.lp windet/windet.lp windet/msa-meta.lp examples/profiles/profile1.lp --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
```

### Checking agenda properties

#### Median property
Example:
```
clingo ja.lp agenda-properties/mp.lp examples/profiles/profile1.lp -n 0
```
Another example, invoking meta-programming, where possible duplicate answer sets are removed:
```
clingo ja.lp agenda-properties/mp.lp examples/profiles/profile1.lp --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
```

#### k-Median property
Example:
```
clingo ja.lp agenda-properties/k-mp.lp examples/profiles/profile1.lp <(echo "#const k=2.") -n 0
```
Another example, invoking meta-programming, where possible duplicate answer sets are removed:
```
clingo ja.lp agenda-properties/k-mp.lp examples/profiles/profile1.lp <(echo "#const k=2.") --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
```

#### Separation
Example:
```
clingo ja.lp agenda-properties/separation.lp examples/profiles/profile1.lp -n 0
```
Another example, invoking meta-programming, where possible duplicate answer sets are removed:
```
clingo ja.lp agenda-properties/separation.lp examples/profiles/profile1.lp --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
```

#### Overlapping separation
Example:
```
clingo ja.lp agenda-properties/overlapping-separation.lp examples/profiles/profile1.lp -n 0
```
Another example, invoking meta-programming, where possible duplicate answer sets are removed:
```
clingo ja.lp agenda-properties/overlapping-separation.lp examples/profiles/profile1.lp --pre | reify | clingo - meta.lp metaD.lp metaO.lp -Wno-atom-undefined --project 0
```

#### Total blockedness / path connectedness

#### Even negatability

## License

This project is licensed under [TODO].
