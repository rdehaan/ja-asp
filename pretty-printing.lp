%%%
%%% PRETTY PRINT ANSWERS FOR THE DIFFERENT PROBLEMS
%%%

#script (python)

import clingo

def main(prg):

    # removes the first character of a string if this is a '-'
    def removeTrailingNeg(str):
        if str[0] == '-':
            return str[1:];
        else:
            return str;

    # adds ' ' to the beginning of a string if the string doesn't begin with '-'
    def addSpaceIfNoNeg(str):
        if str[0] == '-':
            return str;
        else:
            return ' '+str;

    # print a given answer set program
    def on_model(m):

        # collect atoms of the answer set in lists
        judgments = [];
        collectives = [];
        assigns = [];
        iparts1 = [];
        iparts2 = [];
        for atom in m.symbols(shown=True):
            atomstr = str(atom);
            if atomstr[:8] == "judgment":
                judgments += [atomstr[9:-1]];
            if atomstr[:10] == "collective":
                collectives += [atomstr[11:-1]];
            if atomstr[:6] == "assign":
                assigns += [atomstr[7:-1]];
            if atomstr[:6] == "ipart1":
                iparts1 += [atomstr[7:-1]];
            if atomstr[:6] == "ipart2":
                iparts2 += [atomstr[7:-1]];
        judgments.sort(key=removeTrailingNeg);
        collectives.sort(key=removeTrailingNeg);
        assigns.sort(key=removeTrailingNeg);
        iparts1.sort(key=removeTrailingNeg);
        iparts2.sort(key=removeTrailingNeg);

        # use the generated lists to create output in set notation
        if judgments != []:
            print("Judgment set: { " + ', '.join(map(addSpaceIfNoNeg,judgments)) + " }");
        if collectives != []:
            print("Collective outcome: { " + ', '.join(map(addSpaceIfNoNeg,collectives)) + " }");
        if assigns != []:
            print("Minimally inconsistent assignment: { " + ', '.join(map(addSpaceIfNoNeg,assigns)) + " }");
        if iparts1 != []:
            print("Separation: { " + ', '.join(map(addSpaceIfNoNeg,iparts1)) + " }, { " + ', '.join(map(addSpaceIfNoNeg,iparts2)) + " }");

    # solve the given answer set program
    prg.ground([("base", [])])
    result = prg.solve(on_model = on_model);
    # if no answer sets are given, mention this
    if result.satisfiable == False:
        print("No output..");

#end.
