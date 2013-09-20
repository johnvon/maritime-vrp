//  Created by Alberto Santini on 18/09/13.
//  Copyright (c) 2013 Alberto Santini. All rights reserved.
//

#ifndef HEURISTICS_SOLVER_H
#define HEURISTICS_SOLVER_H

#include <base/base.h>
#include <base/graph.h>
#include <column/solution.h>
#include <preprocessing/program_params.h>
#include <subproblem/labelling.h>

class HeuristicsSolver {
public:
    const ProgramParams&  params;
    const Graph&          g;
    
    HeuristicsSolver(const ProgramParams& params, const Graph& g) : params(params), g(g) {}
    
    vector<Solution> solve_fast_forward() const;
    vector<Solution> solve_fast_backward() const;
    vector<Solution> solve_on_reduced_graph(const float lambda) const;
};

#endif