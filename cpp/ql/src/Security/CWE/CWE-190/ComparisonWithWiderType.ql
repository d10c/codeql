/**
 * @name Comparison of narrow type with wide type in loop condition
 * @description Comparisons between types of different widths in a loop
 *              condition can cause the loop to behave unexpectedly.
 * @id cpp/comparison-with-wider-type
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.8
 * @precision high
 * @tags reliability
 *       security
 *       external/cwe/cwe-190
 *       external/cwe/cwe-197
 *       external/cwe/cwe-835
 */

import cpp
import semmle.code.cpp.controlflow.Dominance
import semmle.code.cpp.controlflow.SSA
import semmle.code.cpp.rangeanalysis.SimpleRangeAnalysis

/**
 * C++ references are all pointer width, but the comparison takes place with
 * the pointed-to value
 */
int getComparisonSize(Expr e) {
  if e.getType() instanceof ReferenceType
  then result = e.getType().(ReferenceType).getBaseType().getSize()
  else result = e.getType().getSize()
}

predicate loopVariant(VariableAccess e, Loop loop) {
  exists(SsaDefinition d | d.getAUse(e.getTarget()) = e |
    d.getAnUltimateDefiningValue(e.getTarget()) = loop.getCondition().getAChild*() or
    d.getAnUltimateDefiningValue(e.getTarget()).getEnclosingStmt().getParent*() = loop.getStmt() or
    d.getAnUltimateDefiningValue(e.getTarget()) = loop.(ForStmt).getUpdate().getAChild*()
  )
}

Element friendlyLoc(Expr e) {
  result = e.(Access).getTarget()
  or
  result = e.(Call).getTarget()
  or
  not e instanceof Access and not e instanceof Call and result = e
}

int getComparisonSizeAdjustment(Expr e) {
  if e.getType().(IntegralType).isSigned() then result = 1 else result = 0
}

from Loop l, RelationalOperation rel, VariableAccess small, Expr large
where
  not any(Compilation c).buildModeNone() and
  small = rel.getLesserOperand() and
  large = rel.getGreaterOperand() and
  rel = l.getCondition().getAChild*() and
  forall(Expr conv | conv = large.getConversion*() |
    // We adjust the comparison size in the case of a signed integer type.
    // This is to exclude the sign bit from the comparison that determines if the small type's size is sufficient to hold
    // the value of the larger type determined with range analysis.
    upperBound(conv).log2() > (getComparisonSize(small) * 8 - getComparisonSizeAdjustment(small))
  ) and
  // Ignore cases where the smaller type is int or larger
  // These are still bugs, but you should need a very large string or array to
  // trigger them. We will want to disable this for some applications, but it's
  // very noisy on codebases that started as 32-bit
  small.getExplicitlyConverted().getType().getSize() < 4 and
  // Ignore cases where integer promotion has occurred on /, -, or >> expressions.
  not getComparisonSize(large.(DivExpr).getLeftOperand().getExplicitlyConverted()) <=
    getComparisonSize(small) and
  not getComparisonSize(large.(SubExpr).getLeftOperand().getExplicitlyConverted()) <=
    getComparisonSize(small) and
  not getComparisonSize(large.(RShiftExpr).getLeftOperand().getExplicitlyConverted()) <=
    getComparisonSize(small) and
  // ignore loop-invariant smaller variables
  loopVariant(small, l)
select rel,
  "Comparison between $@ of type " + small.getType().getName() + " and $@ of wider type " +
    large.getType().getName() + ".", friendlyLoc(small), small.toString(), friendlyLoc(large),
  large.toString()
