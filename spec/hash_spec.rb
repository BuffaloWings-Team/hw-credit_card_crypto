# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    it 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      cards1 = cards.map(&:hash_secure)
      cards2 = cards.map(&:hash_secure)
      cards1 == cards2
    end

    it 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      cards.map(&:hash) == cards.map(&:hash).uniq
    end
  end
end

describe 'Test cryptographic hashing' do
  it 'Check hashes are consistently produced' do
    # TODO: Check that each card produces the same hash if hashed repeatedly
    cards1 = cards.map(&:hash_secure)
    cards2 = cards.map(&:hash_secure)
    cards1 == cards2
  end

  it 'Check for unique hashes' do
    # TODO: Check that each card produces a different hash than other cards
    cards.map(&:hash) == cards.map(&:hash).uniq
  end

  it 'Check regular hash not same as cryptographic hash' do
    # TODO: Check that each card's hash is different from its hash_secure
    cards.map do |cc|
      hash1 = cc.hash
      hash2 = cc.hash_secure
      hash1 != hash2
    end
  end
end
