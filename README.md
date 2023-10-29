go-jsonschema-generator
==============================

[![ci](https://github.com/losisin/go-jsonschema-generator/actions/workflows/ci.yaml/badge.svg)](https://github.com/losisin/go-jsonschema-generator/actions/workflows/ci.yaml)
[![codecov](https://codecov.io/gh/losisin/go-jsonschema-generator/graph/badge.svg?token=0QQVCFJH84)](https://codecov.io/gh/losisin/go-jsonschema-generator)
[![Go Report Card](https://goreportcard.com/badge/github.com/losisin/go-jsonschema-generator)](https://goreportcard.com/report/github.com/losisin/go-jsonschema-generator)
[![GitHub release (with filter)](https://img.shields.io/github/v/release/losisin/go-jsonschema-generator)](https://github.com/losisin/go-jsonschema-generator/releases)
[![GoDoc](http://godoc.org/github.com/losisin/go-jsonschema-generator?status.png)](http://godoc.org/github.com/losisin/go-jsonschema-generator)

Basic [json-schema](http://json-schema.org/) generator based on Go types, for easy interchange of Go structures across languages.


Installation
------------

The recommended way to install go-jsonschema-generator

```
go get github.com/mcuadros/go-jsonschema-generator
```

Examples
--------

A basic example:

```go
package main

import (
  "fmt"
  "github.com/mcuadros/go-jsonschema-generator"
)

type EmbeddedType struct {
  Zoo string
}

type Item struct {
  Value string
}

type ExampleBasic struct {
  Foo bool   `json:"foo"`
  Bar string `json:",omitempty"`
  Qux int8
  Baz []string
  EmbeddedType
  List []Item
}

func main() {
  s := &jsonschema.Document{}
  s.Read(&ExampleBasic{})
  fmt.Println(s)
}
```

```json
{
    "$schema": "http://json-schema.org/schema#",
    "type": "object",
    "properties": {
        "Bar": {
            "type": "string"
        },
        "Baz": {
            "type": "array",
            "items": {
                "type": "string"
            }
        },
        "List": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "Value": {
                        "type": "string"
                    }
                },
                "required": [
                    "Value"
                ]
            }
        },
        "Qux": {
            "type": "integer"
        },
        "Zoo": {
            "type": "string"
        },
        "foo": {
            "type": "boolean"
        }
    },
    "required": [
        "foo",
        "Qux",
        "Baz",
        "Zoo",
        "List"
    ]
}
```

License
-------

MIT, see [LICENSE](LICENSE)
