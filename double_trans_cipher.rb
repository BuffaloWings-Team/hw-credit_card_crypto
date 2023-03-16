# frozen_string_literal: true

# Encrypts and Decrypts document with a key using a transposition cipher
module DoubleTranspositionCipher
  def self.matrix_size(text)
    text = text.to_s.split('')
    Math.sqrt(text.size).ceil
  end

  def self.plaintext(text, size)
    text = text.to_s.split('')
    text.each_slice(size).to_a
  end

  def self.rowchunk(chunks, rows)
    row_chunk = []
    chunks.each_with_index do |_element, index|
      row_chunk << chunks[rows[index]]
    end
    row_chunk
  end

  def self.colchunk2(row_chunk, ind, chunks, rows, col_chunk)
    row_chunk[ind] << '*' until row_chunk[ind].length == chunks[0].length
    row_chunk[ind].each_with_index do |_element, index|
      col_chunk[ind][index] = row_chunk[ind][rows[index]]
    end
    col_chunk
  end

  def self.colchunk(chunks, matrix_size, row_chunk, rows)
    col_chunk = Array.new(matrix_size) { Array.new(matrix_size) }
    (0..chunks[0].length - 1).each do |i|
      col_chunk = colchunk2(row_chunk, i, chunks, rows, col_chunk)
    end
    col_chunk
  end

  #   def self.sortchunk(chunks, row_chunk, rows, col_chunk)
  #     (0..chunks[0].length - 1).each do |i|
  #       row_chunk[i] << '*' until row_chunk[i].length == chunks[0].length
  #       row_chunk[i].each_with_index do |_element, index|
  #         col_chunk[i][index] = row_chunk[i][rows[index]]
  #       end
  #     end
  #   end

  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    matrix_size = matrix_size(document)

    # 2. break plaintext into evenly sized blocks
    chunks = plaintext(document, matrix_size)

    # 3. sort rows in predictibly random way using key as seed
    rows = (0..chunks.size - 1).to_a.shuffle(random: Random.new(key.to_i))
    row_chunk = rowchunk(chunks, rows)

    # 4. sort columns of each row in predictibly random way
    col_chunk = colchunk(chunks, matrix_size, row_chunk, rows)

    # 5. return joined cyphertext
    col_chunk.to_a.join('')
  end

  def self.create_matrix(text)
    row_col_size = Math.sqrt(text.size).ceil
    matrix = text.chars.each_slice(row_col_size).to_a
    [row_col_size, matrix]
  end

  def self.unshuffle(matrix, random:)
    transformed_order = (0...matrix.length).to_a.shuffle!(random: random)
    matrix.sort_by.with_index { |_, i| transformed_order[i] }
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    _row_col_size, matrix = create_matrix(ciphertext)
    sort_rows = unshuffle(matrix, random: Random.new(key.to_i))
    sort_columns = sort_rows.map do |s|
      unshuffle(s, random: Random.new(key.to_i))
    end
    sort_columns.map(&:join).join('').delete('*')
  end
end
