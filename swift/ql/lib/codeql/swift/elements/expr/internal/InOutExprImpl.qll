private import codeql.swift.generated.expr.InOutExpr

module Impl {
  class InOutExpr extends Generated::InOutExpr {
    override string toStringImpl() { result = "&..." }

    override predicate convertsFrom(Expr e) { e = this.getImmediateSubExpr() }
  }
}
