import Jay
import Bench

public func run(loop times: Int) -> ([UInt8]) throws -> Void {

  return { input in
    for _ in 0..<times {

      _ = try Jay().jsonFromData(input)
    }
  }
}

let results = try bench(this: run(loop: 1))

describe(benchmark: "czechboy0/Jay", results)

