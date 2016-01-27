class NlpService
  attr_reader :sentence

  def initialize(sentence)
    @sentence = sentence.downcase
  end

  def perform
    client = $wit_ai
    client.classify_message(sentence)
  end
end
