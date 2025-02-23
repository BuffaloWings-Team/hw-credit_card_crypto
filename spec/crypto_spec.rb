# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

cipher = {
  Ceaser: SubstitutionCipher::Caesar,
  Permutation: SubstitutionCipher::Permutation,
  DoubleTransposition: DoubleTranspositionCipher,
  Modern_Symmetric: ModernSymmetricCipher
}

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  cipher.each do |name, modules|
    describe "Using #{name} cipher" do
      it 'should encrypt card information' do
        enc = modules.encrypt(@cc, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        enc = modules.encrypt(@cc, @key)
        dec = modules.decrypt(enc, @key)
        _(dec).must_equal @cc.to_s
      end
    end
  end
end
describe 'generate ModernSymmetricCipher key' do
  it 'should return a valid key' do
    key = ModernSymmetricCipher.generate_new_key
    _(key).wont_be_nil
    _(key.length).must_equal(32)
  end
end
