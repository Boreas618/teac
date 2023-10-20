#include "graph.hpp"

using namespace GRAPH;

template<typename T>
T Node<T>::nodeInfo() { return this->info; }

template<typename T>
NodeSet* Node<T>::succ() { return &this->succs; }

template<typename T>
NodeSet* Node<T>::pred() { return &this->preds; }

template<typename T>
int Node<T>::nodeid() { return this->mykey; }

template<typename T>
int Node<T>::inDegree() {
    int deg = 0;
    return this->preds.size();
}

/* return length of successor list for node n */
template<typename T>
int Node<T>::outDegree() {
    int deg = 0;
    return this->succs.size();
}

template<typename T>
std::vector<Node<T>*>* Graph<T>::nodes() { return &this->mynodes; }

template<typename T>
Node<T>* Graph<T>::addNode(T info) {
    Node<T>* node = new GRAPH::Node<T>(this->nodecount++, info);
    this->mynodes.emplace(node);
    return node;
}

template<typename T>
void Graph<T>::addEdge(Node<T>* from, Node<T>* to) {
    assert(from);
    assert(to);
    assert(from->mygraph == to->mygraph);
    if (goesTo(from, to)) return;
    to->preds.insert(from->mykey);
    from->succs.insert(to->mykey);
}

template<typename T>
void Graph<T>::rmEdge(Node<T>* from, Node<T>* to) {
    assert(from && to);
    to->preds.erase(to->preds.find(from->mykey));
    from->succs.erase(from->succs.find(to->mykey));
}

template<typename T>
bool Graph<T>::goesTo(Node<T>* from, Node<T>* n) { return from->succs.count(n->mykey); }
