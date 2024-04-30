setup:
	rm -rf Example.xcodeproj
	rm -rf outputs
	mkdir outputs

xcodegen:
	mint run yonaskolb/XcodeGen@2.40.1

xcodebuild:
	xcodebuild \
		-project Example.xcodeproj \
		-scheme "ModuleA" \
		-destination generic/platform=MacOS \
		clean build \
		> outputs/xcodebuild.log

swiftlint: setup xcodegen xcodebuild
	mint run realm/SwiftLint@0.54.0 analyze --compiler-log-path outputs/xcodebuild.log