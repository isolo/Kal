Pod::Spec.new do |s|
	s.name = "Kal"
	s.version = "1.0.0"
	s.summary = "Kal - a calendar component for the iPhone"

	s.homepage = "https://github.com/klazuka/Kal"
	s.author = { "Keith Lazuka" => "klazuka@gmail.com" }

	s.platform = :ios, '6.0'
	s.requires_arc = true

	s.source = { :git => "https://github.com/isolo/Kal.git" }
	s.source_files = 'src', '*.{h,m}'
	s.resource = 'src/Kal.bundle'
	s.public_header_files = '*.h'
	s.prefix_header_file = 'src/Kal_Prefix.pch'
end
