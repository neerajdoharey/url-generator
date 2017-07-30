class Url < ApplicationRecord
  validates :real_url, presence: true, on: :create
  before_create :url_shortner

  ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
  MAX_DIGITS = 10

  def url_cleaner
    self.real_url.downcase.strip.sub %r{^https?:(//|\\\\)(www\.)?}i, ''
  end

  def url_shortner
    self.awesome_url = base62_encode(hash(self.real_url))

    puts "Awesome :#{self.awesome_url}"
  end

  def base62_encode(i)
		return ALPHABET[0] if i == 0
		s = ''
		base = ALPHABET.length
		while i > 0
			s << ALPHABET[i.modulo(base)]
			i /= base
		end
		s.reverse
	end

	def hash(str)
		Digest::SHA1.hexdigest(str).to_i(16) % (ALPHABET.length ** MAX_DIGITS)
  end

  def find_duplicate
    url = url_shortner
    puts url.inspect
    Url.find_by_awesome_url(self.awesome_url)
  end

  def new_url?
    find_duplicate.nil?
  end
end
