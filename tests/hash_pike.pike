#! /usr/bin/env pike

int main(int argc, array(string) argv) {
  mapping(string:array(int)) data = ([]);
  string key;
  array tokens;
  int number;

  while(string s=Stdio.stdin.gets()) {
    if (s[0..10] != "valid-data:") continue;
    tokens = s / " ";
    key = tokens[1] - "\"";
    sscanf(tokens[3], "%d", number);
    if (zero_type(data[key])) {
        data[key] = ({ number });
    } else {
        data[key] = data[key] + ({number});
    }
  }
  
  /*
  foreach (indices(data), key) {
    write(key + ": [");
    foreach (data[key], number) {
       write(number + ", ");
    }
    write("]\n");
  }
  */

  write(sprintf("%d,", sizeof(data)));
}
