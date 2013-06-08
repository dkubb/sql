# encoding: utf-8

require 'spec_helper'

describe SQL::Generator::Emitter::Literal::String, '#dispatch' do
  include_context 'emitter'

  assert_generates s(:str, %q(echo 'Hello')), %q('echo ''Hello''')
end
