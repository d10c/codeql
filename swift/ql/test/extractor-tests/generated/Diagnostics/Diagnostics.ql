// generated by codegen/codegen.py, do not edit
import codeql.swift.elements
import TestUtils

query predicate instances(
  Diagnostics x, string getText__label, string getText, string getKind__label, int getKind
) {
  toBeTested(x) and
  not x.isUnknown() and
  getText__label = "getText:" and
  getText = x.getText() and
  getKind__label = "getKind:" and
  getKind = x.getKind()
}
