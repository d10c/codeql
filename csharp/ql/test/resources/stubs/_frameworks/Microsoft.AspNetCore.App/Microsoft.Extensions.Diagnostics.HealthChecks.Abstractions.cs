// This file contains auto-generated code.
// Generated from `Microsoft.Extensions.Diagnostics.HealthChecks.Abstractions, Version=9.0.0.0, Culture=neutral, PublicKeyToken=adb9793829ddae60`.
namespace Microsoft
{
    namespace Extensions
    {
        namespace Diagnostics
        {
            namespace HealthChecks
            {
                public sealed class HealthCheckContext
                {
                    public HealthCheckContext() => throw null;
                    public Microsoft.Extensions.Diagnostics.HealthChecks.HealthCheckRegistration Registration { get => throw null; set { } }
                }
                public sealed class HealthCheckRegistration
                {
                    public HealthCheckRegistration(string name, Microsoft.Extensions.Diagnostics.HealthChecks.IHealthCheck instance, Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus? failureStatus, System.Collections.Generic.IEnumerable<string> tags) => throw null;
                    public HealthCheckRegistration(string name, Microsoft.Extensions.Diagnostics.HealthChecks.IHealthCheck instance, Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus? failureStatus, System.Collections.Generic.IEnumerable<string> tags, System.TimeSpan? timeout) => throw null;
                    public HealthCheckRegistration(string name, System.Func<System.IServiceProvider, Microsoft.Extensions.Diagnostics.HealthChecks.IHealthCheck> factory, Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus? failureStatus, System.Collections.Generic.IEnumerable<string> tags) => throw null;
                    public HealthCheckRegistration(string name, System.Func<System.IServiceProvider, Microsoft.Extensions.Diagnostics.HealthChecks.IHealthCheck> factory, Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus? failureStatus, System.Collections.Generic.IEnumerable<string> tags, System.TimeSpan? timeout) => throw null;
                    public System.TimeSpan? Delay { get => throw null; set { } }
                    public System.Func<System.IServiceProvider, Microsoft.Extensions.Diagnostics.HealthChecks.IHealthCheck> Factory { get => throw null; set { } }
                    public Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus FailureStatus { get => throw null; set { } }
                    public string Name { get => throw null; set { } }
                    public System.TimeSpan? Period { get => throw null; set { } }
                    public System.Collections.Generic.ISet<string> Tags { get => throw null; }
                    public System.TimeSpan Timeout { get => throw null; set { } }
                }
                public struct HealthCheckResult
                {
                    public HealthCheckResult(Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus status, string description = default(string), System.Exception exception = default(System.Exception), System.Collections.Generic.IReadOnlyDictionary<string, object> data = default(System.Collections.Generic.IReadOnlyDictionary<string, object>)) => throw null;
                    public System.Collections.Generic.IReadOnlyDictionary<string, object> Data { get => throw null; }
                    public static Microsoft.Extensions.Diagnostics.HealthChecks.HealthCheckResult Degraded(string description = default(string), System.Exception exception = default(System.Exception), System.Collections.Generic.IReadOnlyDictionary<string, object> data = default(System.Collections.Generic.IReadOnlyDictionary<string, object>)) => throw null;
                    public string Description { get => throw null; }
                    public System.Exception Exception { get => throw null; }
                    public static Microsoft.Extensions.Diagnostics.HealthChecks.HealthCheckResult Healthy(string description = default(string), System.Collections.Generic.IReadOnlyDictionary<string, object> data = default(System.Collections.Generic.IReadOnlyDictionary<string, object>)) => throw null;
                    public Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus Status { get => throw null; }
                    public static Microsoft.Extensions.Diagnostics.HealthChecks.HealthCheckResult Unhealthy(string description = default(string), System.Exception exception = default(System.Exception), System.Collections.Generic.IReadOnlyDictionary<string, object> data = default(System.Collections.Generic.IReadOnlyDictionary<string, object>)) => throw null;
                }
                public sealed class HealthReport
                {
                    public HealthReport(System.Collections.Generic.IReadOnlyDictionary<string, Microsoft.Extensions.Diagnostics.HealthChecks.HealthReportEntry> entries, System.TimeSpan totalDuration) => throw null;
                    public HealthReport(System.Collections.Generic.IReadOnlyDictionary<string, Microsoft.Extensions.Diagnostics.HealthChecks.HealthReportEntry> entries, Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus status, System.TimeSpan totalDuration) => throw null;
                    public System.Collections.Generic.IReadOnlyDictionary<string, Microsoft.Extensions.Diagnostics.HealthChecks.HealthReportEntry> Entries { get => throw null; }
                    public Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus Status { get => throw null; }
                    public System.TimeSpan TotalDuration { get => throw null; }
                }
                public struct HealthReportEntry
                {
                    public HealthReportEntry(Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus status, string description, System.TimeSpan duration, System.Exception exception, System.Collections.Generic.IReadOnlyDictionary<string, object> data) => throw null;
                    public HealthReportEntry(Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus status, string description, System.TimeSpan duration, System.Exception exception, System.Collections.Generic.IReadOnlyDictionary<string, object> data, System.Collections.Generic.IEnumerable<string> tags = default(System.Collections.Generic.IEnumerable<string>)) => throw null;
                    public System.Collections.Generic.IReadOnlyDictionary<string, object> Data { get => throw null; }
                    public string Description { get => throw null; }
                    public System.TimeSpan Duration { get => throw null; }
                    public System.Exception Exception { get => throw null; }
                    public Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus Status { get => throw null; }
                    public System.Collections.Generic.IEnumerable<string> Tags { get => throw null; }
                }
                public enum HealthStatus
                {
                    Unhealthy = 0,
                    Degraded = 1,
                    Healthy = 2,
                }
                public interface IHealthCheck
                {
                    System.Threading.Tasks.Task<Microsoft.Extensions.Diagnostics.HealthChecks.HealthCheckResult> CheckHealthAsync(Microsoft.Extensions.Diagnostics.HealthChecks.HealthCheckContext context, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken));
                }
                public interface IHealthCheckPublisher
                {
                    System.Threading.Tasks.Task PublishAsync(Microsoft.Extensions.Diagnostics.HealthChecks.HealthReport report, System.Threading.CancellationToken cancellationToken);
                }
            }
        }
    }
}
