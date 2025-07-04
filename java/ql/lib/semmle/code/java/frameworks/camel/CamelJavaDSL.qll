/**
 * Provides classes and predicates for the Apache Camel Java DSL.
 *
 * Apache Camel allows "routes" to be defined in Java, using a chained DSL syntax. For example:
 *
 * ```
 * public class MyRouteBuilder extends RouteBuilder {
 *   public void configure() {
 *     from("direct.start").bean(TargetBean.class);
 *   }
 * }
 * ```
 *
 * This creates a route to the `TargetBean` class for messages sent to "direct.start".
 */
overlay[local?]
module;

import java
import semmle.code.java.Reflection
import semmle.code.java.frameworks.spring.Spring

/**
 * A method call to a ProcessorDefinition element.
 */
class ProcessorDefinitionElement extends MethodCall {
  ProcessorDefinitionElement() {
    this.getMethod()
        .getDeclaringType()
        .getSourceDeclaration()
        .hasQualifiedName("org.apache.camel.model", "ProcessorDefinition")
  }
}

/**
 * A declaration of a "to" target in the Apache Camel Java DSL.
 *
 * This declares a "target" for this route, described by the URI given as the first argument.
 */
class CamelJavaDslToDecl extends ProcessorDefinitionElement {
  CamelJavaDslToDecl() { this.getMethod().hasName("to") }

  /**
   * Gets the URI specified by this `to` declaration.
   */
  string getUri() { result = this.getArgument(0).(CompileTimeConstantExpr).getStringValue() }
}

/**
 * A declaration of a "bean" target in the Apache Camel Java DSL.
 *
 * This declares a bean to call for this route. The bean is defined either by a Class<?> reference,
 * or the bean object itself.
 */
class CamelJavaDslBeanDecl extends ProcessorDefinitionElement {
  CamelJavaDslBeanDecl() { this.getMethod().hasName("bean") }

  /**
   * Gets a bean class that may be registered as a target by this `bean()` declaration.
   */
  RefType getABeanClass() {
    if this.getArgument(0).getType() instanceof TypeClass
    then
      // In this case, we've been given a Class<?>, which implies a Spring Bean of this type
      // should be loaded. Infer the type of type parameter.
      result = inferClassParameterType(this.getArgument(0))
    else
      // In this case, the object itself is used as the target for the Apache Camel messages.
      result = this.getArgument(0).getType()
  }
}

/**
 * A declaration of a "beanRef" target in the Apache Camel Java DSL.
 *
 * This declares a reference to a bean that should be called for this route. The interpretation of
 * the bean reference is dependent on which registries are used by Apache Camel, but we make the
 * assumption that it either represetns a qualified name, or a Srping bean identifier.
 */
class CamelJavaDslBeanRefDecl extends ProcessorDefinitionElement {
  CamelJavaDslBeanRefDecl() { this.getMethod().hasName("beanRef") }

  /**
   * Gets the string describing the bean referred to.
   */
  string getBeanRefString() {
    result = this.getArgument(0).(CompileTimeConstantExpr).getStringValue()
  }

  /**
   * Gets a class that may be referred to by this bean reference.
   */
  RefType getABeanClass() {
    exists(SpringBean bean | bean.getBeanIdentifier() = this.getBeanRefString() |
      result = bean.getClass()
    )
    or
    result.getQualifiedName() = this.getBeanRefString()
  }
}

/**
 * A "method" Camel expression in the Apache Camel Java DSL.
 *
 * An expression that represents a call to a bean, or particular method on a bean.
 */
class CamelJavaDslMethodDecl extends MethodCall {
  CamelJavaDslMethodDecl() {
    this.getMethod()
        .getDeclaringType()
        .getSourceDeclaration()
        .hasQualifiedName("org.apache.camel.builder", "ExpressionClause") and
    this.getMethod().hasName("method")
  }

  /**
   * Gets a possible bean that this "method" expression represents.
   */
  RefType getABean() {
    if this.getArgument(0).getType() instanceof TypeString
    then
      exists(SpringBean bean |
        bean.getBeanIdentifier() = this.getArgument(0).(CompileTimeConstantExpr).getStringValue()
      |
        result = bean.getClass()
      )
    else
      if this.getArgument(0).getType() instanceof TypeClass
      then result = inferClassParameterType(this.getArgument(0))
      else result = this.getArgument(0).getType()
  }
}
