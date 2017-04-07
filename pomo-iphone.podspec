Pod::Spec.new do |spec|
  spec.name                 = 'pomo-iphone'
  spec.version              = '0.0.3'
  spec.license              = { :type => 'Beerware' }
  spec.homepage             = 'https://github.com/pronebird/pomo-iphone'
  spec.authors              = { 'Andrej Mihajlov' => 'and@codeispoetry.ru' }
  spec.summary              = 'Gettext translations for iOS.'
  spec.source               = { :git => 'https://github.com/pronebird/pomo-iphone.git', :tag => '0.0.3', :submodules => true }

  spec.source_files         = 'pomo-iphone/*.{h,m,mm}', 'vendor/muparser/src/*.cpp', 'vendor/muparser/include/*.h'
  spec.exclude_files        = 'vendor/muparser/src/muParserTest.cpp', 'vendor/muparser/src/muParserTest.h'
  spec.private_header_files = 'vendor/muparser/include/*.h'

  spec.framework            = 'Foundation'
  spec.libraries            = 'c++'
  spec.requires_arc         = true
  spec.platform             = :ios, '8.0'

end
