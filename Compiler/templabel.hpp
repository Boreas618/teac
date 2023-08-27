#ifndef __TEMPLABEL
#define __TEMPLABEL
#include <string>
#include <vector>
// using std::string;
// using std::to_string;
class labelManager {
public:
  labelManager() { labelno = 1; }
  std::string newlabel() {
    int ret = labelno;
    labelno++;
    return "AaBbcCL" + std::to_string(ret);
  }

private:
  int labelno;
};
std::string Temp_newlabel_front();
typedef std::string Temp_label_front;
typedef std::vector<Temp_label_front> Temp_LabelList_front;
#endif