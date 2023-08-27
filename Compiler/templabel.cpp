#include "singleton.hpp"
#include "templabel.hpp"
#include <string>
using std::string;
using std::string;
string Temp_newlabel_front() { return Singleton::instance().LabelManager.newlabel(); }