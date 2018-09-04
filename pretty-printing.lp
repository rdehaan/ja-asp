%%%
%%% PRETTY PRINT ANSWERS FOR THE DIFFERENT PROBLEMS
%%%

#script (python)

import clingo

def main(prg):

    # removes the first character of a string if this is a '-'
    def removeLeadingNeg(str):
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
        ins = [];
        unidims = [];
        orders = [];
        for atom in m.symbols(shown=True):
            atomstr = str(atom);
            if atomstr[:8] == "judgment":
                judgments += [atomstr[9:-1]];
            if atomstr[:10] == "collective":
                collectives += [atomstr[11:-1]];
            if atomstr[:6] == "assign":
                assigns += [atomstr[7:-1]];
            if atomstr[:7] == "ipart(1":
                iparts1 += [atomstr[8:-1]];
            if atomstr[:7] == "ipart(2":
                iparts2 += [atomstr[8:-1]];
            if atomstr[:2] == "in":
                ins += [atomstr[3:-1]];
            if atomstr[:6] == "unidim":
                unidims += [atomstr[7:-1]];
            if atomstr[:5] == "order":
                orders += [atomstr[6:-1]];
        judgments.sort(key=removeLeadingNeg);
        collectives.sort(key=removeLeadingNeg);
        assigns.sort(key=removeLeadingNeg);
        iparts1.sort(key=removeLeadingNeg);
        iparts2.sort(key=removeLeadingNeg);

        # sort the list of orders
        orderdict = dict();
        for order in orders:
            orderlist = order.split(',');
            orderdict[orderlist[1]] = orderlist[0];
        sortedorder = [];
        for key in sorted(orderdict.iterkeys()):
            sortedorder.append(orderdict[key]);

        # check if the encoding is an optimization version
        optimization = False;
        for atom in m.symbols(atoms=True):
            if str(atom) == "optimization":
                optimization = True;

        # use the generated lists to create output in set notation
        # if we're dealing with an optimization encoding, only print for optimal models
        if (optimization == False) | (m.optimality_proven == True):
          if judgments != []:
              print("Judgment set: { " + ', '.join(map(addSpaceIfNoNeg,judgments)) + " }");
          if collectives != []:
              print("Collective outcome: { " + ', '.join(map(addSpaceIfNoNeg,collectives)) + " }");
          if assigns != []:
              print("Minimally inconsistent assignment: { " + ', '.join(map(addSpaceIfNoNeg,assigns)) + " }");
          if iparts1 != []:
              print("Separation: { " + ', '.join(map(addSpaceIfNoNeg,iparts1)) + " }, { " + ', '.join(map(addSpaceIfNoNeg,iparts2)) + " }");
          if ins != []:
              print("Selected voters: { " + ', '.join(ins) + " }");
          if unidims != []:
              print("Unidimensionally aligned issues: { " + ', '.join(unidims) + " }");
          if orders != []:
              print("Order of voters: " + ', '.join(sortedorder) + ".")

    # solve the given answer set program
    prg.ground([("base", [])])
    result = prg.solve(on_model = on_model);
    # if no answer sets are given, mention this
    if result.satisfiable == False:
        print("No output..");

#end.
