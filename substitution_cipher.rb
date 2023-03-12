# frozen_string_literal: true

module SubstitutionCipher
  # creating Caesar cipher
  module Caesar
    @uppercase_letters = ('A'..'Z').to_a # Uses the range to create the uppercase letters and converts it to an array
    @lowercase_letters = ('a'..'z').to_a # Uses the range to create the lowercase letters and converts it to an array

    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      # This method handles the encryption of the text
      document.to_s.chars.collect { |e| (e.ord + key).chr }.join # just add the key and transform it into chr
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      # This method is responsible for decrypting the encrypted text
      document.to_s.chars.collect { |e| (e.ord - key).chr }.join
    end
  end

  # Creating Permutation Cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      document = document.to_s.chars
      generation = (0..127).to_a.shuffle(random: Random.new(key))
      # Random.new() passing a key to shuffle the nums 0~127
      # Since ASCII is 0~127, we can find "a" to "z" index on shuffled num on generation array by using x.ord
      document.collect do |x|
        generation.at(x.ord).chr
      end.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      document = document.to_s.chars
      generation = (0..127).to_a.shuffle(random: Random.new(key))
      document.collect { |x| generation.index(x.ord).chr }.join
    end
  end
end
