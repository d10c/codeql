private import codeql.swift.generated.stmt.PoundAssertStmt

module Impl {
  class PoundAssertStmt extends Generated::PoundAssertStmt {
    override string toStringImpl() { result = "#assert ..." }
  }
}
