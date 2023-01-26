using Semmle.Util.Logging;
using System.Linq;

namespace Semmle.Autobuild.Shared
{
    /// <summary>
    /// A build rule using make.
    /// </summary>
    public class MakefileBuildRule : IBuildRule<AutobuildOptionsShared>
    {
        public BuildScript Analyse(IAutobuilder<AutobuildOptionsShared> builder, bool auto)
        {
            if (auto)
                builder.Log(Severity.Info, "Attempting to build using Make");

            var makefileDirs = builder.GetFilename("Makefile")
                    .Concat(builder.GetFilename("makefile"))
                    .Concat(builder.GetFilename("GNUmakefile"))
                    .Select(t => (System.IO.Path.GetDirectoryName(t.Item1), t.Item2))
                    .Where(t => t.Item1 is not null)
                    .OrderBy(t => t.Item2)
                    .Select(t => t.Item1)
                    .Distinct();

            if (!makefileDirs.Any())
                return BuildScript.Failure;

            return makefileDirs.Select(workingDirectory =>
                (
                    new CommandBuilder(builder.Actions, workingDirectory).
                        RunCommand("make").
                        Script
                    |
                    new CommandBuilder(builder.Actions, workingDirectory).
                        RunCommand("nmake").
                        Script
                )
                &
                BuildScript.Create(_ =>
                {
                    builder.Log(Severity.Info, $"Successfully built with make");
                    return 0;
                })
            ).Aggregate(BuildScript.Failure, (ss, s) => ss | s);
        }
    }
}
