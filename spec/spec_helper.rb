$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'enumerated_constants'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start
