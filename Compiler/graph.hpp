#pragma once

#include <unordered_map>
#include <iostream>
#include <set>
#include <vector>


namespace GRAPH {

template<typename T> class Graph;
template<typename T> struct Node;
typedef std::set<int> NodeSet;

template<typename T>
struct Node {
    int mykey;
    NodeSet succs;
    NodeSet preds;
    T info;

    Node() {}
    Node(int _mykey, T _info)
        : mykey(_mykey)
        , info(_info) {
        succs = NodeSet();
        preds = NodeSet();
    }

    T nodeInfo();
    NodeSet* succ();
    NodeSet* pred();
    int nodeid();
    int outDegree();
    int inDegree();
};

template<typename T>
class Graph {
public:
    std::vector<Node<T>*> mynodes;
    int nodecount;
    Graph() {
        nodecount = 0;
        mynodes = std::vector<Node<T>*>();
    }
    ~Graph() {
        for (auto& i : mynodes) delete i;
    }
    void clear() {
        for (auto& i : mynodes) delete i;
        mynodes.clear();
        nodecount = 0;
    }
    /* Make a new node in graph "g", with associated "info" */
    Node<T>* addNode(T info);

    /* Get the list of nodes belonging to "g" */
    std::vector<Node<T>*>* nodes();

    /* Make a new edge joining nodes "from" and "to", which must belong
        to the same graph */
    void addEdge(Node<T>* from, Node<T>* to);

    /* Delete the edge joining "from" and "to" */
    void rmEdge(Node<T>* from, Node<T>* to);

    /* Tell if there is an edge from "from" to "to" */
    bool goesTo(Node<T>* from, Node<T>* n);
};
}  // namespace GRAPH
