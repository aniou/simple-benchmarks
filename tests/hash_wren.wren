
import "io" for Stdin, Stdout

var data = {}
var fiber = Fiber.new {
  var tokens
  var key
  var line
  var number

  while (true) {
     line = Stdin.readLine()
     tokens = line.split(" ")
     if (tokens[0] == "valid-data:") {
       key = tokens[1].trim("\"")
       number = Num.fromString(tokens[3])
       if (!data.containsKey(key)) {
         data[key] = [number]
       } else {
         data[key].add(number)
       }
     }
  }
}

var error = fiber.try()

if (error == "Stdin was closed.") {
  //System.printAll(data)
  System.write(data.count)
  System.write(",")
} else {
  System.print("Caught error: " + error)
}
