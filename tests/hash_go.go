package main

import "fmt"
import "os"
import "log"
import "bufio"
import "strings"
import "strconv"

func main() {
	var line string
	var data map[string][]uint16
	data = make(map[string][]uint16)

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		line = scanner.Text()
		if !strings.HasPrefix(line, "valid-data:") {
			continue
		}
		tokens := strings.Split(line, " ")
		key := strings.Trim(tokens[1], "\"")

		/*
		   https://github.com/golang/go/issues/27522

		   The signature of strconv.ParseUint is func ParseUint(s string, base
		   int, bitSize int) (uint64, error) – and it can only have that
		   single signature; Go doesn't have function overloading. The bitSize
		   argument limits the range of values, it doesn't affect the return
		   type. Use an explicit type conversion if you need a type other than
		   uint64.
		*/
		number, _ := strconv.ParseUint(tokens[3], 10, 16)

		_, ok := data[key]
		if ok {
			data[key] = append(data[key], uint16(number))
		} else {
			data[key] = make([]uint16, 1)
		}

	}

	if err := scanner.Err(); err != nil {
		log.Println(err)
	}

	//fmt.Println("ok")
	fmt.Print(len(data), ",")
}
