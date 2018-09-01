warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

warn "Please add the relevent label to PR when applicable" if github.pr_labels.empty?

podfile_updated = !git.modified_files.grep(/Podfile/).empty?

# Warning, if Podfile changes
if podfile_updated
  warn "The `Podfile` was updated, Mind the versions!"
end

# Warning, if PR is too bigger than 1500 lines code
warn("Big PR, Ignore if it's Pod Update") if git.lines_of_code > 1500

# Warning, if unit tests not written when diff is more than 20 lines

has_test_added = !git.modified_files.grep(/CascadeKitTests/).empty?


if !(has_test_added) && git.lines_of_code > 20
  warn("No Unit Tests added as part of this PR. Ignore, if test wasn't required for this PR", sticky: false)
end

swiftlint.config_file = '.swiftlint-ci.yml'
swiftlint.binary_path = 'Pods/Swiftlint/swiftlint'
swiftlint.lint_files
swiftlint.lint_files inline_mode: true

["CascadeKit.xcodeproj/project.pbxproj"].each do |project_file|
 	next unless File.file?(project_file)
	File.readlines(project_file).each_with_index do |line, index|
		if line.include?("sourceTree = SOURCE_ROOT;") and line.include?("PBXFileReference")
			warn("Files should be in sync with project structure", file: project_file, line: index+1)
		end
	end
end

#
# Rules:
# - Check to see if any of the modified or added files contains a class which isn't indicated as final (final_class)
# - Check for large files without any // MARK:
# - Check for override methods which only implement super calls. These can be removed.

files_to_check = (git.modified_files + git.added_files).uniq
(files_to_check - %w(Dangerfile)).each do |file|
	next unless File.file?(file)
	# Only check for classes inside swift files
	next unless File.extname(file).include?(".swift")

  	# Will be used to check if we're inside a comment block.
	isCommentBlock = false

	# Will be used to track if we've placed any marks inside our class.
	foundMark = false

	# Collects all disabled rules for this file.
	disabled_rules = []

	filelines = File.readlines(file)
	filelines.each_with_index do |line, index|
		if isCommentBlock
			if line.include?("*/")
				isCommentBlock = false
			end
		elsif line.include?("/*")
			isCommentBlock = true
		elsif line.include?("danger:disable")
			rule_to_disable = line.split.last
			disabled_rules.push(rule_to_disable)
		else
			# Start our custom line checks
			## Check for the usage of final class
			if disabled_rules.include?("final_class") == false and line.include?("class") and not line.include?("final") and not line.include?("func") and not line.include?("//") and not line.include?("protocol")
				warn("Consider using final for this class or use a struct (final_class)", file: file, line: index+1)
			end

			## Check for methods that only call the super class' method
			if line.include?("override") and line.include?("func") and filelines[index+1].include?("super") and filelines[index+2].include?("}")
				warn("Override methods which only call super can be removed", file: file, line: index+3)
			end

			## Check if our line includes a MARK:
			if line.include?("MARK:") and line.include?("//")
				foundMark = true
			end
		end
	end

	## Check wether our file is larger than 200 lines and doesn't include any Marks
	if filelines.count > 200 and foundMark == false
		warn("Consider to place some `MARK:` lines for files over 200 lines big.")
	end
end
