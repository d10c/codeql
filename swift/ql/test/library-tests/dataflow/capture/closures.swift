func sink<T>(_ value: T) { print("sink:", value) }
func source<T>(_ label: String, _ value: T) -> T { return value }
func taint<T>(_ label: String, _ value: T) -> T { return value }

func hello() -> String {
  let value = "Hello world!"
  return source("hello", value)
}

func captureList() {
  let y: Int = source("captureList", 123);
  { [x = hello()] () in
     sink(x) // $ MISSING: hasValueFlow=hello
     sink(y) // $ MISSING: hasValueFlow=captureList
  }()
}

var escape: (() -> Int)? = nil

func setEscape() {
  let x = source("setEscape", 0)
  escape = {
    sink(x) // $ MISSING: hasValueFlow=setEscape
    return x + 1
  }
}

func callEscape() {
  setEscape()
  sink(escape?()) // $ MISSING: hasTaintFlow=setEscape
}

func logical() -> Bool {
  let f: ((Int) -> Int)? = { x in
    sink(x) // $ hasValueFlow=logical
    return x + 1
  }

  let x: Int? = source("logical", 42)
  return f != nil
      && (x != nil
          && f!(x!) == 43)
}

func asyncTest() {
  func withCallback(_ callback: @escaping (Int) async -> Int) {
    @Sendable
    func wrapper(_ x: Int) async -> Int {
      return await callback(x + 1) // $ MISSING: hasValueFlow=asyncTest
    }
    Task {
      print("asyncTest():", await wrapper(source("asyncTest", 40)))
    }
  }
  withCallback { x in
    x + 1 // $ MISSING: hasTaintFlow=asyncTest
  }
}

func foo() -> Int {
  var x = 1
  let f = { y in x += y }
  x = source("foo", 41)
  let r = { x }
  sink(r()) // $ MISSING: hasValueFlow=foo
  f(1)
  return r() // $ MISSING: hasTaintFlow=foo
}

func bar() -> () -> Int {
  var x = 1
  let f = { y in x += y }
  x = source("bar", 41)
  let r = { x }
  f(1)
  return r // constantly 42
}

var g: ((Int) -> Void)? = nil
func baz() -> () -> Int {
  var x = 1
  g = { y in x += y }
  x = source("baz", 41)
  let r = { x }
  g!(1)
  return r
}

func sharedCapture() -> Int {
  let (incrX, getX) = {
    var x = source("sharedCapture", 0)
    return ({ x += 1 }, { x })
  }()

  let doubleIncrX = {
    incrX()
    incrX()
  }

  sink(getX()) // $ MISSING: hasValueFlow=sharedCapture
  doubleIncrX()
  sink(getX()) // $ MISSING: hasTaintFlow=sharedCapture
  doubleIncrX()
  return getX()
}

func sharedCaptureMultipleWriters() {
  var x = 123

  let callSink1 = { sink(x) } // $ MISSING: hasValueFlow=setter1
  let callSink2 = { sink(x) } // $ MISSING: hasValueFlow=setter2

  let makeSetter = { y in
    let setter = { x = y }
    return setter
  }

  let setter1 = makeSetter(source("setter1", 1))
  let setter2 = makeSetter(source("setter2", 2))

  setter1()
  callSink1()

  setter2()
  callSink2()
}

func taintCollections(array: inout Array<Int>) {
  array[0] = source("array", 0)
  sink(array)
  sink(array[0]) // $ hasValueFlow=array
  array.withContiguousStorageIfAvailable({
    buffer in
    sink(array)
    sink(array[0]) // $ hasValueFlow=array
  })
}

func simplestTest() {
  let x = source("simplestTest", 0)
  sink(x) // $ hasValueFlow=simplestTest
}

func main() {
  print("captureList():")
  captureList() // Hello world! 123

  print("callEscape():")
  callEscape() // 1

  print("logical():", logical()) // true

  print("asyncTest():")
  asyncTest() // 42

  print("foo():", foo()) // 42

  let a = bar()
  let b = baz()

  print("bar():", a(), a()) // $ MISSING: hasTaintFlow=bar

  print("baz():", b(), b()) // $ MISSING: hasTaintFlow=baz

  g!(1)
  print("g!(1):", b(), b()) // $ MISSING: hasTaintFlow=baz

  print("sharedCapture():", sharedCapture()) // 4

  print("sharedCaptureMultipleWriters():")
  sharedCaptureMultipleWriters() // 42, -1
}

main()
