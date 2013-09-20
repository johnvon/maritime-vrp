//  Created by Alberto Santini on 18/09/13.
//  Copyright (c) 2013 Alberto Santini. All rights reserved.
//

#ifndef BB_NODE_H
#define BB_NODE_H

#include <base/base.h>
#include <base/graph.h>
#include <base/problem.h>
#include <column/column.h>
#include <column/column_pool.h>

class BBNode {
public:
    /*  In this BBNode, we will work on graphs in local_prob, that are a modified version of the
        original graphs in prob. We will use the graphs in prob when we have to add the columns
        to the global pool of columns. The columns we add will have a reference to the original
        Problem object, so that all columns generated by all BBNodes share the same reference.
        The local problem is used as a starting point to manipulate the graphs and is then passed
        on to the eventual children of this node. */
    const Problem&  prob;
    Problem         local_prob;
    
    /*  Here we have the global pool of columns, pool, and the local one - that is a subpool from
        which we deleted all the columns that are not compatible with the local restrictions at 
        the current node, i.e. unite_rules and separate_rules. We use the global pool as we will
        add the new columns to it. As a start for this BBNode, we will use the local_pool that has
        been passed to us by the parent node, as it has less columns than the global one. Of course,
        one needs to remember to add the new columns to this pool as well before eventually passing
        it to the children of this node. */
    ColumnPool&     pool;
    ColumnPool      local_pool;

    VisitRuleList   unite_rules;
    VisitRuleList   separate_rules;
    
    PortDuals       port_duals;
    VcDuals         vc_duals;
    
    
    BBNode(const Problem& prob,
           const Problem local_prob,
           ColumnPool& pool,
           const ColumnPool local_pool,
           const VisitRuleList unite_rules,
           const VisitRuleList separate_rules,
           const PortDuals port_duals,
           const VcDuals vc_duals);
    
    void populate_pool();
    
private:
    void make_local_graphs();
    void copy_compatible_columns();
    void generate_nrc_columns();
};

#endif